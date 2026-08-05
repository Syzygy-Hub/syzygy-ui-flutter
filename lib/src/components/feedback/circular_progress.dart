import 'package:flutter/material.dart';

import '../../theme/theme.dart';

/// A themed wrapper around Flutter Material's own [CircularProgressIndicator],
/// which already natively supports both determinate mode (pass [progress]
/// between 0.0 and 1.0) and indeterminate mode (leave [progress] null).
class CircularProgress extends StatelessWidget {
  const CircularProgress({super.key, this.progress,
    this.theme,});

  final double? progress;

  final SyzygyTheme? theme;
  @override
  Widget build(BuildContext context) {
    final theme = this.theme ?? SyzygyThemeProvider.of(context);


    return CircularProgressIndicator(
      value: progress,
      valueColor: AlwaysStoppedAnimation<Color>(theme.colors.primary),
      backgroundColor: theme.colors.border,
    );
  }
}
