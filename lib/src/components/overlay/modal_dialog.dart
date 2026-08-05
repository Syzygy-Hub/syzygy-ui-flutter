import 'package:flutter/material.dart';

import '../../theme/theme.dart';

/// A centered dialog card, wrapping [showDialog]/[Dialog]. Named
/// `ModalDialog` (not `Dialog`) to avoid ambiguity with Flutter Material's
/// own `Dialog`/`AlertDialog`.
class ModalDialog extends StatelessWidget {
  const ModalDialog({super.key, required this.child,
    this.theme,});

  final Widget child;

  static Future<T?> show<T>(BuildContext context, {required WidgetBuilder builder, SyzygyTheme? theme}) {
    final resolvedTheme = theme ?? SyzygyTheme.defaultTheme;
    return showDialog<T>(
      context: context,
      barrierColor: Colors.black.withValues(alpha: resolvedTheme.colors.overlayAlpha),
      builder: (context) => ModalDialog(child: builder(context)),
    );
  }

  final SyzygyTheme? theme;
  @override
  Widget build(BuildContext context) {
    final theme = this.theme ?? SyzygyThemeProvider.of(context);


    return Dialog(
      backgroundColor: theme.colors.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(theme.radius.lg)),
      child: Padding(
        padding: EdgeInsets.all(theme.spacing.lg),
        child: child,
      ),
    );
  }
}
