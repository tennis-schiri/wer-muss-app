import 'dart:math';
import 'package:flutter_test/flutter_test.dart';
import 'package:wer_muss/selection.dart';

void main() {
  test('no winner with fewer than two participants', () {
    expect(chooseParticipant(Random(2), 0), isNull);
    expect(chooseParticipant(Random(2), 1), isNull);
  });

  test('every result is within the participant range', () {
    final rng = Random(123);
    for (var size = 2; size <= 10; size++) {
      for (var i = 0; i < 100; i++) {
        final result = chooseParticipant(rng, size);
        expect(result, inInclusiveRange(0, size - 1));
      }
    }
  });

  test('each participant can be selected', () {
    final rng = Random(456);
    final winners = <int>{};
    for (var i = 0; i < 500; i++) {
      winners.add(chooseParticipant(rng, 4)!);
    }
    expect(winners, {0, 1, 2, 3});
  });
}
