import 'dart:math' as math;

import 'package:equatable/equatable.dart';

/// One string of a standard-tuned guitar.
class GuitarString extends Equatable {
  const GuitarString({
    required this.name,
    required this.octave,
    required this.frequency,
  });

  final String name;
  final int octave;
  final double frequency;

  String get id => '$name$octave';

  /// The string whose frequency is perceptually closest to [frequency]
  /// (compared on a log scale, matching pitch perception).
  static GuitarString? nearest(
    double frequency, {
    List<GuitarString> strings = standardTuning,
  }) {
    if (frequency <= 0 || strings.isEmpty) return null;
    double distance(GuitarString s) =>
        (math.log(s.frequency / frequency) / math.ln2).abs();
    return strings.reduce((a, b) => distance(a) <= distance(b) ? a : b);
  }

  @override
  List<Object?> get props => [name, octave, frequency];
}

/// Low E to high E, matching how strings are laid out on the instrument.
const standardTuning = <GuitarString>[
  GuitarString(name: 'E', octave: 2, frequency: 82.41),
  GuitarString(name: 'A', octave: 2, frequency: 110.00),
  GuitarString(name: 'D', octave: 3, frequency: 146.83),
  GuitarString(name: 'G', octave: 3, frequency: 196.00),
  GuitarString(name: 'B', octave: 3, frequency: 246.94),
  GuitarString(name: 'E', octave: 4, frequency: 329.63),
];
