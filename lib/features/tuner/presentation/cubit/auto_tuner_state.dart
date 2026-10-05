import 'package:equatable/equatable.dart';

import '../../domain/entities/guitar_string.dart';
import '../../domain/entities/tuner_reading.dart';

enum AutoTunerStatus { idle, listening, permissionDenied }

class AutoTunerState extends Equatable {
  const AutoTunerState({
    this.status = AutoTunerStatus.idle,
    this.reading,
    this.detectedString,
  });

  final AutoTunerStatus status;
  final TunerReading? reading;
  final GuitarString? detectedString;

  @override
  List<Object?> get props => [status, reading, detectedString];
}
