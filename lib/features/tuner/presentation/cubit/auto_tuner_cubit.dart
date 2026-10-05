import 'dart:typed_data';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/logger/app_logger.dart';
import '../../data/datasources/microphone_datasource.dart';
import '../../domain/entities/guitar_string.dart';
import '../../domain/entities/tuner_reading.dart';
import '../../domain/services/pitch_detector.dart';
import 'auto_tuner_state.dart';

/// Auto mode: listens to the microphone and maps the detected pitch to the
/// nearest chromatic note and guitar string.
class AutoTunerCubit extends Cubit<AutoTunerState> {
  AutoTunerCubit({
    required this._microphone,
    this._detector = const PitchDetector(),
  }) : super(const AutoTunerState());

  final MicrophoneDatasource _microphone;
  final PitchDetector _detector;

  Future<void> start() async {
    if (state.status == AutoTunerStatus.listening) return;
    try {
      if (!await _microphone.hasPermission()) {
        if (!isClosed) {
          emit(const AutoTunerState(status: AutoTunerStatus.permissionDenied));
        }
        return;
      }
      if (isClosed) return;
      await _microphone.start(_onFrame);
      if (!isClosed) {
        emit(const AutoTunerState(status: AutoTunerStatus.listening));
      }
    } catch (e) {
      AppLogger.info('microphone failed to start: $e');
      if (!isClosed) {
        emit(const AutoTunerState(status: AutoTunerStatus.permissionDenied));
      }
    }
  }

  void _onFrame(Float32List frame) {
    if (isClosed) return;
    final frequency = _detector.detect(frame, MicrophoneDatasource.sampleRate);
    emit(
      AutoTunerState(
        status: AutoTunerStatus.listening,
        reading: frequency == null
            ? null
            : TunerReading.fromFrequency(frequency),
        detectedString: frequency == null
            ? null
            : GuitarString.nearest(frequency),
      ),
    );
  }

  Future<void> stop() async {
    await _microphone.stop();
    if (!isClosed) emit(const AutoTunerState());
  }

  @override
  Future<void> close() async {
    await _microphone.dispose();
    return super.close();
  }
}
