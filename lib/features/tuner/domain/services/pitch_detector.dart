import 'dart:math' as math;
import 'dart:typed_data';

/// Estimates the fundamental frequency of a mono PCM frame via normalized
/// autocorrelation with parabolic interpolation around the strongest peak.
class PitchDetector {
  const PitchDetector({
    this.minFrequency = 70,
    this.maxFrequency = 1000,
    this.minRms = 0.01,
  });

  final double minFrequency;
  final double maxFrequency;

  /// Frames quieter than this (0-1 RMS) are treated as silence.
  final double minRms;

  double? detect(Float32List samples, int sampleRate) {
    final n = samples.length;
    if (n < 2) return null;

    var sumSquares = 0.0;
    for (final s in samples) {
      sumSquares += s * s;
    }
    if (math.sqrt(sumSquares / n) <= minRms) return null;

    final minLag = math.max(1, sampleRate ~/ maxFrequency);
    final maxLag = math.min(sampleRate ~/ minFrequency, n - 2);
    if (maxLag <= minLag + 1) return null;

    final ac = Float64List(maxLag + 2);
    for (var lag = 0; lag <= maxLag + 1; lag++) {
      var sum = 0.0;
      for (var i = 0; i < n - lag; i++) {
        sum += samples[i] * samples[i + lag];
      }
      ac[lag] = sum;
    }
    if (ac[0] <= 0) return null;

    var bestLag = -1;
    var bestValue = 0.0;
    for (var lag = minLag; lag <= maxLag; lag++) {
      final v = ac[lag];
      if (v > ac[lag - 1] && v > ac[lag + 1] && v > bestValue) {
        bestValue = v;
        bestLag = lag;
      }
    }
    if (bestLag <= 0 || bestValue / ac[0] <= 0.3) return null;

    final y0 = ac[bestLag - 1];
    final y1 = ac[bestLag];
    final y2 = ac[bestLag + 1];
    final denominator = y0 - 2 * y1 + y2;
    final shift = denominator != 0 ? 0.5 * (y0 - y2) / denominator : 0.0;
    final refinedLag = bestLag + shift;
    if (refinedLag <= 0) return null;

    final frequency = sampleRate / refinedLag;
    if (frequency < minFrequency || frequency > maxFrequency) return null;
    return frequency;
  }
}
