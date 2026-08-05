import 'package:flutter/material.dart' hide Tooltip;
import 'package:flutter/material.dart' as material show Tooltip;

import '../../theme/theme.dart';

/// A themed wrapper around Flutter Material's own `Tooltip`, which already
/// natively handles hover (desktop/web) and long-press (mobile) display —
/// no need to reimplement that. Named `AppTooltip` (not `Tooltip`) to avoid
/// colliding with Material's own `Tooltip`, the same naming-collision-
/// avoidance convention already used by `AppIconButton`/`AppBackButton`.
class AppTooltip extends StatelessWidget {
  const AppTooltip({super.key, required this.message, required this.child,
    this.theme,});

  final String message;
  final Widget child;

  final SyzygyTheme? theme;
  @override
  Widget build(BuildContext context) {
    final theme = this.theme ?? SyzygyThemeProvider.of(context);


    return material.Tooltip(
      message: message,
      decoration: BoxDecoration(
        color: theme.colors.onSurface,
        borderRadius: BorderRadius.circular(theme.radius.sm),
      ),
      textStyle: Theme.of(context).textTheme.bodySmall?.copyWith(color: theme.colors.surface),
      child: child,
    );
  }
}
