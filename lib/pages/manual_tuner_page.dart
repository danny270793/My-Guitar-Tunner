import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/di/injection.dart';
import '../features/tuner/domain/entities/guitar_string.dart';
import '../features/tuner/presentation/cubit/manual_tuner_cubit.dart';
import '../l10n/app_localizations.dart';
import '../widgets/string_selector.dart';
import '../widgets/tuner_card.dart';

/// Manual mode: the string row is the control. Tapping a string plays its
/// reference tone until it is tapped again or the page closes.
class ManualTunerPage extends StatelessWidget {
  const ManualTunerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocProvider(
      create: (_) => getIt<ManualTunerCubit>(),
      child: Scaffold(
        appBar: AppBar(title: Text(l10n.manualMode)),
        body: SafeArea(
          child: BlocBuilder<ManualTunerCubit, GuitarString?>(
            builder: (context, playing) => Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
              child: Column(
                children: [
                  Expanded(
                    child: Center(
                      child: SingleChildScrollView(
                        child: TunerCard(
                          child: playing == null
                              ? TunerMessage(
                                  icon: Icons.touch_app_outlined,
                                  message: l10n.tapAStringToHear,
                                )
                              : NoteReadout(
                                  note: playing.name,
                                  frequencyLabel: l10n.hz(
                                    playing.frequency.toStringAsFixed(1),
                                  ),
                                  highlight: true,
                                ),
                        ),
                      ),
                    ),
                  ),
                  StringSelector(
                    highlighted: playing,
                    onSelect: context.read<ManualTunerCubit>().toggle,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
