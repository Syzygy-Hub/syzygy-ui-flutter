import 'package:flutter/material.dart';

import '../../tokens/colors.dart';

/// A themed wrapper around Flutter Material's own [CircularProgressIndicator],
/// which already natively supports both determinate mode (pass [progress]
/// between 0.0 and 1.0) and indeterminate mode (leave [progress] null).
class CircularProgress extends StatelessWidget {
  const CircularProgress({super.key, this.progress});

  final double? progress;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return CircularProgressIndicator(
      value: progress,
      valueColor: AlwaysStoppedAnimation<Color>(colors.primary),
      backgroundColor: colors.border,
    );
  }
}
