// Source fingerprint MW-WMA-2026-8d573e4b | Copyright (c) 2026 Michael Wiedeck.
// Deterministic integration test of the REAL Nicht kleckern! game script.
'use strict';
const assert = require('node:assert/strict');
const fs = require('node:fs');
const path = require('node:path');
const vm = require('node:vm');

const script = fs.readFileSync(path.join(__dirname, '..', 'assets', 'mini-apps.js'), 'utf8');

function createGame() {
  const nodes = new Map(), pending = new Map(), store = new Map();
  let time = 0, frameId = 0;

  function element(id, dataset={}) {
    if(nodes.has(id))return nodes.get(id);
    const node = {
      id, dataset, attrs:{}, textContent:'', disabled:false, styles:{},
      classes:new Set(), listeners:new Map(),
      style:{setProperty(k,v){node.styles[k]=String(v)}},
      classList:{
        toggle(k,on){if(on)node.classes.add(k);else node.classes.delete(k)},
        remove(k){node.classes.delete(k)},
        contains(k){return node.classes.has(k)}
      },
      setAttribute(k,v){node.attrs[k]=String(v)},
      addEventListener(k,fn){const list=node.listeners.get(k)||[];list.push(fn);node.listeners.set(k,list)},
      setPointerCapture(){},focus(){},
      fire(k,extra={}){
        const event={pointerId:1,preventDefault(){},...extra};
        for(const fn of node.listeners.get(k)||[])fn(event);
      }
    };
    nodes.set(id,node);
    return node;
  }

  for(const id of ['main-action','coffee','coffee-foam','coffee-sheen','cup','cup-scene','left','level','sensor-btn','best','status','restart-app'])element(id);
  const left=element('steer-left',{steer:'-1'});
  const right=element('steer-right',{steer:'1'});
  const document={
    body:{dataset:{game:'nicht-kleckern'}},
    getElementById:id=>nodes.get(id)||null,
    querySelectorAll:selector=>selector==='[data-steer]'?[left,right]:[],
    addEventListener(){}
  };
  const random=Object.create(Math);random.random=()=>.5; // No random wind.
  vm.runInNewContext(script,{
    document,
    navigator:{},
    window:{addEventListener(){}},
    Math:random,
    performance:{now:()=>time},
    requestAnimationFrame(callback){pending.set(++frameId,callback);return frameId},
    cancelAnimationFrame(id){pending.delete(id)},
    localStorage:{
      getItem:key=>store.get(key)??null,
      setItem:(key,value)=>store.set(key,String(value))
    }
  });

  function advance(milliseconds) {
    for(let elapsed=0;elapsed<milliseconds;elapsed+=16){
      time+=16;
      const batch=[...pending.values()];
      pending.clear();
      for(const callback of batch)callback(time);
    }
  }
  function state(){
    return {
      leftStream:nodes.get('cup-scene').classList.contains('spilling-left'),
      rightStream:nodes.get('cup-scene').classList.contains('spilling-right'),
      percent:Number.parseInt(nodes.get('level').textContent,10),
      cupAngle:Number.parseFloat(nodes.get('cup').styles['--cup-angle']),
      liquidPath:nodes.get('coffee').attrs.d
    };
  }
  return {
    action:nodes.get('main-action'),
    left,right,advance,state,nodes
  };
}

const upright=createGame();
upright.action.fire('click');
upright.advance(5500);
assert.equal(upright.state().percent,100,'Upright cup must not lose coffee');
assert.equal(upright.state().leftStream,false);
assert.equal(upright.state().rightStream,false);

for(const [side,expectedStream,oppositeStream] of [
  ['left','leftStream','rightStream'],
  ['right','rightStream','leftStream']
]){
  const game=createGame();
  game.action.fire('click');
  game[side].fire('pointerdown');
  let sawCorrect=false,sawOpposite=false;
  for(let index=0;index<350;index++){
    game.advance(16);
    sawCorrect ||= game.state()[expectedStream];
    sawOpposite ||= game.state()[oppositeStream];
  }
  assert.ok(sawCorrect,side+' tilt must spill over its own edge');
  assert.ok(!sawOpposite,side+' tilt must not spill from the opposite edge');
  assert.ok(game.state().percent<100,side+' overflow must reduce the level');
  const beforeReset=game.state().percent;
  assert.ok(beforeReset>=0&&beforeReset<=100);
  game.action.fire('click'); // New round always resets fluid and scores.
  assert.equal(game.state().percent,100,'Restart must refill the cup');
  assert.equal(game.state().leftStream,false,'Restart must remove left stream');
  assert.equal(game.state().rightStream,false,'Restart must remove right stream');
}

const waveTest=createGame();
waveTest.action.fire('click');
waveTest.right.fire('pointerdown');
waveTest.advance(1200);
const pathBefore=waveTest.state().liquidPath;
waveTest.right.fire('pointerup');
waveTest.left.fire('pointerdown');
waveTest.advance(1200);
assert.notEqual(waveTest.state().liquidPath,pathBefore,'The liquid surface must be reshaped as direction changes');
assert.ok(!/NaN|undefined/.test(waveTest.state().liquidPath),'Liquid path must be valid SVG geometry');

console.log('Nicht kleckern!: upright / left / right / overflow / refill / dynamic surface passed.');
