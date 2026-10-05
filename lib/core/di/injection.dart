import 'package:get_it/get_it.dart';

import '../locale/app_locale_controller.dart';
import '../security/app_biometric_unlock_controller.dart';
import '../theme/app_theme_controller.dart';
import '../../features/tuner/data/datasources/microphone_datasource.dart';
import '../../features/tuner/data/datasources/tone_player_datasource.dart';
import '../../features/tuner/presentation/cubit/auto_tuner_cubit.dart';
import '../../features/tuner/presentation/cubit/manual_tuner_cubit.dart';

final getIt = GetIt.instance;

/// Registers every dependency.
void setupDi() {
  getIt.registerLazySingleton<AppLocaleController>(AppLocaleController.new);
  getIt.registerLazySingleton<AppThemeController>(AppThemeController.new);
  getIt.registerLazySingleton<AppBiometricUnlockController>(
    AppBiometricUnlockController.new,
  );

  // tuner: each page owns its cubit, so the mic and the tone stop when the
  // page closes.
  getIt.registerFactory<MicrophoneDatasource>(MicrophoneDatasource.new);
  getIt.registerFactory<TonePlayerDatasource>(TonePlayerDatasource.new);
  getIt.registerFactory<AutoTunerCubit>(
    () => AutoTunerCubit(microphone: getIt()),
  );
  getIt.registerFactory<ManualTunerCubit>(
    () => ManualTunerCubit(player: getIt()),
  );
}
