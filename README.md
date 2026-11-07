# Wer muss?! — Flutter-Prototyp 0.1

**Für iPhone und Android.** Eine Person wird aus allen gleichzeitig aufliegenden Fingern zufällig ausgewählt. Keine Anmeldung, kein Server, kein Tracking, keine Werbung.

## Funktionen

- Mehrfinger-Erkennung auf einem Gerät mittels `Listener` (Pointer-IDs)
- Auswahl erst ab **zwei gleichzeitig gehaltenen Fingern**
- **3 Sekunden Countdown**, startet bei hinzugefügten oder entfernten Fingern neu
- Zufällige Auswahl aus **genau den Fingern, die bei Ablauf noch aufliegen**
- Ergebnis bleibt sichtbar, bis **„Nochmal!“** gedrückt wird
- Vier Aufgaben-Vorlagen plus „Wer muss?“
- **Demo mit 4 Personen** zum alleinigen Ausprobieren, ohne echten Mehrfinger-Touch
- Offline, keine zusätzlichen Packages außer Flutter

## Lokal starten

Flutter SDK und Entwicklungsumgebung installieren: https://docs.flutter.dev/install

Da der Flutter SDK in der Erstellungsumgebung nicht installiert war, sind die automatisch generierten Android/iOS-Projektordner noch nicht Bestandteil dieses Quellpakets. Einmalig im Projektverzeichnis ausführen:

```bash
flutter create --project-name wer_muss --org de.wiedeck --platforms=android,ios .
flutter pub get
flutter test
flutter run
```

`flutter create` ergänzt nur das plattformspezifische Gerüst. `lib/main.dart` und die App-Logik bleiben erhalten.

### iPhone

Für einen echten iOS-Build ist ein Mac mit Xcode erforderlich. Für App Store Release zusätzlich ein Apple-Developer-Account und Code-Signierung. Siehe https://docs.flutter.dev/platform-integration/ios/setup

### Android

Android SDK/Android Studio einrichten und mit `flutter run` auf einem angeschlossenen Gerät testen. Für Google Play wird später ein signiertes App Bundle benötigt.

## Wichtige Hinweise

- Die **Browser-Demo ist separat**; sie dient dem visuellen und funktionalen Test.
- Auf manchen Geräten begrenzen Systemgesten/Displaygröße die gleichzeitig erkennbaren Finger. Besonders an den Rändern kann es Einschränkungen geben.
- Die Auswahl benutzt `Random.secure()` und `nextInt(n)`; jeder Teilnehmer hat bei einer Runde die gleiche Chance.
- Noch **keine APK/IPA** und **keine Veröffentlichung**. Store-Einträge, Screenshots, App-Icon, juristische Texte und Tests auf echten Geräten fehlen noch.

### Version 0.1 — bewusst schlank

Keine Nutzerkonten, kein Multiplayer über das Internet, kein kostenpflichtiges Feature innerhalb der App. Preis 1,99 € wäre beim späteren Verkauf über den App Store/Play Store eine **Store-Einstellung**, keine Funktion im Quellcode.
