/* Source fingerprint MW-WMA-2026-8d573e4b | Copyright (c) 2026 Michael Wiedeck. All rights reserved. */
(() => {
  'use strict';
  const game = document.body.dataset.game;
  const $ = id => document.getElementById(id);
  const fmt = n => n.toFixed(2).replace('.', ',');
  const clamp = (n,a,b) => Math.min(b,Math.max(a,n));
  const remember = (k,v) => { try { localStorage.setItem('wm-mini-'+k,String(v)); } catch (_) {} };
  const recall = k => { try { return Number(localStorage.getItem('wm-mini-'+k)) || 0; } catch (_) { return 0; } };
  const status = s => { const el=$('status'); if(el) el.textContent=s; };
  // Always reset active timers, scores and controls; persistent personal bests remain.
  $('restart-app')?.addEventListener('click', () => window.location.reload());

  if(game === 'punktlandung') {
    const clock=$('clock'), action=$('main-action'), best=$('best'), diff=$('difference'), blind=$('blind');
    const customInput=$('custom-target'), customRow=$('custom-target-row');
    const options=[...document.querySelectorAll('[data-target]')];
    let target=10, usingCustom=false, start=0, running=false, animation=0, bestGap=Infinity;
    const formatTarget=value=>value.toFixed(1).replace('.',',');
    // Accept German or English decimal separators. Reject more than one fractional digit.
    function parseCustom() {
      const value=customInput.value.trim();
      if(!/^\d{1,3}(?:[.,]\d)?$/.test(value)) return null;
      const parsed=Number(value.replace(',','.'));
      return Number.isFinite(parsed)&&parsed>=.1&&parsed<=999.9 ? parsed : null;
    }
    function showBest(){const v=recall('punktlandung-'+target);best.textContent=v>0?fmt(v)+' s':'–';}
    function showTarget(){status('Stoppe die Zeit möglichst genau bei '+formatTarget(target)+' Sekunden.');}
    function markSelection(){
      for(const option of options) {
        const selected=!usingCustom&&Number(option.dataset.target)===target;
        option.classList.toggle('active',selected);
        option.setAttribute('aria-pressed',String(selected));
      }
      customRow.classList.toggle('active',usingCustom);
      customInput.setAttribute('aria-invalid',String(usingCustom&&parseCustom()===null));
    }
    function resetReadout(){
      clock.textContent='00,00';
      diff.textContent='–';
      action.textContent='STARTEN';
    }
    function setCustom(format=false){
      if(running)return;
      usingCustom=true;
      const next=parseCustom();
      if(next===null){
        best.textContent='–';
        status('Bitte eine Zielzeit zwischen 0,1 und 999,9 Sekunden mit maximal einer Nachkommastelle eingeben.');
      }else{
        target=next;
        if(format)customInput.value=formatTarget(target);
        showBest();
        showTarget();
      }
      resetReadout();
      markSelection();
    }
    function render(){
      const t=(performance.now()-start)/1000;
      clock.textContent=blind.checked?'••,••':fmt(t);
      if(running)animation=requestAnimationFrame(render);
    }
    function stop(){
      running=false;
      cancelAnimationFrame(animation);
      const elapsed=(performance.now()-start)/1000, gap=Math.abs(elapsed-target);
      clock.textContent=fmt(elapsed);
      diff.textContent=fmt(gap)+' s';
      status(gap<.05?'Volltreffer! Unglaublich präzise.':gap<.25?'Ganz knapp! Noch eine Runde?':'Knapp vorbei. Versuch es noch einmal!');
      if(gap<bestGap)bestGap=gap;
      const old=recall('punktlandung-'+target);
      if(old===0||gap<old){remember('punktlandung-'+target,gap);showBest();}
      options.forEach(option=>option.disabled=false);
      customInput.disabled=false;
      action.textContent='NOCHMAL STARTEN';
    }
    action.addEventListener('click',()=>{
      if(running){stop();return;}
      if(usingCustom){
        const custom=parseCustom();
        if(custom===null){
          setCustom();
          customInput.focus();
          return;
        }
        target=custom;
        customInput.value=formatTarget(target);
      }
      running=true;
      start=performance.now();
      diff.textContent='–';
      status('Warte auf den richtigen Moment …');
      action.textContent='STOPP!';
      options.forEach(option=>option.disabled=true);
      customInput.disabled=true;
      render();
    });
    for(const option of options){
      option.addEventListener('click',()=>{
        if(running)return;
        usingCustom=false;
        target=Number(option.dataset.target);
        markSelection();
        resetReadout();
        showBest();
        showTarget();
      });
    }
    customInput.addEventListener('focus',()=>setCustom());
    customInput.addEventListener('input',()=>setCustom());
    customInput.addEventListener('blur',()=>{if(usingCustom)setCustom(true);});
    customInput.addEventListener('keydown',event=>{
      if(event.key==='Enter'){
        event.preventDefault();
        customInput.blur();
      }
    });
    document.addEventListener('keydown',event=>{
      if(event.code==='Space'&&!(event.target instanceof HTMLInputElement)){
        event.preventDefault();
        action.click();
      }
    });
    showBest();
    markSelection();
  }

  if(game === 'fingerchaos') {
    const area=$('tap-zone'), good=$('tap-target'), bad=$('tap-trap'), action=$('main-action'), scoreEl=$('score'), left=$('left'), best=$('best');
    let active=false,score=0,ends=0,timer=null;best.textContent=recall('fingerchaos');
    function place(node,other){
      const w=area.clientWidth,h=area.clientHeight;
      const radius=Math.max(22,(node.offsetWidth||66)/2);
      const margin=Math.min(40,Math.max(radius+4,26));
      const minX=Math.min(margin,w/2),minY=Math.min(margin,h/2);
      const otherX=other&&Number.parseFloat(other.style.left);
      const otherY=other&&Number.parseFloat(other.style.top);
      const safetyGap=radius+(other?.offsetWidth||66)/2+13;
      let x=minX,y=minY;
      for(let attempt=0;attempt<24;attempt++){
        x=minX+Math.random()*Math.max(0,w-2*minX);
        y=minY+Math.random()*Math.max(0,h-2*minY);
        if(!Number.isFinite(otherX)||!Number.isFinite(otherY)
          ||Math.hypot(x-otherX,y-otherY)>=safetyGap)break;
        if(attempt===23){
          // The wrong circle must not hide the right one on a small screen.
          x=otherX<w/2?w-minX:minX;
          y=otherY<h/2?h-minY:minY;
        }
      }
      node.style.left=x+'px';node.style.top=y+'px';
    }
    function end(){active=false;clearInterval(timer);timer=null;good.hidden=true;bad.hidden=true;action.textContent='NEUE RUNDE';status('Zeit abgelaufen! '+score+' Punkte.');if(score>recall('fingerchaos')){remember('fingerchaos',score);best.textContent=score;}}
    function tick(){const sec=Math.max(0,(ends-performance.now())/1000);left.textContent=sec.toFixed(1).replace('.',',')+' s';if(sec<=0)end();}
    action.addEventListener('click',()=>{clearInterval(timer);active=true;score=0;scoreEl.textContent='0';ends=performance.now()+20000;action.textContent='NEU STARTEN';status('Tippe MINT. Meide KORALLE!');good.hidden=false;bad.hidden=false;place(good,bad);place(bad,good);timer=setInterval(tick,80);tick();});
    good.addEventListener('click',()=>{if(!active)return;score++;scoreEl.textContent=score;good.style.width=good.style.height=Math.max(44,66-score)+'px';place(good,bad);place(bad,good);});
    bad.addEventListener('click',()=>{if(!active)return;score=Math.max(0,score-2);scoreEl.textContent=score;status('Falscher Kreis: −2 Punkte!');place(bad,good);});
    good.hidden=true;bad.hidden=true;left.textContent='20,0 s';
  }

  if(game === 'nicht-kleckern') {
    const action=$('main-action'), coffee=$('coffee'), foam=$('coffee-foam'), sheen=$('coffee-sheen');
    const cup=$('cup'), cupScene=$('cup-scene'), left=$('left'), level=$('level'), sensor=$('sensor-btn');
    let active=false, remaining=100, tilt=0, velocity=0, wind=0, input=0, gamma=null;
    let started=0, last=0, raf=0, windAt=0;
    // Spring-damped inertial motion gives the liquid its own momentum.
    let wave=0, waveVelocity=0, previousTilt=0;
    let best=recall('nicht-kleckern');
    $('best').textContent=best?Math.round(best)+' %':'–';

    function surfaceState() {
      // All coordinates are in the cup interior's 100x100 SVG viewBox.
      // At 100% remaining the cup looks about 80% full, with a realistic air gap.
      const baseY=100-remaining*.8;
      // A world-level liquid surface slopes in the opposite direction to the cup.
      const rise=Math.tan(tilt*Math.PI/180)*50+wave;
      const leftY=baseY+rise, rightY=baseY-rise;
      const lipY=4; // The inside of the rim, NOT the top of the decorative cup.
      return {
        leftY,rightY,
        overLeft:Math.max(0,lipY-leftY),
        overRight:Math.max(0,lipY-rightY)
      };
    }

    function updateLiquid(dt) {
      const rotationSpeed=(tilt-previousTilt)/Math.max(dt,.008);
      previousTilt=tilt;
      // Faster changes excite a small oscillating wave. It decays when balanced.
      waveVelocity+=(-27*wave-6.2*waveVelocity+1.25*rotationSpeed)*dt;
      wave=clamp(wave+waveVelocity*dt,-14,14);

      const surface=surfaceState();
      // Only liquid *above* the corresponding rim can escape. As volume drops,
      // the liquid level descends and an unchanged tilt eventually stops spilling.
      const over=surface.overLeft+surface.overRight;
      if(over>0) {
        const rate=over*(.92+Math.min(.7,Math.abs(rotationSpeed)/130));
        remaining=clamp(remaining-rate*dt,0,100);
      }
    }

    function render() {
      cup.style.setProperty('--cup-angle',tilt.toFixed(2)+'deg');
      const state=surfaceState();
      const crest=clamp(waveVelocity*.1,-4,4);
      const {leftY,rightY,overLeft,overRight}=state;
      // A gently curved, continuously redrawn free surface; the coffee itself
      // is NOT rotated as one rigid rectangle with the ceramic cup.
      const upper='M 0 '+leftY.toFixed(2)
        +' C 25 '+(leftY+crest).toFixed(2)
        +' 75 '+(rightY-crest).toFixed(2)
        +' 100 '+rightY.toFixed(2);
      coffee.setAttribute('d',upper+' L 100 104 L 0 104 Z');
      foam.setAttribute('d',upper);
      const shineLeft=leftY+(rightY-leftY)*.1+10;
      const shineRight=leftY+(rightY-leftY)*.35+10;
      sheen.setAttribute('d','M 10 '+shineLeft.toFixed(2)
        +' Q 23 '+((shineLeft+shineRight)/2-2).toFixed(2)
        +' 35 '+shineRight.toFixed(2));

      const spillingLeft=active&&overLeft>.4&&remaining>0;
      const spillingRight=active&&overRight>.4&&remaining>0;
      cupScene.classList.toggle('spilling-left',spillingLeft);
      cupScene.classList.toggle('spilling-right',spillingRight);
      cupScene.classList.toggle('coffee-sloshing',active&&Math.abs(wave)>3);
      cupScene.style.setProperty('--spill-left-alpha',clamp(overLeft/8,.35,1).toFixed(2));
      cupScene.style.setProperty('--spill-right-alpha',clamp(overRight/8,.35,1).toFixed(2));
      level.textContent=Math.round(remaining)+' %';
    }

    function done() {
      active=false;
      cancelAnimationFrame(raf);
      render(); // Stop streams and droplets after the round ends.
      action.textContent='NOCHMAL BALANCIEREN';
      status('Geschafft! '+Math.round(remaining)+' % Kaffee gerettet.');
      if(remaining>best) {
        best=remaining;
        remember('nicht-kleckern',best);
        $('best').textContent=Math.round(best)+' %';
      }
    }
    function tick(now) {
      if(!active)return;
      const dt=clamp((now-last)/1000,.001,.06);
      last=now;
      if(now-windAt>1200) {wind=Math.random()*2-1;windAt=now;}
      const device=gamma!==null?clamp(gamma/32,-1,1):0;
      velocity=(velocity+((wind*.48)+(input*1.1)+(device*.7))*dt*17)*.95;
      tilt=clamp(tilt+velocity*dt*18,-26,26);
      updateLiquid(dt);
      const seconds=Math.max(0,20-(now-started)/1000);
      left.textContent=seconds.toFixed(1).replace('.',',')+' s';
      render();
      if(seconds<=0||remaining<=0){done();return;}
      raf=requestAnimationFrame(tick);
    }
    action.addEventListener('click',()=>{
      cancelAnimationFrame(raf);
      active=true;
      remaining=100;
      tilt=velocity=wind=wave=waveVelocity=previousTilt=0;
      started=last=performance.now();
      windAt=0;
      left.textContent='20,0 s';
      action.textContent='RUNDE NEU STARTEN';
      status('Gegensteuern! Halte die Tasse möglichst gerade.');
      render();
      raf=requestAnimationFrame(tick);
    });
    document.querySelectorAll('[data-steer]').forEach(btn=>{
      const value=Number(btn.dataset.steer);
      const on=e=>{e.preventDefault();input=value;try{btn.setPointerCapture(e.pointerId);}catch(_){}};
      const off=()=>{if(input===value)input=0;};
      btn.addEventListener('pointerdown',on);
      btn.addEventListener('pointerup',off);
      btn.addEventListener('pointercancel',off);
      btn.addEventListener('lostpointercapture',off);
    });
    document.addEventListener('keydown',e=>{if(e.code==='ArrowLeft')input=-1;if(e.code==='ArrowRight')input=1;});
    document.addEventListener('keyup',e=>{if((e.code==='ArrowLeft'&&input===-1)||(e.code==='ArrowRight'&&input===1))input=0;});
    sensor.addEventListener('click',async()=>{
      if(!('DeviceOrientationEvent' in window)){status('Kein Bewegungssensor verfügbar. Pfeiltasten nutzen.');return;}
      try {
        if(typeof DeviceOrientationEvent.requestPermission==='function') {
          const p=await DeviceOrientationEvent.requestPermission();
          if(p!=='granted'){status('Sensorsperre aktiv. Du kannst die Pfeiltasten nutzen.');return;}
        }
        window.addEventListener('deviceorientation',e=>{if(typeof e.gamma==='number')gamma=e.gamma;});
        sensor.disabled=true;
        sensor.textContent='SENSOR AKTIV';
        status('Bewegungssensor aktiviert. Alternativ Pfeile nutzen.');
      } catch (_) {status('Sensor nicht verfügbar. Pfeiltasten funktionieren trotzdem.');}
    });
    render();
  }

    if(game === 'nur-noch-einmal') {
    const balloon=$('balloon'),hold=$('hold'),points=$('points'),risk=$('risk'),best=$('best');
    let size=1,held=false,start=0,frames=0,bank=0,potential=0;
    best.textContent=recall('nur-noch-einmal');
    function render(){balloon.style.setProperty('--balloon-size',size);risk.textContent=potential;points.textContent=bank;}
    function reset(){size=1;potential=0;render();}
    function pump(now){if(!held)return;const dt=Math.min((now-start)/1000,.06);start=now;size=Math.min(2.5,size+dt*.42);potential=Math.round(Math.pow(size-1,1.5)*120);render();
      if(Math.random()<Math.max(0,size-1.17)*dt*.2||size>=2.5){held=false;status('PLATZ! Die '+potential+' möglichen Punkte sind weg.');reset();return;}
      frames=requestAnimationFrame(pump);
    }
    function begin(e){if(held)return;e.preventDefault();held=true;start=performance.now();status('Je größer, desto riskanter …');try{hold.setPointerCapture(e.pointerId);}catch(_){}frames=requestAnimationFrame(pump);}
    function release(){if(!held)return;held=false;cancelAnimationFrame(frames);bank+=potential;if(bank>recall('nur-noch-einmal')){remember('nur-noch-einmal',bank);best.textContent=bank;}status('Gerettet: +'+potential+' Punkte. Noch eine Runde?');reset();}
    hold.addEventListener('pointerdown',begin);hold.addEventListener('pointerup',release);hold.addEventListener('pointercancel',release);hold.addEventListener('lostpointercapture',release);hold.addEventListener('contextmenu',e=>e.preventDefault());
    $('reset').addEventListener('click',()=>{held=false;cancelAnimationFrame(frames);bank=0;reset();status('Neue Serie gestartet. Finger gedrückt halten und rechtzeitig loslassen.');});
    render();
  }

  if(game === 'voellig-daneben') {
    const questions=[
      {q:'Wie viele Sekunden hat ein ganzer Tag?',a:86400,u:'Sekunden'},
      {q:'Wie viele Felder hat ein klassisches Schachbrett?',a:64,u:'Felder'},
      {q:'Wie viele Minuten hat eine Woche?',a:10080,u:'Minuten'},
      {q:'Wie viele Augen haben alle sechs Seiten eines normalen Würfels zusammen?',a:21,u:'Augen'},
      {q:'Wie viele Meter ist die klassische Marathonstrecke lang?',a:42195,u:'Meter'},
      {q:'Wie viele Tasten hat ein übliches modernes Klavier?',a:88,u:'Tasten'},
      {q:'Wie viele Karten hat ein Skatblatt?',a:32,u:'Karten'},
      {q:'Wie viele Sekunden hat eine Viertelstunde?',a:900,u:'Sekunden'},
      {q:'Wie viele Monate sind fünf Jahre?',a:60,u:'Monate'},
      {q:'Wie viele Tage hat ein Schaltjahr?',a:366,u:'Tage'}
    ];
    const question=$('question'),label=$('player-label'),input=$('guess'),submit=$('submit-guess'),reveal=$('reveal'),roundEl=$('round'),scores=$('scores'),next=$('next'),numberButtons=[...document.querySelectorAll('[data-players]')];
    let players=2,round=0,guesses=[],points=[];
    function scoreText(){return points.map((p,i)=>'P'+(i+1)+': '+p).join(' · ');}
    function start(){round=0;points=Array(players).fill(0);renderRound(false);}
    function renderRound(focusInput=false){guesses=[];question.textContent=questions[round%questions.length].q;roundEl.textContent=(round+1)+' / 5';reveal.textContent='';next.hidden=true;input.hidden=false;submit.hidden=false;label.hidden=false;input.value='';label.textContent='Person 1 von '+players+' – deine Schätzung';scores.textContent=scoreText();status('Tipps bleiben bis zur Auflösung geheim.');if(focusInput)input.focus({preventScroll:true});}
    function submitGuess(){const value=Number(input.value);if(!Number.isFinite(value)||input.value.trim()===''||value<0){status('Bitte eine Zahl ab 0 eingeben.');return;}guesses.push(value);input.value='';if(guesses.length<players){label.textContent='Person '+(guesses.length+1)+' von '+players+' – deine Schätzung';status('Tipp gespeichert. Nächste Person ist dran.');input.focus({preventScroll:true});return;}
      const item=questions[round%questions.length],distances=guesses.map(v=>Math.abs(v-item.a)),min=Math.min(...distances);
      const winners=distances.map((d,i)=>d===min?i:-1).filter(i=>i>=0);winners.forEach(i=>points[i]++);
      reveal.textContent='Richtig: '+item.a.toLocaleString('de-DE')+' '+item.u;
      const rows=guesses.map((v,i)=>'Person '+(i+1)+': '+v.toLocaleString('de-DE')+(winners.includes(i)?' ★':''));
      status(rows.join('  ·  '));scores.textContent=scoreText();
      input.hidden=true;submit.hidden=true;label.hidden=true;next.hidden=false;next.textContent=round===4?'NEUES SPIEL':'NÄCHSTE FRAGE';
    }
    submit.addEventListener('click',submitGuess);input.addEventListener('keydown',e=>{if(e.key==='Enter')submitGuess();});
    next.addEventListener('click',()=>{round++;if(round>=5){start();return;}renderRound(true);});
    numberButtons.forEach(btn=>btn.addEventListener('click',()=>{players=Number(btn.dataset.players);numberButtons.forEach(b=>b.classList.toggle('active',b===btn));start();}));
    start();
  }
})();