# Wer muss?! – Mini-App-Werkstatt

Stand: 08.11.2026

## Grundsatz

**Wer muss?!** ist die gemeinsame Web-Zentrale für alle humorvollen Mini-Apps.
Die einzelnen Apps bleiben später eigenständige iOS-/Android-Produkte, aber ihre
Entwicklungsstände, browserbasierten Tests und die Übersicht liegen unter derselben Website.

## Struktur der Website

- `demo/index.html`: Hauptseite mit Übersicht aller Mini-Apps
- `demo/apps/wer-muss/index.html`: unverändertes Grundprinzip der bestehenden Multitouch-Demo
- `demo/apps/punktlandung/index.html`: Reaktions-/Zeitgefühl-Demo
- `demo/apps/fingerchaos/index.html`: Tipp-/Reaktions-Demo
- `demo/apps/nicht-kleckern/index.html`: Balance-Demo, optionaler Sensor-Test
- `demo/apps/nur-noch-einmal/index.html`: Ballon-Risiko-Demo
- `demo/apps/voellig-daneben/index.html`: Schätzspiel-Demo für 2–4 Personen
- `demo/assets/logos/`: freigegebene WM04b-nahe App-Icons PL05, FC05, NK05, NE05, VD05; direkt aus den Logo-Set-Präsentationen in Google Drive ausgeschnitten, nicht neu gezeichnet
- `demo/assets/mini-apps.css`: gemeinsames Designsystem
- `demo/assets/mini-apps.js`: Testspiel-Logik der fünf neuen Apps
- `demo/wm04b-logo.svg`: bestehendes Wer-muss-Logo als Dachmarke

Die Browser-Tests sind bewusst Prototypen und keine fertigen Store-Apps.

## Gemeinsame Gestaltungsregeln

- Wer-muss-Basisfarben: Nachtblau `#111224`, Panel `#1d1d37`
- Hauptakzent Zitronengelb `#f5f36d`
- Sekundärfarben: Lavendel `#b6a5ff`, Mint `#71e6c8`,
  Koralle `#ff9288`, Eisblau `#85b9ff`
- Große, kontrastreiche Typografie, abgerundete Karten und Buttons
- Gemeinsame Dachmarke WM04b; die fünf App-Monogramm-Platzhalter wurden auf der Startseite und den Browser-Spielseiten durch die freigegebenen Original-Icons PL05, FC05, NK05, NE05, VD05 ersetzt
- Logos/Icons der Einzel-Apps später konsequent von dieser Bildsprache ableiten
- Mobil zuerst, große Touch-Ziele, keine fremden Fonts/Tracker für die Tests

## Veröffentlichung

Der Workflow `.github/workflows/deploy-test.yml` wird **manuell** gestartet
und überträgt alle Dateien aus `demo/` rekursiv in das FTP-Startverzeichnis
der vorhandenen Wer-muss-FTPS-Verbindung. Dadurch bleiben die Unterseiten
über die relativen Pfade `/apps/<slug>/` erreichbar.

Workflow: https://github.com/tennis-schiri/wer-muss-app/actions/workflows/deploy-test.yml

Vor einer echten öffentlichen Veröffentlichung: Ziel-Domain/Hosting prüfen
sowie Entwürfe für Impressum und Datenschutz vervollständigen.
