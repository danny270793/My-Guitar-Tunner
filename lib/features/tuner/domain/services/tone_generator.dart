import 'dart:math' as math;
import 'dart:typed_data';

/// Builds a looping reference tone as an in-memory 16-bit mono WAV file.
///
/// Low strings (E2 82 Hz, A2 110 Hz) barely register as a bare sine on a phone
/// speaker, so harmonics with a sawtooth-like falloff are layered in to keep
/// the pitch audible where the fundamental itself is weak.
class ToneGenerator {
  const ToneGenerator({this.sampleRate = 44100, this.seconds = 2});

  final int sampleRate;

  /// Length of one loop. The sample count is rounded to whole periods so the
  /// loop point lands on a zero crossing and does not click.
  final int seconds;

  static const _harmonicWeights = [1.0, 0.5, 0.33, 0.22];
  static const _masterGain = 0.9;

  Uint8List wav(double frequency) {
    final periods = (frequency * seconds).round();
    final sampleCount = (periods * sampleRate / frequency).round();
    final totalWeight = _harmonicWeights.reduce((a, b) => a + b);
    final pcm = Int16List(sampleCount);
    for (var i = 0; i < sampleCount; i++) {
      final phase = 2 * math.pi * frequency * i / sampleRate;
      var sum = 0.0;
      for (var h = 0; h < _harmonicWeights.length; h++) {
        sum += math.sin(phase * (h + 1)) * _harmonicWeights[h];
      }
      pcm[i] = (sum * _masterGain / totalWeight * 32767).round();
    }
    return _withHeader(pcm.buffer.asUint8List());
  }

  Uint8List _withHeader(Uint8List data) {
    final header = ByteData(44);
    void ascii(int offset, String s) {
      for (var i = 0; i < s.length; i++) {
        header.setUint8(offset + i, s.codeUnitAt(i));
      }
    }

    ascii(0, 'RIFF');
    header.setUint32(4, 36 + data.length, Endian.little);
    ascii(8, 'WAVE');
    ascii(12, 'fmt ');
    header.setUint32(16, 16, Endian.little);
    header.setUint16(20, 1, Endian.little); // PCM
    header.setUint16(22, 1, Endian.little); // mono
    header.setUint32(24, sampleRate, Endian.little);
    header.setUint32(28, sampleRate * 2, Endian.little);
    header.setUint16(32, 2, Endian.little);
    header.setUint16(34, 16, Endian.little);
    ascii(36, 'data');
    header.setUint32(40, data.length, Endian.little);
    return Uint8List.fromList([...header.buffer.asUint8List(), ...data]);
  }
}
