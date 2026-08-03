import 'package:flutter/material.dart';

import '../../tokens/colors.dart';

/// A themed floating action button. Named `AppFloatingActionButton` (not
/// `FloatingActionButton`) to avoid colliding with Flutter Material's own
/// `FloatingActionButton` — the same naming-collision-avoidance convention
/// already used by `AppIconButton`/`AppBackButton`/`SyzygyAppBar`.
class AppFloatingActionButton extends StatelessWidget {
  const AppFloatingActionButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.semanticLabel,
  });

  final IconData icon;
  final VoidCallback onPressed;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: colors.primary,
      foregroundColor: colors.onPrimary,
      tooltip: semanticLabel,
      child: Icon(icon),
    );
  }
}
