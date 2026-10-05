import 'package:flutter/material.dart';

import '../features/tuner/domain/entities/guitar_string.dart';

/// Row of the six guitar strings (low E to high E). The highlighted string is
/// green; pass [onSelect] to make the badges tappable, or omit it for a
/// display-only row driven by pitch detection.
class StringSelector extends StatelessWidget {
  const StringSelector({super.key, required this.highlighted, this.onSelect});

  final GuitarString? highlighted;
  final ValueChanged<GuitarString>? onSelect;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 10,
      runSpacing: 10,
      children: [
        for (final string in standardTuning)
          _StringBadge(
            string: string,
            highlighted: string == highlighted,
            onTap: onSelect == null ? null : () => onSelect!(string),
          ),
      ],
    );
  }
}

class _StringBadge extends StatelessWidget {
  const _StringBadge({
    required this.string,
    required this.highlighted,
    required this.onTap,
  });

  final GuitarString string;
  final bool highlighted;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final background = highlighted
        ? Colors.green.shade600
        : scheme.surfaceContainerHighest;
    final foreground = highlighted ? Colors.white : scheme.onSurface;

    return Semantics(
      button: onTap != null,
      selected: highlighted,
      label: '${string.name}${string.octave}',
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 52,
        height: 52,
        decoration: BoxDecoration(
          color: background,
          shape: BoxShape.circle,
          boxShadow: highlighted
              ? [
                  BoxShadow(
                    color: Colors.green.withValues(alpha: 0.45),
                    blurRadius: 12,
                  ),
                ]
              : null,
        ),
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: onTap,
            child: Center(
              child: ExcludeSemantics(
                child: Text(
                  string.name,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: foreground,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
