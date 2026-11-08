# Wer muss?! — Flutter-Mini-App (iOS zuerst)

Eine kleine Zufalls-App für mehrere Finger auf **einem** Smartphone. Kein Login, keine Werbung, kein Backend.

## Stand der Entwicklung

- Eigener Startbildschirm mit dem WM04b-Logo und „LOS GEHT’S!“
- Großflächige Spielfläche mit dynamischen farbigen Kreisen an den Fingerpositionen
- Mindestens zwei Finger, Auswahl der Countdown-Zeit **3 / 5 / 10 Sekunden**
- Hinzufügen oder Entfernen eines Fingers setzt den Countdown zurück
- Zufällig ausgeloster Finger wird groß und deutlich leuchtend markiert
- Das Ergebnis bleibt bis „NOCHMAL!“ sichtbar
- Allein testen mit vier simulierten Fingern
- Info-Bereich mit Anleitung und als Entwurf gekennzeichneten Rechtstexten
- iOS-Simulator-Test auf dem MacBook ist möglich; echte Mehrfinger-Tests auf einem iPhone stehen noch aus

## Auf dem MacBook testen

Projektordner in VS Code öffnen, dort **Terminal → Neues Terminal** wählen.

```bash
flutter pub get
flutter run -d 78EA524C-0B18-4812-B648-B31BA3C5D1F9
```

Die ID gehört zum bisher eingerichteten iPhone-17-Simulator. Mit `flutter devices` lässt sie sich überprüfen.

Falls die iOS-Projektdateien im lokalen Repository fehlen, einmal im **VS-Code-Terminal** ausführen:

```bash
flutter create --platforms=ios --project-name wer_muss .
```

Für den Test auf einem realen iPhone sind eine lokale iOS-Signierung über Xcode und die Geräteverbindung nötig. Für TestFlight ist die kostenpflichtige Apple-Developer-Mitgliedschaft erforderlich.

## Browser-Test

Die überarbeitete Browser-Demo liegt unter `demo/apps/wer-muss/index.html`, die Mini-App-Übersicht unter `demo/index.html`. Der manuelle Website-Upload läuft über
[GitHub Actions](https://github.com/tennis-schiri/wer-muss-app/actions/workflows/deploy-test.yml).

## Hinweise

Die Flutter-Projektordner für die Zielplattformen können durch `flutter create` ergänzt werden. Die App und der Browser-Prototyp verwenden dieselbe Grundidee, besitzen aber separate Oberflächen-Implementierungen. Die maximale Zahl gleichzeitig erkannter Finger ist vom Gerät abhängig. Rechtstexte sind für einen Store-Release noch zu vervollständigen und zu prüfen.
