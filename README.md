# Wer muss?! — Flutter-Mini-App (iOS zuerst)

Eine kleine Zufalls-App für mehrere Finger auf **einem** Smartphone. Kein Login, kein Backend. Die bisherige Testversion ist werbefrei; für die späteren nativen JUXILO-Veröffentlichungen ist ein kostenloses, werbefinanziertes Modell geplant.

## JUXILO-Geschäftsmodell (beschlossen 20.11.2026)

Alle sechs JUXILO-Apps sollen bei Veröffentlichung **kostenlos** und ohne gesperrte Spielmodi erhältlich sein. Die Finanzierung ist über **dezente Werbung außerhalb aktiver Spielrunden** und eine **optionale einmalige Werbefrei-Schaltung (Zielpreis 2,99 € pro App)** vorgesehen. Keine Abos, keine Pflichtvideos, keine Registrierung; Offline-Spiel bleibt möglich. Die **Werbe- und Kauftechnik ist noch nicht eingebaut**. Bei Veröffentlichung sind Datenschutz/Einwilligung, Store-Vorgaben und Kauf-Wiederherstellung zu erfüllen.

Verbindliche Produktentscheidung, Anzeigenregeln und Implementierungs-Checkliste: [JUXILO_MONETARISIERUNG.md](JUXILO_MONETARISIERUNG.md).

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

## Sprache / language

Die native Flutter-App und die sechs Browser-Spielprototypen unterstützen **Deutsch und Englisch**. Ein gut sichtbarer **DE/EN-Schalter** wechselt die Sprache ohne Neustart.

- Erster Start: Deutsch bei deutscher Gerätesprache, sonst Englisch.
- Manuelle Auswahl wird lokal gespeichert und hat künftig Vorrang.
- Spielbildschirme, Statusmeldungen, Anleitung und native Info-Seiten sind übersetzt.
- Die Sprachwahl der Browser-Prototypen wird über `localStorage` geteilt.
- Native Flutter-App: `lib/language.dart`, `shared_preferences`, Flutter-Systemlokalisierung.
- Mini-App-Seiten: `demo/assets/language.js`; die Hauptseite der Mini-App-Werkstatt bietet denselben Schalter.

Das Bedienmuster ist auch für die übrigen Tennilo-Apps vorgesehen; die Umsetzung dort erfolgt separat.

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

## JUXILO-Websites und Browser-Test

- **`juxilo.de`**: Öffentlich sichtbare Vorschauseite aus `site/`, ohne Links oder Details zu den Demos.
- **`demo.juxilo.de`**: Eigenständige Browser-Tests aus `demo/`, sechs Apps inklusive Smartphone-Ansichten.
- **Getrennte FTPS-Zugänge und manuelle GitHub-Actions-Workflows** für beide Domains.

Die Domains, Secrets und manuellen Uploads sind in [JUXILO_DEPLOY.md](JUXILO_DEPLOY.md) beschrieben. Die Flutter-App und ihre iOS-Simulator-Konfiguration bleiben davon unberührt.

## Hinweise

Die Flutter-Projektordner für die Zielplattformen können durch `flutter create` ergänzt werden. Die App und der Browser-Prototyp verwenden dieselbe Grundidee, besitzen aber separate Oberflächen-Implementierungen. Die maximale Zahl gleichzeitig erkannter Finger ist vom Gerät abhängig. Rechtstexte sind für einen Store-Release noch zu vervollständigen und zu prüfen.
