import 'dart:async';
import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'selection.dart';
import 'brand_icon.dart';
import 'app_information.dart';
import 'language.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await initializeAppLanguage();
  runApp(const WerMussApp());
}

class WerMussApp extends StatelessWidget {
  const WerMussApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: appLanguage,
      builder: (context, language, child) => AppLanguageScope(
        notifier: appLanguage,
        child: MaterialApp(
          locale: Locale(language),
          supportedLocales: const [Locale('de'), Locale('en')],
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
      title: 'Wer muss?!',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF111224),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFF5F36D),
          brightness: Brightness.dark,
        ),
      ),
      home: const WelcomeScreen(),
        ),
      ),
    );
  }
}


class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  static const _bg = Color(0xFF111224);
  static const _accent = Color(0xFFF5F36D);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(22, 6, 22, 16),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const LanguageToggle(),
                  const SizedBox(width: 8),
                  IconButton(
                  tooltip: tr(context, 'Anleitung und rechtliche Hinweise', 'Instructions and legal information'),
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute<void>(
                      builder: (_) => const AppInformationPage(),
                    ),
                  ),
                  icon: const Icon(Icons.info_outline, color: _accent),
                  ),
                ],
              ),
              const Spacer(),
              const Wm04bIcon(size: 112),
              const SizedBox(height: 22),
              const Text(
                'WER MUSS?!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 44,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: -2.2,
                ),
              ),
              const SizedBox(height: 8),
              Text(tr(context, 'Eine Frage. Viele Finger.\nEine zufällige Entscheidung.', 'One question. Many fingers.\nOne random decision.'),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFFCDC9E0),
                  height: 1.45,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 32),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 19, horizontal: 14),
                decoration: BoxDecoration(
                  color: const Color(0xFF1D1D37),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: const Color(0xFF45435F)),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _PreviewFinger(color: Color(0xFFB6A5FF)),
                        SizedBox(width: 14),
                        _PreviewFinger(color: Color(0xFFF5F36D), selected: true),
                        SizedBox(width: 14),
                        _PreviewFinger(color: Color(0xFF71E6C8)),
                      ],
                    ),
                    SizedBox(height: 16),
                    Text(
                      tr(context, 'Finger auflegen. Countdown abwarten.\nDer leuchtende Kreis entscheidet.', 'Place your fingers. Wait for the countdown.\nThe glowing circle decides.'),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFFC7C3D9),
                        fontSize: 13,
                        height: 1.45,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Text(tr(context, 'Ab 2 Personen  ·  3 / 5 / 10 Sekunden', '2+ players  ·  3 / 5 / 10 seconds'),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFFA9A5BF),
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                height: 58,
                width: double.infinity,
                child: FilledButton(
                  onPressed: () => Navigator.of(context).pushReplacement(
                    MaterialPageRoute<void>(
                      builder: (_) => const PickScreen(),
                    ),
                  ),
                  style: FilledButton.styleFrom(
                    backgroundColor: _accent,
                    foregroundColor: _bg,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: Text(tr(context, 'LOS GEHT’S!', 'LET’S GO!'),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.4,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PreviewFinger extends StatelessWidget {
  const _PreviewFinger({required this.color, this.selected = false});
  final Color color;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: selected ? 68 : 60,
      height: selected ? 68 : 60,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withValues(alpha: selected ? .55 : .20),
        border: Border.all(
          color: selected ? Colors.white : color,
          width: selected ? 5 : 3,
        ),
        boxShadow: selected
            ? [BoxShadow(color: color.withValues(alpha: .45), blurRadius: 22)]
            : [],
      ),
      child: selected
          ? const Icon(Icons.star_rounded, color: Color(0xFF111224), size: 34)
          : Icon(Icons.circle, color: color, size: 13),
    );
  }
}

class PickScreen extends StatefulWidget {
  const PickScreen({super.key});

  @override
  State<PickScreen> createState() => _PickScreenState();
}

class _PickScreenState extends State<PickScreen> {
  static const background = Color(0xFF111224);
  static const panel = Color(0xFF1D1D37);
  static const paleYellow = Color(0xFFF5F36D);
  static const lavender = Color(0xFFB6A5FF);
  static const salmon = Color(0xFFFF9288);
  static const mint = Color(0xFF71E6C8);
  static const blue = Color(0xFF85B9FF);
  static const playerColors = [paleYellow, lavender, salmon, mint, blue];
  static const countdownOptions = [3, 5, 10];
  int _countdownSeconds = 3;
  Duration get duration => Duration(seconds: _countdownSeconds);

  final _rng = Random.secure();
  final Map<int, Offset> _fingers = {};
  final Map<int, Color> _fingerColors = {};
  Timer? _ticker;
  DateTime? _startedAt;
  double _remaining = 3;
  int? _winnerId;
  bool _demoMode = false;
  Size _stageSize = const Size(360, 360);
  int _nextColorIndex = 0;

  bool get _decided => _winnerId != null;

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  void _startCountdown() {
    _ticker?.cancel();
    _ticker = null;
    _startedAt = null;
    _remaining = _countdownSeconds.toDouble();
    if (_fingers.length < 2 || _decided) return;
    _startedAt = DateTime.now();
    _ticker = Timer.periodic(const Duration(milliseconds: 50), _advance);
  }

  void _advance(Timer timer) {
    if (!mounted || _decided || _fingers.length < 2) {
      timer.cancel();
      return;
    }
    final elapsed = DateTime.now().difference(_startedAt!);
    if (elapsed >= duration) {
      final resultIndex = chooseParticipant(_rng, _fingers.length);
      if (resultIndex == null) return;
      setState(() {
        _winnerId = _fingers.keys.elementAt(resultIndex);
        _remaining = 0;
      });
      timer.cancel();
      HapticFeedback.heavyImpact();
    } else {
      setState(() =>
          _remaining = (duration - elapsed).inMilliseconds / 1000.0);
    }
  }

  Offset _inside(Offset point) => Offset(
        point.dx.clamp(45.0, max(45.0, _stageSize.width - 45)).toDouble(),
        point.dy.clamp(45.0, max(45.0, _stageSize.height - 45)).toDouble(),
      );

  void _pointerDown(PointerDownEvent event) {
    if (_decided || _demoMode) return;
    if (_fingers.containsKey(event.pointer)) return;
    setState(() {
      _fingers[event.pointer] = _inside(event.localPosition);
      _fingerColors[event.pointer] =
          playerColors[_nextColorIndex++ % playerColors.length];
      _startCountdown();
    });
  }

  void _pointerMove(PointerMoveEvent event) {
    if (_decided || !_fingers.containsKey(event.pointer)) return;
    setState(() => _fingers[event.pointer] = _inside(event.localPosition));
  }

  void _pointerEnd(PointerEvent event) {
    if (_decided || _demoMode || !_fingers.containsKey(event.pointer)) return;
    setState(() {
      _fingers.remove(event.pointer);
      _fingerColors.remove(event.pointer);
      _startCountdown();
    });
  }

  void _reset() {
    _ticker?.cancel();
    setState(() {
      _fingers.clear();
      _fingerColors.clear();
      _winnerId = null;
      _demoMode = false;
      _startedAt = null;
      _remaining = _countdownSeconds.toDouble();
      _nextColorIndex = 0;
    });
  }

  void _startDemo() {
    if (_decided || _fingers.isNotEmpty) _reset();
    final w = _stageSize.width;
    final h = _stageSize.height;
    setState(() {
      _demoMode = true;
      final points = [
        Offset(w * .27, h * .34),
        Offset(w * .74, h * .33),
        Offset(w * .28, h * .73),
        Offset(w * .72, h * .70),
      ];
      for (var i = 0; i < points.length; i++) {
        final id = -i - 1;
        _fingers[id] = _inside(points[i]);
        _fingerColors[id] = playerColors[i];
      }
      _startCountdown();
    });
  }

  @override
  Widget build(BuildContext context) {
    final count = _fingers.length;
    final hasCountdown = count >= 2 && !_decided;
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(7, 2, 7, 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 44,
                child: Row(
                  children: [
                    IconButton(
                      tooltip: tr(context, 'Zur Startseite', 'Home'),
                      icon: const Icon(Icons.home_outlined, size: 22),
                      onPressed: _fingers.isNotEmpty && !_decided
                          ? null
                          : () => Navigator.of(context).pushReplacement(
                              MaterialPageRoute<void>(
                                builder: (_) => const WelcomeScreen(),
                              ),
                            ),
                    ),
                    const Wm04bIcon(size: 30),
                    const SizedBox(width: 5),
                    const Expanded(
                      child: Text(
                        'WER MUSS?!',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w900,
                          letterSpacing: -0.9,
                        ),
                      ),
                    ),
                    const LanguageToggle(),
                    IconButton(
                      tooltip: tr(context,
                        'Anleitung und rechtliche Hinweise',
                        'Instructions and legal information'),
                      icon: const Icon(Icons.info_outline, color: paleYellow),
                      onPressed: _fingers.isNotEmpty && !_decided
                          ? null
                          : () => Navigator.of(context).push(
                              MaterialPageRoute<void>(
                                builder: (_) => const AppInformationPage(),
                              ),
                            ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 3),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(tr(context, 'Countdown:', 'Countdown:'),
                      style: TextStyle(
                          fontSize: 12, color: Color(0xFFBBB9D0))),
                  const SizedBox(width: 7),
                  for (final seconds in countdownOptions) ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: ChoiceChip(
                        label: Text('$seconds s'),
                        selected: _countdownSeconds == seconds,
                        onSelected: _fingers.isNotEmpty
                            ? null
                            : (_) => setState(() {
                                  _countdownSeconds = seconds;
                                  _remaining = seconds.toDouble();
                                }),
                        showCheckmark: false,
                        visualDensity: VisualDensity.compact,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        selectedColor: paleYellow,
                        backgroundColor: const Color(0xFF25253D),
                        labelStyle: TextStyle(
                          color: _countdownSeconds == seconds
                              ? background
                              : const Color(0xFFDDDBEA),
                          fontWeight: FontWeight.w800,
                        ),
                        side: BorderSide.none,
                      ),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 5),
              Expanded(
                child: LayoutBuilder(builder: (context, bounds) {
                  _stageSize = bounds.biggest;
                  return Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      color: panel,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          color: const Color(0xFF414058), width: 1),
                    ),
                    child: Listener(
                      behavior: HitTestBehavior.opaque,
                      onPointerDown: _pointerDown,
                      onPointerMove: _pointerMove,
                      onPointerUp: _pointerEnd,
                      onPointerCancel: _pointerEnd,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          IgnorePointer(
                            child: CustomPaint(painter: _SpecklePainter()),
                          ),
                          Positioned(
                            top: 18,
                            left: 18,
                            child: IgnorePointer(
                              child: Row(
                                children: [
                                  const Icon(Icons.circle, size: 8, color: mint),
                                  const SizedBox(width: 7),
                                  Text(
                                    tr(context, 'SPIELFLÄCHE  /  $count FINGER', 'PLAY AREA  /  $count FINGERS'),
                                    style: const TextStyle(
                                        color: Color(0xFFA6A3BC),
                                        fontWeight: FontWeight.w800,
                                        fontSize: 10,
                                        letterSpacing: 1),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          ..._fingers.entries.where((entry) => entry.key != _winnerId).map((entry) {
                            final color = _fingerColors[entry.key] ?? paleYellow;
                            return Positioned(
                              left: entry.value.dx - 44,
                              top: entry.value.dy - 44,
                              child: IgnorePointer(
                                child: AnimatedOpacity(
                                  duration: const Duration(milliseconds: 350),
                                  opacity: _decided ? .12 : 1,
                                  child: Container(
                                    width: 88,
                                    height: 88,
                                    decoration: BoxDecoration(
                                      color: color.withValues(alpha: .22),
                                      shape: BoxShape.circle,
                                      border: Border.all(color: color, width: 3),
                                      boxShadow: [
                                        BoxShadow(
                                          color: color.withValues(alpha: .16),
                                          blurRadius: 19,
                                        ),
                                      ],
                                    ),
                                    child: Icon(Icons.circle, color: color, size: 18),
                                  ),
                                ),
                              ),
                            );
                          }),
                          Align(
                            alignment: const Alignment(0, -.12),
                            child: IgnorePointer(
                              child: Container(
                                padding: _decided
                                    ? const EdgeInsets.symmetric(
                                        horizontal: 25, vertical: 22)
                                    : EdgeInsets.zero,
                                decoration: _decided
                                    ? BoxDecoration(
                                        color: const Color(0xF2111224),
                                        borderRadius: BorderRadius.circular(22),
                                        border: Border.all(
                                          color: const Color(0xFF45445C)),
                                      )
                                    : null,
                                child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (_decided) ...[
                                    Text(tr(context, 'DAS LOS HAT ENTSCHIEDEN', 'THE DRAW HAS DECIDED'),
                                        style: TextStyle(
                                            fontSize: 10,
                                            color: lavender,
                                            letterSpacing: 1.6,
                                            fontWeight: FontWeight.w900)),
                                    const SizedBox(height: 10),
                                    Text(tr(context, 'DU MUSST!', 'YOU’RE IT!'),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 40,
                                          fontWeight: FontWeight.w900,
                                          color: paleYellow,
                                          letterSpacing: -2.0,
                                        )),
                                    const SizedBox(height: 7),
                                    Text(tr(context, 'Der leuchtende Kreis zeigt, wer dran ist.', 'The glowing circle marks the chosen person.'),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Color(0xFFC1BFD5),
                                            fontSize: 12)),
                                  ] else if (hasCountdown) ...[
                                    Text(tr(context, 'NICHT LOSLASSEN', 'KEEP HOLDING'),
                                        style: TextStyle(
                                            fontSize: 11,
                                            letterSpacing: 1.4,
                                            color: lavender,
                                            fontWeight: FontWeight.w800)),
                                    Text('${_remaining.ceil()}',
                                        style: const TextStyle(
                                            fontSize: 104,
                                            height: 1.05,
                                            fontWeight: FontWeight.w900,
                                            color: paleYellow)),
                                  ] else ...[
                                    Text(tr(context, 'ALLE FINGER', 'ALL FINGERS'),
                                        style: TextStyle(
                                            fontSize: 32,
                                            fontWeight: FontWeight.w900,
                                            letterSpacing: -1.4)),
                                    Text(tr(context, 'AUFS DISPLAY!', 'ON SCREEN!'),
                                        style: TextStyle(
                                            fontSize: 32,
                                            fontWeight: FontWeight.w900,
                                            color: paleYellow,
                                            letterSpacing: -1.4)),
                                    const SizedBox(height: 13),
                                    Text(tr(context, 'Mindestens zwei Personen', 'At least two players'),
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: Color(0xFFC2C0D4))),
                                  ],
                                ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 20,
                            left: 16,
                            right: 16,
                            child: IgnorePointer(
                              child: Text(
                                _decided
                                    ? tr(context, 'Der hell markierte Finger muss! Sichtbar bis „Nochmal!“.', 'The highlighted finger is it! Visible until “Again!”.')
                                    : hasCountdown
                                        ? tr(context, 'Finger drauflassen, sonst beginnt die Zeit neu.', 'Keep holding, or the countdown restarts.')
                                        : tr(context, 'Jede Person legt einen Finger auf die Fläche.', 'Everyone places one finger on the screen.'),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 11,
                                    color: Color(0xFFA6A3BC)),
                              ),
                            ),
                          ),
                          // Draw the winning finger LAST so it cannot be hidden
                          // behind the centered results card or other fingers.
                          if (_winnerId != null && _fingers.containsKey(_winnerId))
                            Positioned(
                              left: _fingers[_winnerId]!.dx - 66,
                              top: _fingers[_winnerId]!.dy - 66,
                              child: IgnorePointer(
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 450),
                                  curve: Curves.easeOutBack,
                                  width: 132,
                                  height: 132,
                                  decoration: BoxDecoration(
                                    color: (_fingerColors[_winnerId] ?? paleYellow)
                                        .withValues(alpha: .88),
                                    shape: BoxShape.circle,
                                    border: Border.all(color: Colors.white, width: 7),
                                    boxShadow: [
                                      const BoxShadow(
                                        color: paleYellow,
                                        blurRadius: 0,
                                        spreadRadius: 8,
                                      ),
                                      BoxShadow(
                                        color: (_fingerColors[_winnerId] ?? paleYellow)
                                            .withValues(alpha: .85),
                                        blurRadius: 48,
                                        spreadRadius: 17,
                                      ),
                                    ],
                                  ),
                                  child: const Icon(
                                    Icons.star_rounded,
                                    color: background,
                                    size: 62,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 7),
              SizedBox(
                height: 49,
                child: FilledButton(
                  onPressed: _decided || _fingers.isNotEmpty ? _reset : _startDemo,
                  style: FilledButton.styleFrom(
                    backgroundColor: paleYellow,
                    foregroundColor: background,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(17)),
                  ),
                  child: Text(
                    _decided || _fingers.isNotEmpty
                        ? tr(context, 'NOCHMAL! ↻', 'AGAIN! ↻')
                        : tr(context, 'ALLEIN TESTEN  ·  4 FINGER', 'TRY SOLO  ·  4 FINGERS'),
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      letterSpacing: .3,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SpecklePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final pen = Paint()..color = const Color(0xFF343453);
    final positions = [
      const Offset(.10, .23), const Offset(.92, .17), const Offset(.79, .82),
      const Offset(.16, .87), const Offset(.51, .14), const Offset(.66, .56),
      const Offset(.31, .67), const Offset(.92, .57),
    ];
    for (final position in positions) {
      canvas.drawCircle(
        Offset(position.dx * size.width, position.dy * size.height),
        2.4,
        pen,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _SpecklePainter oldDelegate) => false;
}
