# Wer muss?! — Projektstand

Stand: 08.11.2026

## Produkt und Konzept
Wer muss?! ist eine eigenständige humorvolle Mini-App mit zufälliger
Mehrfinger-Auswahl, Flutter-Prototyp für iPhone/Android und bestehender
interaktiver Browser-Demo.

## Neue gemeinsame Mini-App-Zentrale
Die Wer-muss-Website bündelt künftig die Testseiten und die Übersicht
der weiteren Mini-Apps. Das gemeinsame Design basiert auf WM04b mit
Nachtblau, Zitronengelb, Lavendel, Mint, Koralle und Eisblau.

Bereits als einfache Browser-Prototypen im Repository enthalten:
- Wer muss?! (Original-Multitouch-Demo)
- Punktlandung!
- Fingerchaos
- Nicht kleckern!
- Nur noch einmal!
- Völlig daneben!

Zentrale Webseite: `demo/index.html`
Alle App-Tests: `demo/apps/<slug>/index.html`
Designsystem und Prototypenlogik: `demo/assets/`

## Entwicklung und Tests
Die Browser-Seiten wurden im Repository abgelegt und auf vorhandene
lokale Verlinkungen/Dateien geprüft. Noch keine realen Geräte- oder
Browserläufe der fünf neuen Spiele und noch keine nativen Builds.
Die bestehenden Flutter-Dateien der Wer-muss-App bleiben unverändert.

## Infrastruktur
- Privates Repository: `tennis-schiri/wer-muss-app`
- Manuell auslösbarer FTPS-Workflow: `.github/workflows/deploy-test.yml`
- Das veröffentlichte Ziel hängt von den vorhandenen FTP-Secrets ab.
- Der Workflow lädt den gesamten Inhalt von `demo/` inkl. Unterordnern hoch.

## Vor öffentlicher Veröffentlichung
- Zieldomain und FTP-Wurzelverzeichnis kontrollieren
- Impressum und Datenschutz vervollständigen und prüfen
- Browser-Demos auf echten Geräten testen (insbesondere Sensor-/Mehrfinger-Funktionen)
- Native Apps später eigenständig bauen, signieren und prüfen
