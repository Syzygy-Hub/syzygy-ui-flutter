import 'package:flutter/material.dart';

import '../../theme/theme.dart';

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
  
    this.theme,});

  final IconData icon;
  final VoidCallback onPressed;
  final String? semanticLabel;

  final SyzygyTheme? theme;
  @override
  Widget build(BuildContext context) {
    final theme = this.theme ?? SyzygyThemeProvider.of(context);


    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: theme.colors.primary,
      foregroundColor: theme.colors.onPrimary,
      tooltip: semanticLabel,
      child: Icon(icon),
    );
  }
}
