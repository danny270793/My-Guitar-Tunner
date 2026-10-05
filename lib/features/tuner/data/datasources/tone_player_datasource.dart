import 'package:audioplayers/audioplayers.dart';

import '../../domain/services/tone_generator.dart';

/// Plays a reference tone on loop until [stop] is called.
class TonePlayerDatasource {
  TonePlayerDatasource({this._generator = const ToneGenerator()});

  final ToneGenerator _generator;
  AudioPlayer? _player;

  AudioPlayer get _audio =>
      _player ??= (AudioPlayer(playerId: 'reference_tone')
        ..setReleaseMode(ReleaseMode.loop));

  Future<void> play(double frequency) async {
    await _audio.stop();
    await _audio.play(
      BytesSource(_generator.wav(frequency), mimeType: 'audio/wav'),
    );
  }

  Future<void> stop() async => _player?.stop();

  Future<void> dispose() async {
    await _player?.dispose();
    _player = null;
  }
}
