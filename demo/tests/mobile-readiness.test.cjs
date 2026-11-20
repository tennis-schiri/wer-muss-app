// Source fingerprint MW-WMA-2026-8d573e4b | Copyright (c) 2026 Michael Wiedeck.
'use strict';
// Small, deterministic smoke tests for the five shared JavaScript demos.
// No external packages or browser emulation required; also check mobile layout.
const fs=require('node:fs');
const path=require('node:path');
const vm=require('node:vm');
const assert=require('node:assert/strict');
const root=path.resolve(__dirname,'..');
const read=p=>fs.readFileSync(path.join(root,p),'utf8');
const source=read('assets/mini-apps.js');
const phoneCSS=read('assets/phone-frames.css');
const frames=['punktlandung','fingerchaos','nicht-kleckern','nur-noch-einmal','voellig-daneben'];
assert.match(phoneCSS,/max-width:\s*600px/);
assert.match(phoneCSS,/body\[data-game\] \.device-viewport\s*\{[^}]*overflow:visible/s);
assert.match(phoneCSS,/body\[data-game\] \.device-phone\s*\{[^}]*aspect-ratio:auto/s);
assert.match(phoneCSS,/body\[data-game="nicht-kleckern"\] \[data-steer\][^{]*\{[^}]*touch-action:none/s);
assert.match(phoneCSS,/body\[data-game="nur-noch-einmal"\] \.hold-button[^{]*\{[^}]*touch-action:none/s);
assert.match(source,/Math\.max\(44,66-score\)/);
assert.match(source,/safetyGap/);
assert.match(source,/renderRound\(false\)/);
const wm=read('apps/wer-muss/index.html');
assert.match(wm,/wmRealPhone/);
assert.match(wm,/classList\.add\('wm-fullscreen'\)/);
assert.match(wm,/touch-action:none/);
for(const slug of frames){
  const html=read('apps/'+slug+'/index.html');
  assert.match(html,/<meta name="viewport"/);
  assert.match(html,/class="device-viewport"/);
  assert.match(html,/id="restart-app"/);
  assert.match(html,/href="\.\.\/\.\.\/index\.html"/);
  assert.match(html,/assets\/language\.js/);
}
assert.match(read('apps/punktlandung/index.html'),/inputmode="decimal"/);

function createGame(game){
  let time=0,frameId=0;
  const elements=new Map(),scheduled=new Map(),focused=[];
  function create(id,dataset={}){
    if(elements.has(id))return elements.get(id);
    const el={
      id,dataset,disabled:false,hidden:false,textContent:'',value:'',checked:false,
      clientWidth:320,clientHeight:280,offsetWidth:66,offsetHeight:66,
      listeners:new Map(),attrs:{},styles:{},classes:new Set(),
      style:{
        setProperty(k,v){el.styles[k]=v},
        get left(){return el.styles.left},set left(v){el.styles.left=v},
        get top(){return el.styles.top},set top(v){el.styles.top=v},
        get width(){return el.styles.width},set width(v){el.styles.width=v},
        get height(){return el.styles.height},set height(v){el.styles.height=v}
      },
      classList:{toggle(k,on){if(on)el.classes.add(k);else el.classes.delete(k)},remove(k){el.classes.delete(k)}},
      addEventListener(k,fn){const list=el.listeners.get(k)||[];list.push(fn);el.listeners.set(k,list)},
      setAttribute(k,v){el.attrs[k]=String(v)},
      setPointerCapture(){},
      focus(){focused.push(id)},
      fire(k,extra={}){for(const cb of el.listeners.get(k)||[])cb({pointerId:1,preventDefault(){},...extra})}
    };
    elements.set(id,el);return el;
  }
  const opts={
    '[data-target]':[5,10,15].map(x=>create('preset-'+x,{target:String(x)})),
    '[data-steer]':[create('steer-l',{steer:'-1'}),create('steer-r',{steer:'1'})],
    '[data-players]':[2,3,4].map(x=>create('players-'+x,{players:String(x)}))
  };
  const ids=[
    'restart-app','clock','main-action','best','difference','blind','custom-target',
    'custom-target-row','status','score','left','tap-target','tap-trap','tap-zone',
    'coffee','coffee-foam','coffee-sheen','cup','cup-scene','level','sensor-btn',
    'balloon','hold','points','risk','reset','question','player-label','guess',
    'submit-guess','reveal','round','scores','next'
  ];
  ids.forEach(id=>create(id));
  const saved=new Map();
  const document={
    body:{dataset:{game}},
    getElementById:create,
    querySelectorAll:query=>opts[query]||[],
    addEventListener(){}
  };
  vm.runInNewContext(source,{
    document,window:{location:{reload(){}},addEventListener(){}},navigator:{},
    localStorage:{
      getItem:key=>saved.get(key)||null,
      setItem:(key,value)=>saved.set(key,String(value))
    },
    performance:{now:()=>time},
    requestAnimationFrame:fn=>{scheduled.set(++frameId,fn);return frameId},
    cancelAnimationFrame:id=>scheduled.delete(id),
    setInterval:()=>1,clearInterval(){},
    Math
  });
  return {create,focused,advance(ms){time+=ms},options:opts};
}

for(const slug of frames){
  const game=createGame(slug),el=game.create;
  assert.equal(game.focused.length,0,'Do not open the mobile keyboard on initial load: '+slug);
  if(slug==='punktlandung'){
    el('custom-target').value='7,5';
    el('custom-target').fire('input');
    el('main-action').fire('click');
    game.advance(7500);
    el('main-action').fire('click');
    assert.match(String(el('difference').textContent),/0,00/);
  }else if(slug==='fingerchaos'){
    el('main-action').fire('click');
    el('tap-target').fire('click');
    el('tap-trap').fire('click');
  }else if(slug==='nicht-kleckern'){
    el('main-action').fire('click');
    el('steer-l').fire('pointerdown');
  }else if(slug==='nur-noch-einmal'){
    el('hold').fire('pointerdown');
    el('hold').fire('pointerup');
  }else {
    el('guess').value='10';
    el('submit-guess').fire('click');
    el('guess').value='20';
    el('submit-guess').fire('click');
    el('next').fire('click');
  }
}
console.log('Five mobile demos: initialization, controls, input and responsive layout passed; Wer muss fullscreen configured.');
