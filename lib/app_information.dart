import 'package:flutter/material.dart';

import 'language.dart';

/// Instructions and provisional legal notices in German and English.
/// Verified operator details are required before store publication.
class AppInformationPage extends StatelessWidget {
  const AppInformationPage({super.key});

  static const _background = Color(0xFF111224);
  static const _panel = Color(0xFF1D1D37);
  static const _accent = Color(0xFFF5F36D);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: _background,
        appBar: AppBar(
          backgroundColor: _background,
          foregroundColor: Colors.white,
          title: Text(
            tr(context, 'Wer muss?! – Infos', 'Wer muss?! – Info'),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          ),
          actions: const [
            LanguageToggle(),
            SizedBox(width: 12),
          ],
          bottom: TabBar(
            isScrollable: true,
            labelColor: _accent,
            unselectedLabelColor: const Color(0xFFC4C0D6),
            indicatorColor: _accent,
            tabs: [
              Tab(text: tr(context, 'Anleitung', 'How to play')),
              Tab(text: tr(context, 'Impressum', 'Legal notice')),
              Tab(text: tr(context, 'Datenschutz', 'Privacy')),
              Tab(text: tr(context, 'Über die App', 'About')),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _InfoContent(children: [
              _InfoHeading(tr(context, 'So funktioniert’s', 'How it works')),
              _InfoParagraph(tr(context,
                '1. Mindestens zwei Personen legen jeweils einen Finger auf das Display.',
                '1. At least two players each place one finger on the screen.')),
              _InfoParagraph(tr(context,
                '2. Alle Finger bleiben während des Countdowns liegen.',
                '2. Keep all fingers on the screen during the countdown.')),
              _InfoParagraph(tr(context,
                '3. Vor dem Start sind 3, 5 oder 10 Sekunden wählbar.',
                '3. Choose a 3, 5 or 10-second countdown before starting.')),
              _InfoParagraph(tr(context,
                '4. Der helle, leuchtende Kreis zeigt die zufällig ausgewählte Person.',
                '4. The bright glowing circle marks the randomly selected person.')),
              _InfoParagraph(tr(context,
                '5. Das Ergebnis bleibt bis „Nochmal!“ sichtbar.',
                '5. The result stays visible until you tap “Again!”.')),
              _InfoParagraph(tr(context,
                'Wie viele Finger gleichzeitig erkannt werden, hängt vom Gerät ab. Wer während des Countdowns einen Finger hinzufügt oder entfernt, startet die Zeit erneut.',
                'The number of fingers recognized at once depends on the device. Adding or removing a finger restarts the countdown.')),
            ]),
            _InfoContent(children: [
              _InfoHeading(tr(context, 'Impressum', 'Legal notice')),
              _InfoParagraph(tr(context,
                'Anbieter: Michael Wiedeck',
                'Provider: Michael Wiedeck')),
              _DraftNotice(tr(context,
                'Entwurf: Die vollständige ladungsfähige Anschrift und bestätigte Kontaktangaben müssen vor einer Store-Veröffentlichung ergänzt und überprüft werden.',
                'Draft: A complete legal address and verified contact details must be added and checked before publishing in an app store.')),
              _InfoParagraph(tr(context,
                'Weitere Informationen zum Anbieter: wiedeck.de',
                'More provider information: wiedeck.de')),
            ]),
            _InfoContent(children: [
              _InfoHeading(tr(context,
                'Datenschutzhinweise – Entwurf',
                'Privacy notice – draft')),
              _InfoParagraph(tr(context,
                'Verantwortlicher: Michael Wiedeck. Vollständige Kontaktangaben folgen vor Veröffentlichung.',
                'Data controller: Michael Wiedeck. Complete contact details will be added before publication.')),
              _InfoParagraph(tr(context,
                'Die geplante native App verarbeitet die Positionen der Finger während der Auslosung vorübergehend auf dem Gerät. Nach dem Neustart der Runde werden diese Informationen verworfen.',
                'The native app temporarily processes finger positions on your device during the selection. This information is discarded when the round is reset.')),
              _InfoParagraph(tr(context,
                'Eine Registrierung, Werbung, Analyse-Tracking, ein Nutzerkonto und die Übertragung der Spieldaten an eigene Server sind derzeit nicht vorgesehen.',
                'Registration, advertising, analytics tracking, user accounts and transfer of game data to our own servers are currently not planned.')),
              _InfoParagraph(tr(context,
                'Bei einer späteren Veröffentlichung werden gegebenenfalls verwendete Drittanbieter und die tatsächliche Datenverarbeitung erneut geprüft.',
                'Before publication, any third-party services and actual data processing will be reviewed.')),
              _DraftNotice(tr(context,
                'Diese Fassung ist noch keine abschließend geprüfte Datenschutzerklärung für die App-Stores.',
                'This draft is not a final, reviewed app-store privacy notice.')),
            ]),
            _InfoContent(children: [
              _InfoHeading(tr(context, 'Über Wer muss?!', 'About Wer muss?!')),
              _InfoParagraph(tr(context,
                'Eine kleine Zufalls-App für die ganz großen Fragen. Finger drauf, Countdown abwarten und schauen, wen es trifft.',
                'A small random-picker app for big decisions. Place your fingers, wait for the countdown and find out who is chosen.')),
              _InfoParagraph(tr(context,
                'Version: Prototyp v0.4', 'Version: Prototype v0.4')),
              const _InfoParagraph('Logo: WM04b'),
            ]),
          ],
        ),
      ),
    );
  }
}

class _InfoContent extends StatelessWidget {
  const _InfoContent({required this.children});
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(22),
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: AppInformationPage._panel,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children,
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoHeading extends StatelessWidget {
  const _InfoHeading(this.text);
  final String text;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 14),
    child: Text(
      text,
      style: const TextStyle(
        fontSize: 22,
        color: AppInformationPage._accent,
        fontWeight: FontWeight.w900,
      ),
    ),
  );
}

class _InfoParagraph extends StatelessWidget {
  const _InfoParagraph(this.text);
  final String text;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 13),
    child: Text(
      text,
      style: const TextStyle(
        fontSize: 14,
        height: 1.55,
        color: Color(0xFFE3E0F1),
      ),
    ),
  );
}

class _DraftNotice extends StatelessWidget {
  const _DraftNotice(this.text);
  final String text;

  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.only(bottom: 14),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: const Color(0xFF3A2D3E),
      border: Border.all(color: const Color(0xFFFF9288)),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Text(
      text,
      style: const TextStyle(fontSize: 13, height: 1.5),
    ),
  );
}
