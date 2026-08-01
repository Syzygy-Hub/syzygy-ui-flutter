import 'package:flutter/material.dart';

import '../../tokens/colors.dart';
import '../../tokens/radius.dart';

/// A determinate linear progress indicator, wrapping [LinearProgressIndicator].
class ProgressBar extends StatelessWidget {
  const ProgressBar({super.key, required this.progress});

  final double progress;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final clamped = progress.clamp(0.0, 1.0);

    return Semantics(
      label: 'Progress',
      value: '${(clamped * 100).round()} percent',
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.full),
        child: LinearProgressIndicator(
          value: clamped,
          backgroundColor: colors.border,
          valueColor: AlwaysStoppedAnimation<Color>(colors.primary),
          minHeight: 8,
        ),
      ),
    );
  }
}
