import 'dart:math';

/// Uniformly selects an index among [participantCount] participants.
/// Returns null until at least two participants are present.
int? chooseParticipant(Random rng, int participantCount) {
  if (participantCount < 2) return null;
  return rng.nextInt(participantCount);
}
