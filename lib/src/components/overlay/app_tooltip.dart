import 'package:flutter/material.dart' hide Tooltip;
import 'package:flutter/material.dart' as material show Tooltip;

import '../../tokens/colors.dart';
import '../../tokens/radius.dart';

/// A themed wrapper around Flutter Material's own `Tooltip`, which already
/// natively handles hover (desktop/web) and long-press (mobile) display —
/// no need to reimplement that. Named `AppTooltip` (not `Tooltip`) to avoid
/// colliding with Material's own `Tooltip`, the same naming-collision-
/// avoidance convention already used by `AppIconButton`/`AppBackButton`.
class AppTooltip extends StatelessWidget {
  const AppTooltip({super.key, required this.message, required this.child});

  final String message;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return material.Tooltip(
      message: message,
      decoration: BoxDecoration(
        color: colors.onSurface,
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
      textStyle: Theme.of(context).textTheme.bodySmall?.copyWith(color: colors.surface),
      child: child,
    );
  }
}
