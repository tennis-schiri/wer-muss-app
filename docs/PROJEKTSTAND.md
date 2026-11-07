# Wer muss?! — Projektstand v0.1

Stand: 07.11.2026

## Ziel
Humorvolle Mini-App für iOS und Android: Mehrere Personen legen gleichzeitig einen Finger auf dasselbe Display. Nach drei Sekunden wird zufällig einer der noch aufliegenden Finger ausgewählt.

- Flutter für iOS und Android
- Offline, ohne Konto, Backend, Werbung oder Tracking
- Geplanter Kaufpreis: 1,99 € einmalig (noch nicht verbindlich)
- Aufgaben wie „Wer zahlt?“, „Wer holt Snacks?“ und „Wer räumt auf?“

## Prototyp v0.1 (im vorherigen Chat erarbeitet)
- Mehrfinger-Erkennung über Pointer-IDs, mindestens zwei Finger
- 3-Sekunden-Countdown; Neustart bei veränderter Fingerzahl
- Zufallsauswahl mit `Random.secure()` und `nextInt(n)`
- Ergebnis bleibt bis „Nochmal!“ sichtbar
- Solo-Demo mit vier simulierten Personen
- Browser-Demo mit echten und simulierten Touch-Ereignissen

## Teststatus
Die Browser-Demo wurde mit simulierten Teilnehmern und echten Touch-Ereignissen getestet. Die Flutter-App wurde noch nicht auf iPhone oder Android gebaut/getestet. Noch keine APK/IPA und kein Store-Eintrag.

## Noch zu übernehmen
Die im vorherigen Chat benannten Artefakte sind in diesem Chat bislang nicht als Quelldateien zugänglich:
- `wer-muss-flutter-quellcode.zip`
- `wer-muss-browser-demo.zip`
- `wer-muss-vorschau-start.png`
- `wer-muss-vorschau-ergebnis.png`
- `wer-muss-vorschau-desktop.png`

Bitte nicht anhand dieser Dokumentation so tun, als wäre der Original-Quellcode bereits importiert.

## Infrastruktur
- Privates Repository: `tennis-schiri/wer-muss-app`
- Geplant: ausschließlich eine geschützte interne Browser-Testseite, keine öffentliche Produktseite
- Manuell auslösbarer GitHub-Actions-Deploy-Workflow nach Einrichtung der Subdomain

## Nächste Schritte
1. Originaldateien importieren.
2. Flutter-Build und automatisierte Tests einrichten.
3. Geschützte Test-Subdomain und manuellen Deploy einrichten.
4. Finger-Animationen, Haptik und App-Icon überarbeiten.
