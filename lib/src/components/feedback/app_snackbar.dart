import 'package:flutter/material.dart' hide SnackBar;
import 'package:flutter/material.dart' as material show SnackBar;

import '../../tokens/colors.dart';
import '../../tokens/radius.dart';

/// A themed, opinionated `SnackBar`-building factory.
///
/// Flutter Material already ships a full `SnackBar` widget plus a
/// `ScaffoldMessenger.showSnackBar()` overlay/queueing system — rather than
/// reinventing that, `AppSnackbar.build(...)` returns a configured
/// `material.SnackBar` that a consumer passes straight to
/// `ScaffoldMessenger.of(context).showSnackBar(...)`. This is the idiomatic
/// Flutter way to customize snackbar appearance without fighting the
/// framework's existing overlay system.
class AppSnackbar {
  AppSnackbar._();

  static material.SnackBar build(
    BuildContext context, {
    required String message,
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    final colors = AppColors.of(context);

    return material.SnackBar(
      content: Text(message, style: TextStyle(color: colors.onSurface)),
      backgroundColor: colors.surfaceSecondary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.md)),
      behavior: SnackBarBehavior.floating,
      action: (actionLabel != null && onAction != null)
          ? SnackBarAction(label: actionLabel, textColor: colors.primary, onPressed: onAction)
          : null,
    );
  }
}
