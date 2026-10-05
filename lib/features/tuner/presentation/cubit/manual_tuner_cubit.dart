import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/logger/app_logger.dart';
import '../../data/datasources/tone_player_datasource.dart';
import '../../domain/entities/guitar_string.dart';

/// Manual mode: tapping a string plays its reference tone (no microphone)
/// until that same string is tapped again. State is the string sounding now.
class ManualTunerCubit extends Cubit<GuitarString?> {
  ManualTunerCubit({required this._player}) : super(null);

  final TonePlayerDatasource _player;

  Future<void> toggle(GuitarString string) async {
    if (state == string) {
      await stop();
      return;
    }
    emit(string);
    try {
      await _player.play(string.frequency);
    } catch (e) {
      AppLogger.info('reference tone failed: $e');
      if (!isClosed && state == string) emit(null);
    }
  }

  Future<void> stop() async {
    await _player.stop();
    if (!isClosed) emit(null);
  }

  @override
  Future<void> close() async {
    await _player.dispose();
    return super.close();
  }
}
