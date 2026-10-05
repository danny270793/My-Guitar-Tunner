import 'dart:math' as math;
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:my_guitar_tunner/features/tuner/domain/entities/guitar_string.dart';
import 'package:my_guitar_tunner/features/tuner/domain/entities/tuner_reading.dart';
import 'package:my_guitar_tunner/features/tuner/domain/services/pitch_detector.dart';
import 'package:my_guitar_tunner/features/tuner/domain/services/tone_generator.dart';

Float32List _sine(double frequency, {int sampleRate = 44100, int n = 4096}) =>
    Float32List.fromList([
      for (var i = 0; i < n; i++)
        0.5 * math.sin(2 * math.pi * frequency * i / sampleRate),
    ]);

void main() {
  group('PitchDetector', () {
    const detector = PitchDetector();

    for (final string in standardTuning) {
      test('detects ${string.id} within 1 Hz', () {
        final f = detector.detect(_sine(string.frequency), 44100);
        expect(f, isNotNull);
        expect(f!, closeTo(string.frequency, 1));
      });
    }

    test('ignores silence', () {
      expect(detector.detect(Float32List(4096), 44100), isNull);
    });
  });

  group('TunerReading', () {
    test('A4 is in tune at 440 Hz', () {
      final r = TunerReading.fromFrequency(440)!;
      expect(r.noteName, 'A');
      expect(r.octave, 4);
      expect(r.isInTune, isTrue);
    });

    test('a flat low E asks to tune up', () {
      final r = TunerReading.fromFrequency(81)!;
      expect(r.noteName, 'E');
      expect(r.octave, 2);
      expect(r.isFlat, isTrue);
    });

    test('a sharp G asks to tune down', () {
      final r = TunerReading.fromFrequency(200)!;
      expect(r.noteName, 'G');
      expect(r.isSharp, isTrue);
    });
  });

  test('nearest string uses a log scale', () {
    expect(GuitarString.nearest(100)!.id, 'A2');
    expect(GuitarString.nearest(300)!.id, 'E4');
  });

  test('tone generator writes a valid mono WAV header', () {
    final wav = const ToneGenerator().wav(110);
    final header = ByteData.sublistView(wav, 0, 44);
    expect(String.fromCharCodes(wav.sublist(0, 4)), 'RIFF');
    expect(String.fromCharCodes(wav.sublist(8, 12)), 'WAVE');
    expect(header.getUint16(22, Endian.little), 1);
    expect(header.getUint32(40, Endian.little), wav.length - 44);
  });
}
