import 'package:flutter/material.dart';

/// Rounded surface that holds the note readout or a status message.
class TunerCard extends StatelessWidget {
  const TunerCard({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 360),
      child: Card(
        elevation: 0,
        color: scheme.surfaceContainerHigh,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 36),
          child: SizedBox(width: double.infinity, child: child),
        ),
      ),
    );
  }
}

/// Icon plus a centered message, e.g. "Play a note" or a permission error.
class TunerMessage extends StatelessWidget {
  const TunerMessage({
    super.key,
    required this.icon,
    required this.message,
    this.color,
  });

  final IconData icon;
  final String message;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final muted = theme.colorScheme.onSurfaceVariant;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 48, color: color ?? muted),
        const SizedBox(height: 16),
        Text(
          message,
          textAlign: TextAlign.center,
          style: theme.textTheme.titleMedium?.copyWith(color: muted),
        ),
      ],
    );
  }
}

/// Large note name with its frequency underneath.
class NoteReadout extends StatelessWidget {
  const NoteReadout({
    super.key,
    required this.note,
    required this.frequencyLabel,
    this.highlight = false,
  });

  final String note;
  final String frequencyLabel;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 200),
          style: theme.textTheme.displayLarge!.copyWith(
            fontSize: 96,
            fontWeight: FontWeight.w700,
            color: highlight ? Colors.green : theme.colorScheme.onSurface,
          ),
          child: Text(note),
        ),
        const SizedBox(height: 8),
        Text(
          frequencyLabel,
          style: theme.textTheme.titleMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
            fontFeatures: const [FontFeature.tabularFigures()],
          ),
        ),
      ],
    );
  }
}
