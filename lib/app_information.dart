import 'package:flutter/material.dart';

/// Help and legal information for the Wer muss?! prototype.
/// Replace draft legal details with verified operator/contact information
/// before publishing to the App Store or Google Play.
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
          title: const Text('Wer muss?! – Infos', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
          bottom: const TabBar(
            isScrollable: true,
            labelColor: _accent,
            unselectedLabelColor: Color(0xFFC4C0D6),
            indicatorColor: _accent,
            tabs: [
              Tab(text: 'Anleitung'),
              Tab(text: 'Impressum'),
              Tab(text: 'Datenschutz'),
              Tab(text: 'Über die App'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            _InfoContent(children: [
              _InfoHeading('So funktioniert\'s'),
              _InfoParagraph('1. Mindestens zwei Personen legen jeweils einen Finger auf das Display.'),
              _InfoParagraph('2. Alle Finger bleiben während des Countdowns liegen.'),
              _InfoParagraph('3. Vor dem Start sind 3, 5 oder 10 Sekunden wählbar.'),
              _InfoParagraph('4. Der helle, leuchtende Kreis zeigt die zufällig ausgewählte Person.'),
              _InfoParagraph('5. Das Ergebnis bleibt bis „Nochmal!“ sichtbar.'),
              _InfoParagraph('Wie viele Finger gleichzeitig erkannt werden, hängt vom Gerät ab. Wer während des Countdowns einen Finger hinzufügt oder entfernt, startet die Zeit erneut.'),
            ]),
            _InfoContent(children: [
              _InfoHeading('Impressum'),
              _InfoParagraph('Anbieter: Michael Wiedeck'),
              _DraftNotice('Entwurf: Die vollständige ladungsfähige Anschrift und bestätigte Kontaktangaben müssen vor einer Store-Veröffentlichung ergänzt und überprüft werden.'),
              _InfoParagraph('Weitere Informationen zum Anbieter: wiedeck.de'),
            ]),
            _InfoContent(children: [
              _InfoHeading('Datenschutzhinweise – Entwurf'),
              _InfoParagraph('Verantwortlicher: Michael Wiedeck. Vollständige Kontaktangaben folgen vor Veröffentlichung.'),
              _InfoParagraph('Die geplante native App verarbeitet die Positionen der Finger während der Auslosung vorübergehend auf dem Gerät. Nach dem Neustart der Runde werden diese Informationen verworfen.'),
              _InfoParagraph('Eine Registrierung, Werbung, Analyse-Tracking, ein Nutzerkonto und die Übertragung der Spieldaten an eigene Server sind derzeit nicht vorgesehen.'),
              _InfoParagraph('Bei einer späteren Veröffentlichung werden gegebenenfalls verwendete Drittanbieter und die tatsächliche Datenverarbeitung erneut geprüft.'),
              _DraftNotice('Diese Fassung ist noch keine abschließend geprüfte Datenschutzerklärung für die App-Stores.'),
            ]),
            _InfoContent(children: [
              _InfoHeading('Über Wer muss?!'),
              _InfoParagraph('Eine kleine Zufalls-App für die ganz großen Fragen. Finger drauf, Countdown abwarten und schauen, wen es trifft.'),
              _InfoParagraph('Version: Prototyp v0.3'),
              _InfoParagraph('Logo: WM04b'),
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
    child: Text(text, style: const TextStyle(
      fontSize: 22, color: AppInformationPage._accent, fontWeight: FontWeight.w900)),
  );
}

class _InfoParagraph extends StatelessWidget {
  const _InfoParagraph(this.text);
  final String text;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 13),
    child: Text(text, style: const TextStyle(fontSize: 14, height: 1.55, color: Color(0xFFE3E0F1))),
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
    child: Text(text, style: const TextStyle(fontSize: 13, height: 1.5)),
  );
}
