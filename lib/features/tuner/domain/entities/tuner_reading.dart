import 'dart:math' as math;

import 'package:equatable/equatable.dart';

/// A snapshot of the detected pitch mapped to the nearest chromatic note.
class TunerReading extends Equatable {
  const TunerReading({
    required this.noteName,
    required this.octave,
    required this.frequency,
    required this.targetFrequency,
    required this.cents,
  });

  final String noteName;
  final int octave;
  final double frequency;
  final double targetFrequency;

  /// Deviation from the nearest note, in cents. Negative is flat, positive is sharp.
  final double cents;

  /// Cents within this threshold are considered in tune.
  static const inTuneThreshold = 5.0;

  bool get isInTune => cents.abs() <= inTuneThreshold;
  bool get isFlat => cents < -inTuneThreshold;
  bool get isSharp => cents > inTuneThreshold;

  static const _noteNames = [
    'C', 'C♯', 'D', 'D♯', 'E', 'F', 'F♯', 'G', 'G♯', 'A', 'A♯', 'B', //
  ];

  /// Maps [frequency] to the nearest chromatic note using equal temperament
  /// (A4 = [referenceA4] Hz), returning how far off the pitch is in cents.
  static TunerReading? fromFrequency(
    double frequency, {
    double referenceA4 = 440,
  }) {
    if (frequency <= 0) return null;
    final midi = 69 + 12 * math.log(frequency / referenceA4) / math.ln2;
    final roundedMidi = midi.round();
    return TunerReading(
      noteName: _noteNames[roundedMidi % 12],
      octave: roundedMidi ~/ 12 - 1,
      frequency: frequency,
      targetFrequency:
          referenceA4 * math.pow(2, (roundedMidi - 69) / 12).toDouble(),
      cents: (midi - roundedMidi) * 100,
    );
  }

  @override
  List<Object?> get props => [noteName, octave, frequency, targetFrequency];
}
