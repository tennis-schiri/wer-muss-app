# Wer muss?! – Produktkonzept 0.1

## Idee

Eine bewusst alberne Mini-App, die eine einzige Sache macht: aus mehreren Personen per gleichzeitiger Fingerberührung eine Person auswählen. Ohne Accounts und ohne Internet.

## Erstes Bedienkonzept

1. Thema auswählen (Wer muss? / Wer zahlt? / Wer holt Snacks? / Wer räumt auf?)
2. Mindestens 2 Menschen legen je einen Finger auf das Spielfeld desselben Telefons
3. Nach einer ununterbrochenen stabilen Fingerzahl von 3 Sekunden wird ein Finger zufällig ausgewählt
4. Der ausgeloste Finger leuchtet, die App zeigt „DU MUSST!“
5. „Nochmal!“ für eine neue Runde; auch im Ergebniszustand kann man die Finger abheben

Ein Fingerdruck mehr oder weniger innerhalb des Countdowns startet die 3 Sekunden von vorn. Ohne mindestens zwei Finger gibt es keine Auslosung.

## Demo-Modus

Zum Testen ohne Mitspieler simuliert die App vier Finger. Dieser Modus ist als DEMO gekennzeichnet und löst nach drei Sekunden aus.

## Erste Designrichtung

- Navy/Lila Hintergrund
- Knalliges Zitronengelb als Hauptakzent
- Zusätzliche Farben für Finger: Lavendel, Koralle, Mint, Eisblau
- Große, kurze Texte, klare Touch-Ziele, keine Menüs

## Technische Architektur

- Flutter / Dart, ein gemeinsamer Code für Android und iOS
- Roh-Pointerevents (`Listener`) für echten Multi-Touch
- `Random.secure()` für unabhängige faire Zufallswahl pro Runde
- Timer im Speicher, keine Persistenz, keine Netzwerkaufrufe

## Vor Store-Release

- Android-/iOS-Plattform-Ordner mit Flutter SDK erzeugen
- UI- und Mehrfinger-Tests auf mehreren realen Geräten und Bildschirmgrößen
- Accessibility/VoiceOver/TalkBack prüfen
- App-Icon, Screenshots, Store-Metadaten, Datenschutzangaben
- Entwicklerkonten, Signierung, Paket-ID, Versionierung
- Ggf. Lizenzfragen und Regeln für 0,99/1,99 € prüfen

Die Flutter-Version ist noch nicht auf Geräten gebaut/getestet; die Browser-Demo wurde in Chromium mit Multi-Touch-Simulation geprüft. Preis ist vorerst nur eine Hypothese.
