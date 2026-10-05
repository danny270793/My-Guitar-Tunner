import 'package:flutter/material.dart';

/// Horizontal meter showing how flat or sharp the pitch is, in cents (±50).
class CentsMeter extends StatelessWidget {
  const CentsMeter({super.key, required this.cents, required this.inTune});

  final double cents;
  final bool inTune;

  static const _range = 50.0;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final indicator = inTune ? Colors.green : Colors.orange;
    final position = (cents.clamp(-_range, _range) + _range) / (2 * _range);

    return SizedBox(
      height: 24,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final width = constraints.maxWidth;
          return Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: 8,
                decoration: BoxDecoration(
                  color: scheme.onSurface.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              Container(
                width: width * 0.1,
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              AnimatedAlign(
                duration: const Duration(milliseconds: 150),
                curve: Curves.easeOut,
                alignment: Alignment(position * 2 - 1, 0),
                child: Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: indicator,
                    shape: BoxShape.circle,
                    boxShadow: inTune
                        ? [
                            BoxShadow(
                              color: indicator.withValues(alpha: 0.5),
                              blurRadius: 8,
                            ),
                          ]
                        : null,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
