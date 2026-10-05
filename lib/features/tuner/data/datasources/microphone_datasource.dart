import 'dart:async';
import 'dart:typed_data';

import 'package:record/record.dart';

/// Streams mono PCM frames from the microphone as normalized floats (-1..1).
class MicrophoneDatasource {
  static const sampleRate = 44100;

  /// Samples per analysis frame. ~93 ms at 44.1 kHz covers several periods of
  /// low E (82 Hz), which autocorrelation needs to lock on.
  static const frameSize = 4096;

  AudioRecorder? _recorder;
  StreamSubscription<Uint8List>? _subscription;

  /// Asks for microphone access if needed. False when the user denied it.
  Future<bool> hasPermission() =>
      (_recorder ??= AudioRecorder()).hasPermission();

  /// Starts recording and calls [onFrame] with every full [frameSize] window.
  Future<void> start(void Function(Float32List frame) onFrame) async {
    await stop();
    final recorder = _recorder ??= AudioRecorder();
    final stream = await recorder.startStream(
      const RecordConfig(
        encoder: AudioEncoder.pcm16bits,
        sampleRate: sampleRate,
        numChannels: 1,
        autoGain: false,
        echoCancel: false,
        noiseSuppress: false,
      ),
    );

    final pending = <int>[];
    _subscription = stream.listen((chunk) {
      pending.addAll(chunk);
      const frameBytes = frameSize * 2;
      while (pending.length >= frameBytes) {
        final bytes = Uint8List.fromList(pending.sublist(0, frameBytes));
        pending.removeRange(0, frameBytes);
        final pcm = bytes.buffer.asInt16List();
        final frame = Float32List(frameSize);
        for (var i = 0; i < frameSize; i++) {
          frame[i] = pcm[i] / 32768;
        }
        onFrame(frame);
      }
    });
  }

  Future<void> stop() async {
    await _subscription?.cancel();
    _subscription = null;
    if (await _recorder?.isRecording() ?? false) {
      await _recorder?.stop();
    }
  }

  Future<void> dispose() async {
    await stop();
    await _recorder?.dispose();
    _recorder = null;
  }
}
