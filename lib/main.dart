import 'dart:async';
import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'selection.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const WerMussApp());
}

class WerMussApp extends StatelessWidget {
  const WerMussApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      home: const PickScreen(),
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
  static const duration = Duration(seconds: 3);

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
    _remaining = 3;
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
        point.dx.clamp(31.0, max(31.0, _stageSize.width - 31)).toDouble(),
        point.dy.clamp(31.0, max(31.0, _stageSize.height - 31)).toDouble(),
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
      _remaining = 3;
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
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Center(
                child: Text('WER MUSS?!',
                    style: TextStyle(
                        fontSize: 29,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -1.1)),
              ),
              const SizedBox(height: 18),
              Expanded(
                child: LayoutBuilder(builder: (context, bounds) {
                  _stageSize = bounds.biggest;
                  return Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      color: panel,
                      borderRadius: BorderRadius.circular(30),
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
                                    'SPIELFLÄCHE  /  $count FINGER',
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
                          ..._fingers.entries.map((entry) {
                            final id = entry.key;
                            final selected = _winnerId == id;
                            final color = _fingerColors[id] ?? paleYellow;
                            return Positioned(
                              left: entry.value.dx - (selected ? 43 : 29),
                              top: entry.value.dy - (selected ? 43 : 29),
                              child: IgnorePointer(
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 230),
                                  width: selected ? 86 : 58,
                                  height: selected ? 86 : 58,
                                  decoration: BoxDecoration(
                                    color: color.withValues(alpha: selected ? .42 : .22),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: color,
                                      width: selected ? 5 : 3,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: color.withValues(alpha: selected ? .60 : .16),
                                        blurRadius: selected ? 36 : 19,
                                        spreadRadius: selected ? 7 : 1,
                                      ),
                                    ],
                                  ),
                                  child: Icon(
                                    selected ? Icons.emoji_events : Icons.circle,
                                    color: color,
                                    size: selected ? 35 : 15,
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
                                    const Text('DAS LOS HAT ENTSCHIEDEN',
                                        style: TextStyle(
                                            fontSize: 10,
                                            color: lavender,
                                            letterSpacing: 1.6,
                                            fontWeight: FontWeight.w900)),
                                    const SizedBox(height: 10),
                                    const Text('DU MUSST!',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 40,
                                          fontWeight: FontWeight.w900,
                                          color: paleYellow,
                                          letterSpacing: -2.0,
                                        )),
                                    const SizedBox(height: 7),
                                    const Text('Tja. Heute bist du dran.',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Color(0xFFC1BFD5),
                                            fontSize: 12)),
                                  ] else if (hasCountdown) ...[
                                    const Text('NICHT LOSLASSEN',
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
                                    const Text('ALLE FINGER',
                                        style: TextStyle(
                                            fontSize: 32,
                                            fontWeight: FontWeight.w900,
                                            letterSpacing: -1.4)),
                                    const Text('AUFS DISPLAY!',
                                        style: TextStyle(
                                            fontSize: 32,
                                            fontWeight: FontWeight.w900,
                                            color: paleYellow,
                                            letterSpacing: -1.4)),
                                    const SizedBox(height: 13),
                                    const Text('Mindestens zwei Personen',
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
                                    ? 'Der leuchtende Finger wurde ausgelost.'
                                    : hasCountdown
                                        ? 'Finger drauflassen, sonst beginnt die Zeit neu.'
                                        : 'Jede Person legt einen Finger auf die Fläche.',
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 11,
                                    color: Color(0xFFA6A3BC)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 14),
              SizedBox(
                height: 54,
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
                        ? 'NOCHMAL! ↻'
                        : 'ALLEIN TESTEN  ·  4 FINGER',
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      letterSpacing: .3,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 9),
              const Text('Kein Login. Keine Werbung. Nur eine Entscheidung.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 10, color: Color(0xFF8F8DA6))),
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
