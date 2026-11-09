/* Source fingerprint MW-WMA-2026-8d573e4b | Copyright (c) 2026 Michael Wiedeck. All rights reserved. */
(() => {
  'use strict';

  // All mini apps use the same language preference as the Wer muss?! demo.
  const translations = {
  "Mini-App-Werkstatt": "Mini-app workshop",
  "Alle Apps ansehen": "View all apps",
  "↻ Neu starten": "↻ Restart",
  "⌂ Zur Startseite": "⌂ Home",
  "Browser-Test · Prototyp": "Browser test · Prototype",
  "Spielbereich": "Game area",
  "Spielsteuerung": "Game controls",
  "Navigation": "Navigation",
  "Impressum": "Legal notice",
  "Datenschutz": "Privacy",
  "WER MUSS?! · Kleine Spiele, große Fragen.": "WER MUSS?! · Small games, big questions.",
  "Diese Testversion ist noch keine fertige iPhone- oder Android-App. Sie funktioniert ohne Anmeldung und ohne Datenübertragung durch das Spiel.": "This test version is not yet a finished iPhone or Android app. It works without registration or game-data transmission.",
  "Stoppe die Uhr so nah wie möglich an der Zielzeit.": "Stop the clock as close to the target time as possible.",
  "ZEITGEFÜHL STATT ZUFALL": "TIMING INSTEAD OF LUCK",
  "Zielzeit": "Target time",
  "5 SEK.": "5 SEC",
  "10 SEK.": "10 SEC",
  "15 SEK.": "15 SEC",
  "Stoppe die Zeit möglichst genau bei 10 Sekunden.": "Stop as close as possible to 10 seconds.",
  "Laufende Uhr verbergen – für Profis": "Hide the running clock – for pros",
  "STARTEN": "START",
  "Abweichung:": "Difference:",
  "Bestwert:": "Best:",
  "Tipp: Auf dem Desktop funktioniert auch die Leertaste. Die Uhr misst mit der Browser-Zeit, nicht mit einem offiziellen Sportzeitmesser. Diese Testversion ist noch keine fertige iPhone- oder Android-App. Sie funktioniert ohne Anmeldung und ohne Datenübertragung durch das Spiel.": "Tip: On desktop, the space bar also works. The clock uses browser timing, not an official sports timer. This is a browser prototype, not a finished iPhone or Android app. No login or game-data transmission.",
  "Volltreffer! Unglaublich präzise.": "Bullseye! Incredibly precise.",
  "Ganz knapp! Noch eine Runde?": "So close! Another round?",
  "Knapp vorbei. Versuch es noch einmal!": "Almost! Give it another try!",
  "NOCHMAL STARTEN": "START AGAIN",
  "Warte auf den richtigen Moment …": "Wait for the perfect moment …",
  "STOPP!": "STOP!",
  "Tippe die richtigen Kreise. Bloß nicht die falschen!": "Tap the right circles. Avoid the wrong ones!",
  "20 SEKUNDEN · SO VIELE TREFFER WIE MÖGLICH": "20 SECONDS · GET AS MANY HITS AS POSSIBLE",
  "Punkte:": "Points:",
  "Zeit:": "Time:",
  "Rekord:": "Record:",
  "Spielfeld": "Play area",
  "Richtigen grünen Kreis treffen": "Tap the correct green circle",
  "Falscher korallfarbener Kreis": "Wrong coral-colored circle",
  "MINT antippen. KORALLE vermeiden (−2 Punkte).": "Tap MINT. Avoid CORAL (−2 points).",
  "20 SEKUNDEN STARTEN": "START 20 SECONDS",
  "Diese erste Testversion läuft mit einem Finger und speichert deinen Bestwert nur lokal in deinem Browser. Diese Testversion ist noch keine fertige iPhone- oder Android-App. Sie funktioniert ohne Anmeldung und ohne Datenübertragung durch das Spiel.": "This early test version uses one finger and saves your personal best only in your browser. It is not yet a finished iPhone or Android app. No login or game-data transmission.",
  "NEUE RUNDE": "NEW ROUND",
  "NEU STARTEN": "RESTART",
  "Tippe MINT. Meide KORALLE!": "Tap MINT. Avoid CORAL!",
  "Falscher Kreis: −2 Punkte!": "Wrong circle: −2 points!",
  "20 Sekunden Kaffee balancieren, ohne alles zu verschütten.": "Balance coffee for 20 seconds without spilling it all.",
  "HALTE DEN KAFFEE IN DER TASSE": "KEEP THE COFFEE IN THE CUP",
  "Übrig:": "Remaining:",
  "Mit LINKS und RECHTS gegen das Schwappen steuern.": "Use LEFT and RIGHT to counter the sloshing.",
  "◀ LINKS": "◀ LEFT",
  "RECHTS ▶": "RIGHT ▶",
  "HANDY-SENSOR TESTEN": "TRY MOTION SENSOR",
  "Die Browser-Demo simuliert schwappenden Kaffee und unterstützt Pfeiltasten. Der optionale Bewegungssensor funktioniert nur in unterstützten Browsern und bei erteilter Berechtigung. Diese Testversion ist noch keine fertige iPhone- oder Android-App. Sie funktioniert ohne Anmeldung und ohne Datenübertragung durch das Spiel.": "The browser demo simulates sloshing coffee and supports arrow keys. The optional motion sensor requires a supported browser and permission. This is not yet a finished iPhone or Android app. No login or game-data transmission.",
  "NOCHMAL BALANCIEREN": "BALANCE AGAIN",
  "RUNDE NEU STARTEN": "RESTART ROUND",
  "Gegensteuern! Halte die Tasse möglichst gerade.": "Steer against the movement! Keep the cup level.",
  "Kein Bewegungssensor verfügbar. Pfeiltasten nutzen.": "No motion sensor available. Use the arrow keys.",
  "Sensorsperre aktiv. Du kannst die Pfeiltasten nutzen.": "Motion sensor blocked. You can use the arrow keys.",
  "SENSOR AKTIV": "SENSOR ACTIVE",
  "Bewegungssensor aktiviert. Alternativ Pfeile nutzen.": "Motion sensor enabled. You can also use the arrows.",
  "Sensor nicht verfügbar. Pfeiltasten funktionieren trotzdem.": "Sensor unavailable. Arrow keys still work.",
  "Wie weit traust du dich? Aufpumpen, loslassen, Punkte sichern.": "How far will you push your luck? Inflate, release and bank your points.",
  "NOCH GRÖSSER? ODER LIEBER SICHERN?": "GO BIGGER? OR BANK THE POINTS?",
  "Gesichert:": "Banked:",
  "Im Ballon:": "In balloon:",
  "Finger gedrückt halten – rechtzeitig loslassen!": "Hold your finger down – release in time!",
  "GEDRÜCKT HALTEN · LOSLASSEN = SICHERN": "HOLD DOWN · RELEASE TO BANK",
  "PUNKTE ZURÜCKSETZEN": "RESET POINTS",
  "Bei jedem zusätzlichen Stück Wachstum steigt die zufällige Platzgefahr. Der Rekord bleibt nur in deinem Browser gespeichert. Diese Testversion ist noch keine fertige iPhone- oder Android-App. Sie funktioniert ohne Anmeldung und ohne Datenübertragung durch das Spiel.": "Every bit of extra growth increases the risk of bursting. Your record stays only in this browser. This is not yet a finished iPhone or Android app. No login or game-data transmission.",
  "Je größer, desto riskanter …": "The bigger, the riskier …",
  "Neue Serie gestartet. Finger gedrückt halten und rechtzeitig loslassen.": "New series started. Hold your finger down and release before it bursts.",
  "Wer schätzt am besten? Spiele mit 2 bis 4 Personen an einem Handy.": "Who can estimate best? Play with 2 to 4 people on one phone.",
  "SCHÄTZEN · WEITERGEBEN · AUFLÖSEN": "GUESS · PASS ON · REVEAL",
  "Mitspielerzahl": "Number of players",
  "2 PERSONEN": "2 PLAYERS",
  "3 PERSONEN": "3 PLAYERS",
  "4 PERSONEN": "4 PLAYERS",
  "Frage:": "Question:",
  "Person 1 – deine Schätzung": "Player 1 – your estimate",
  "Deine Zahl": "Your number",
  "Deine Schätzung": "Your estimate",
  "TIPP ABGEBEN": "SUBMIT GUESS",
  "NÄCHSTE FRAGE": "NEXT QUESTION",
  "NEUES SPIEL": "NEW GAME",
  "Die Fragen sind ein erster lokaler Testsatz. Alle Tipps werden erst angezeigt, wenn alle Personen ihre Zahl eingetragen haben. Diese Testversion ist noch keine fertige iPhone- oder Android-App. Sie funktioniert ohne Anmeldung und ohne Datenübertragung durch das Spiel.": "The questions are an early offline test set. Guesses are revealed only once every player has entered a number. This is not yet a finished iPhone or Android app. No login or game-data transmission.",
  "Tipps bleiben bis zur Auflösung geheim.": "Guesses stay hidden until the reveal.",
  "Bitte eine Zahl ab 0 eingeben.": "Please enter a number of 0 or more.",
  "Tipp gespeichert. Nächste Person ist dran.": "Guess saved. Pass the phone to the next player.",
  "Wie viele Sekunden hat ein ganzer Tag?": "How many seconds are in a full day?",
  "Wie viele Felder hat ein klassisches Schachbrett?": "How many squares are on a standard chessboard?",
  "Wie viele Minuten hat eine Woche?": "How many minutes are in a week?",
  "Wie viele Augen haben alle sechs Seiten eines normalen Würfels zusammen?": "What is the total number of pips on all six faces of a standard die?",
  "Wie viele Meter ist die klassische Marathonstrecke lang?": "How many meters long is a standard marathon?",
  "Wie viele Tasten hat ein übliches modernes Klavier?": "How many keys does a typical modern piano have?",
  "Wie viele Karten hat ein Skatblatt?": "How many cards are in a Skat deck?",
  "Wie viele Sekunden hat eine Viertelstunde?": "How many seconds are in fifteen minutes?",
  "Wie viele Monate sind fünf Jahre?": "How many months are in five years?",
  "Wie viele Tage hat ein Schaltjahr?": "How many days are in a leap year?",
  "Die Mini-App-Werkstatt": "The mini-app workshop",
  "Wer muss?! Mini-Apps Startseite": "Wer muss?! mini-app home",
  "Hauptnavigation": "Main navigation",
  "Unsere Apps": "Our apps",
  "WER MUSS?! TESTEN": "TRY WER MUSS?!",
  "Kleine Spiele. Große Fragen. Viel Spaß.": "Small games. Big questions. Lots of fun.",
  "Ein bisschen Quatsch.": "A little silliness.",
  "Ziemlich viel Spaß.": "A whole lot of fun.",
  "Wer muss? Wer trifft den perfekten Moment? Wer hat die schnellsten Finger? Hier entstehen kleine, eigenständige Apps für zwischendurch – und du kannst schon jetzt die ersten Versionen ausprobieren.": "Who is it? Who has perfect timing? Who has the fastest fingers? We are creating small standalone apps for a quick laugh – and you can already try the first versions.",
  "Mini-App-Ideen": "mini-app ideas",
  "Ein Design. Viele Spiele.": "One design. Many games.",
  "Browser-Tests statt App-Store-Versprechen": "Browser demos before app-store releases",
  "Die Spielwiese": "The playground",
  "Unsere Mini-Apps": "Our mini-apps",
  "Jede Idee hat ihren eigenen Platz. Gleiche Farben, gleiche Handschrift – unterschiedliche Herausforderungen.": "Each idea gets its own space. The same colors and style, with a different challenge each time.",
  "BROWSER-TEST VERFÜGBAR": "BROWSER DEMO AVAILABLE",
  "BROWSER-TEST": "BROWSER DEMO",
  "APP 01 · DER ANFANG VON ALLEM": "APP 01 · WHERE IT ALL BEGAN",
  "APP 02 · TIMING": "APP 02 · TIMING",
  "APP 03 · REAKTION": "APP 03 · REACTION",
  "APP 04 · BALANCE": "APP 04 · BALANCE",
  "APP 05 · MUTPROBE": "APP 05 · DARE",
  "APP 06 · PARTY": "APP 06 · PARTY",
  "Alle legen einen Finger aufs Display. Der Countdown läuft. Ein Finger leuchtet – und die Frage ist geklärt. Schon als interaktive Multitouch-Browser-Demo ausprobierbar.": "Everyone places one finger on the screen. The countdown begins. One finger lights up – and the question is settled. Try the interactive multitouch browser demo.",
  "DEMO AUSPROBIEREN →": "TRY THE DEMO →",
  "TESTEN →": "TRY IT →",
  "Stoppe die Uhr bei exakt 5, 10 oder 15 Sekunden. Mit verdeckter Uhr wird es besonders fies.": "Stop the clock at exactly 5, 10 or 15 seconds. Hiding the clock makes it extra tricky.",
  "Grüne Kreise treffen, korallfarbene meiden. 20 Sekunden, ein Ziel: so viele Punkte wie möglich.": "Tap the green circles, avoid the coral ones. Twenty seconds to score as many points as you can.",
  "Die Kaffeetasse wackelt. Halte dagegen und rette in 20 Sekunden möglichst viel Kaffee.": "The coffee cup wobbles. Counter the movement and save as much coffee as you can in 20 seconds.",
  "Blase den Ballon auf. Mehr Risiko bringt mehr Punkte – außer er platzt vorher.": "Inflate the balloon. More risk means more points – unless it bursts first.",
  "Absurd schwere Schätzfragen. Zwei bis vier Leute raten mit, die nächste Person ist dran.": "Absurdly tricky estimation questions. Two to four players take turns guessing.",
  "Das ist unsere Werkstatt, kein App-Store.": "This is our workshop, not an app store.",
  "Die verlinkten Seiten sind frühe Browser-Versionen zum Testen und Ideensammeln. Die fertigen Handy-Apps werden eigenständige Produkte; Funktionen, Namen und Preise können sich noch ändern. Für die Tests brauchst du kein Konto.": "The linked pages are early browser versions for testing and exploring ideas. The finished mobile apps will be standalone products; features, names and prices may change. No account is needed to try them.",
  "Ein kleines Universum für große Albernheiten.": "A little universe for big silliness.",
  "Wer muss?! Browser-Demo öffnen": "Open Wer muss?! browser demo",
  "Punktlandung! Testseite öffnen": "Open Punktlandung! browser demo",
  "Fingerchaos Testseite öffnen": "Open Fingerchaos browser demo",
  "Nicht kleckern! Testseite öffnen": "Open Nicht kleckern! browser demo",
  "Nur noch einmal! Testseite öffnen": "Open Nur noch einmal! browser demo",
  "Völlig daneben! Testseite öffnen": "Open Völlig daneben! browser demo"
};
  const originalNodes = new WeakMap();
  const originalAttributes = new WeakMap();
  let language = (() => {
    try {
      const stored = localStorage.getItem('wer_muss_language');
      if (stored === 'de' || stored === 'en') return stored;
    } catch (_) {}
    return navigator.language.toLowerCase().startsWith('de') ? 'de' : 'en';
  })();

  function translateGerman(value) {
    if (Object.prototype.hasOwnProperty.call(translations, value)) {
      return translations[value];
    }
    const patterns = [
      [/^Stoppe die Zeit möglichst genau bei (\d+) Sekunden\.$/, (_, n) => 'Stop as close as possible to ' + n + ' seconds.'],
      [/^Zeit abgelaufen! (\d+) Punkte\.$/, (_, n) => 'Time is up! ' + n + ' points.'],
      [/^Geschafft! (\d+) % Kaffee gerettet\.$/, (_, n) => 'Done! Saved ' + n + '% of the coffee.'],
      [/^PLATZ! Die (\d+) möglichen Punkte sind weg\.$/, (_, n) => 'POP! You lost ' + n + ' potential points.'],
      [/^Gerettet: \+(\d+) Punkte\. Noch eine Runde\?$/, (_, n) => 'Banked: +' + n + ' points. Another round?'],
      [/^Person (\d+) von (\d+) – deine Schätzung$/, (_, a, b) => 'Player ' + a + ' of ' + b + ' – your estimate'],
      [/^Person (\d+): ([\d.,]+)( ★)?$/, (_, a, b, c) => 'Player ' + a + ': ' + b + (c || '')],
      [/^Richtig: ([\d.,]+) (\S+)$/, (_, n, unit) => 'Correct: ' + n + ' ' + ({Sekunden:'seconds', Felder:'squares', Minuten:'minutes', Augen:'pips', Meter:'meters', Tasten:'keys', Karten:'cards', Monate:'months', Tage:'days'}[unit] || unit)]
    ];
    for (const [pattern, fn] of patterns) {
      if (pattern.test(value)) return value.replace(pattern, fn);
    }
    return value;
  }

  function translateText(node) {
    if (node.nodeType !== Node.TEXT_NODE ||
        node.parentElement?.closest('script,style')) return;
    let source = originalNodes.get(node);
    if (source === undefined) {
      source = node.nodeValue;
      originalNodes.set(node, source);
    }
    const clean = source.trim();
    if (!clean) return;
    const output = language === 'en'
      ? source.replace(clean, translateGerman(clean))
      : source;
    if (node.nodeValue !== output) node.nodeValue = output;
  }

  function translateTree(root) {
    if (root.nodeType === Node.TEXT_NODE) {
      translateText(root);
      return;
    }
    if (root.nodeType !== Node.ELEMENT_NODE ||
        root.matches('script,style')) return;
    const walker = document.createTreeWalker(root, NodeFilter.SHOW_TEXT);
    for (let node = walker.nextNode(); node; node = walker.nextNode()) {
      translateText(node);
    }
  }

  function translateAttributes() {
    document.querySelectorAll('[placeholder],[aria-label],[title]').forEach(el => {
      let originals = originalAttributes.get(el);
      if (!originals) {
        originals = {};
        for (const attr of ['placeholder', 'aria-label', 'title']) {
          if (el.hasAttribute(attr)) originals[attr] = el.getAttribute(attr);
        }
        originalAttributes.set(el, originals);
      }
      for (const [attr, source] of Object.entries(originals)) {
        const result = language === 'en' ? translateGerman(source) : source;
        if (el.getAttribute(attr) !== result) el.setAttribute(attr, result);
      }
    });
  }

  function applyLanguage() {
    document.documentElement.lang = language;
    translateTree(document.body);
    translateAttributes();
    document.querySelectorAll('[data-language]').forEach(button => {
      button.setAttribute('aria-pressed', String(button.dataset.language === language));
    });
  }

  document.querySelectorAll('[data-language]').forEach(button => {
    button.addEventListener('click', () => {
      if (button.dataset.language !== 'de' && button.dataset.language !== 'en') return;
      language = button.dataset.language;
      try { localStorage.setItem('wer_muss_language', language); } catch (_) {}
      applyLanguage();
    });
  });

  // Translate text added by a running game as well as the initial HTML.
  const observer = new MutationObserver(mutations => {
    for (const mutation of mutations) {
      if (mutation.type === 'characterData') {
        translateText(mutation.target);
      } else {
        for (const node of mutation.addedNodes) translateTree(node);
      }
    }
  });
  observer.observe(document.body, {
    childList: true,
    characterData: true,
    subtree: true
  });
  applyLanguage();
})();
