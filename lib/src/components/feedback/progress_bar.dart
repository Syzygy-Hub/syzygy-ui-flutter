import 'package:flutter/material.dart';

import '../../theme/theme.dart';

/// A determinate linear progress indicator, wrapping [LinearProgressIndicator].
class ProgressBar extends StatelessWidget {
  const ProgressBar({super.key, required this.progress,
    this.theme,});

  final double progress;

  final SyzygyTheme? theme;
  @override
  Widget build(BuildContext context) {
    final theme = this.theme ?? SyzygyThemeProvider.of(context);

    final clamped = progress.clamp(0.0, 1.0);

    return Semantics(
      label: 'Progress',
      value: '${(clamped * 100).round()} percent',
      child: ClipRRect(
        borderRadius: BorderRadius.circular(theme.radius.full),
        child: LinearProgressIndicator(
          value: clamped,
          backgroundColor: theme.colors.border,
          valueColor: AlwaysStoppedAnimation<Color>(theme.colors.primary),
          minHeight: 8,
        ),
      ),
    );
  }
}
