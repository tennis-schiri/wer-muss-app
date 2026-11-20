# JUXILO – Monetarisierung und Release-Regeln

**Entscheidung:** 20.11.2026  
**Status:** Produktentscheidung getroffen, **technisch noch nicht umgesetzt**.  
**Geltungsbereich:** Wer muss?!, Punktlandung!, Fingerchaos, Nicht kleckern!, Nur noch einmal!, Völlig daneben! (native iOS-/Android-Apps). Die Browser-Demos auf `demo.juxilo.de` bleiben ohne Werbung.

## Geschäftsmodell

1. **Alle sechs Apps kostenlos herunterladen und vollständig spielen.** Keine Paywall für Spielmodi, keine Registrierung, keine Abonnements.
2. **Dezente Werbung** trägt die laufende Finanzierung. Zum Start nur kleine Banner auf Start-, Menü- und gegebenenfalls Ergebnisscreens; keine Banner über aktiven Spiel- oder Touchflächen.
3. **Werbung entfernen** als freiwilliger **einmaliger, nicht verbrauchbarer In-App-Kauf**, Zielpreis **2,99 € pro App inklusive Umsatzsteuer** (vor Store-Freigabe und Tests final prüfen). Nach dem Kauf dauerhaft ohne Werbung; Wiederherstellen auf weiteren Geräten desselben Store-Kontos sicherstellen.
4. Keine Pflichtvideos, keine Sperren zum Fortspielen, keine Werbung bei App-Start, keine Vollbildwerbung nach jeder Runde und keine manipulative Ansprache zur Freischaltung.
5. **Offline uneingeschränkt spielbar**, dann ohne Werbeabruf. Werbefrei-Käufe werden nach erfolgter Verifizierung lokal berücksichtigt. Für Kauf und Wiederherstellung kann zeitweise eine Internetverbindung notwendig sein.
6. Jede App ist eigenständig. Ein gemeinsamer Bundle- oder JUXILO-Pass ist **derzeit nicht beschlossen**.

## Anzeigenplatzierung und UX

- Wer muss?!: Banner auf Start-/Informationsseiten, **nicht** während Fingerauswahl, Countdown oder unmittelbar vor „Nochmal“.
- Punktlandung!: Banner auf Start-/Menüseiten, **nicht** auf dem Stoppfeld oder während einer Runde.
- Fingerchaos / Nicht kleckern!: Banner nur in Menüs, **nie** über bewegte Spielobjekte, Sensorflächen oder aktive Steuerung.
- Nur noch einmal!: Banner nur auf Menü-/Einstellungsflächen; kein Video zwischen Ballonversuchen.
- Völlig daneben!: Banner allenfalls bei Rundenübersicht / Menü, nicht über Fragen, Eingabefeldern oder Ergebnissen.
- Interstitial- oder Rewarded-Ads werden **nicht** im ersten Release eingesetzt. Später nur nach bewusstem Produktentscheid und erneutem UX-Test.
- Keine Anzeige, wenn Nutzer „Werbung entfernen“ gekauft haben oder wenn noch keine datenschutzkonforme Anzeigenfreigabe möglich ist.

## Umsetzung – verbindliche Reihenfolge

- [ ] A. Alterseinstufung und Zielgruppe festlegen; bei Kinderzielgruppen Apple-/Google-Familienregeln und zulässige SDKs prüfen.
- [ ] B. AdMob-Konto, App-IDs und Anzeigenflächen pro Plattform einrichten; **Testanzeigen** für Entwicklung verwenden. IDs und reale Produktionsanzeigen erst nach Freigabe.
- [ ] C. Google Mobile Ads Flutter Plugin für native iOS-/Android-Apps integrieren; Browserdemos bleiben davon getrennt.
- [ ] D. Datenschutzgrundlagen: EU-Einwilligung über eine geeignete Google-zertifizierte CMP / UMP, Widerruf/Datenschutzeinstellungen, iOS ATT falls Tracking eingesetzt wird, Datenschutzerklärung sowie Store-Datenschutzangaben.
- [ ] E. Anzeigenverwaltung zentralisieren: Platzierungen nur auf freigegebenen Screens, bei fehlender Freigabe oder Offline keine Werbeanfragen, Tests für Anzeigenfehler und Layout.
- [ ] F. Nicht verbrauchbaren In-App-Kauf „Werbung entfernen“ für iOS und Android mit Wiederherstellung/Prüfung des Kaufstatus integrieren, **zunächst mit Store-Sandbox-Tests**.
- [ ] G. Echte Geräte auf iOS/Android testen: Multitouch, Countdown, Touch-Zonen, Werbefrei-Schaltung, Offline, Datenschutzdialoge, Darkmode, DE/EN und Barrierefreiheit.
- [ ] H. Erst nach Rechts-/Store-Review, Datenschutzprüfung und bestandenen Tests in die Stores geben.

**Technischer Ist-Zustand am 20.11.2026:** Eine native Flutter-Basis für „Wer muss?!“, sechs interaktive Browser-Demos. Weder echtes AdMob-SDK, noch nutzbares Werbeinventar, noch ein werbefrei-In-App-Kauf sind durch diese Planung implementiert. Website-Texte können das **geplante** Geschäftsmodell ankündigen, dürfen aber nicht behaupten, dass Werbung oder Kauf bereits verfügbar wären.

## Erfolg messen und nach drei Monaten prüfen

- Kennzahlen: aktive Nutzer, 1-/7-/30-Tage-Wiederkehr, App-Abstürze, tatsächliche Anzeigenimpressionen, eCPM, Werbeerlös, Werbefrei-Käufe, Supportanfragen; jeweils nur mit datenschutzkonform zulässiger Erfassung.
- Prüfen, ob Werbung die Nutzer stört bzw. Spielabbrüche verursacht; Werbung reduzieren oder abschalten, wenn der Ertrag den Nutzungsschaden nicht rechtfertigt.
- Budget/Tracking: keine unnötigen Server, keine bezahlten KI-APIs; Hosting und externe Gebühren transparent planen.

## Technische Referenzen

- Google Mobile Ads Flutter: https://developers.google.com/admob/flutter/quick-start
- Google UMP / Privacy für Flutter: https://developers.google.com/admob/flutter/privacy
- Apple In-App-Käufe / Wiederherstellung: https://developer.apple.com/in-app-purchase/
- Google Play Zielgruppe/Familien: https://support.google.com/googleplay/android-developer/answer/9893335

**Abgrenzung:** TENNILO ist nicht betroffen und bleibt nach derzeitiger Planung werbefrei.
