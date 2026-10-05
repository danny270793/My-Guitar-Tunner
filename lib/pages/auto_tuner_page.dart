import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/di/injection.dart';
import '../features/tuner/domain/entities/tuner_reading.dart';
import '../features/tuner/presentation/cubit/auto_tuner_cubit.dart';
import '../features/tuner/presentation/cubit/auto_tuner_state.dart';
import '../l10n/app_localizations.dart';
import '../widgets/cents_meter.dart';
import '../widgets/string_selector.dart';
import '../widgets/tuner_card.dart';

/// Auto mode: listens to the microphone while the page is open.
class AutoTunerPage extends StatelessWidget {
  const AutoTunerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AutoTunerCubit>()..start(),
      child: const _AutoTunerView(),
    );
  }
}

class _AutoTunerView extends StatefulWidget {
  const _AutoTunerView();

  @override
  State<_AutoTunerView> createState() => _AutoTunerViewState();
}

/// Releases the microphone while the app is in the background.
class _AutoTunerViewState extends State<_AutoTunerView>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final cubit = context.read<AutoTunerCubit>();
    if (state == AppLifecycleState.paused) {
      unawaited(cubit.stop());
    } else if (state == AppLifecycleState.resumed) {
      unawaited(cubit.start());
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.autoMode)),
      body: SafeArea(
        child: BlocBuilder<AutoTunerCubit, AutoTunerState>(
          builder: (context, state) => Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
            child: Column(
              children: [
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      child: TunerCard(child: _card(context, l10n, state)),
                    ),
                  ),
                ),
                StringSelector(highlighted: state.detectedString),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _card(
    BuildContext context,
    AppLocalizations l10n,
    AutoTunerState state,
  ) {
    final reading = state.reading;
    if (reading != null) return _ReadingView(reading: reading);
    if (state.status == AutoTunerStatus.permissionDenied) {
      return TunerMessage(
        icon: Icons.mic_off_rounded,
        color: Theme.of(context).colorScheme.error,
        message: l10n.microphoneAccessRequired,
      );
    }
    return TunerMessage(
      icon: Icons.graphic_eq_rounded,
      message: l10n.playANote,
    );
  }
}

class _ReadingView extends StatelessWidget {
  const _ReadingView({required this.reading});

  final TunerReading reading;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final (label, icon, color) = reading.isInTune
        ? (l10n.inTune, Icons.check_circle_rounded, Colors.green)
        : reading.isFlat
        ? (l10n.tuneUp, Icons.arrow_circle_up_rounded, Colors.orange)
        : (l10n.tuneDown, Icons.arrow_circle_down_rounded, Colors.orange);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        NoteReadout(
          note: reading.noteName,
          frequencyLabel: l10n.hz(reading.frequency.toStringAsFixed(1)),
          highlight: reading.isInTune,
        ),
        const SizedBox(height: 24),
        CentsMeter(cents: reading.cents, inTune: reading.isInTune),
        const SizedBox(height: 24),
        DecoratedBox(
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(32),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: color),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: Theme.of(context).textTheme.titleLarge
                      ?.copyWith(fontWeight: FontWeight.w700, color: color),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
