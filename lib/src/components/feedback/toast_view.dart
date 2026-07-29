import 'package:flutter/material.dart';

import '../../tokens/colors.dart';
import '../../tokens/radius.dart';
import '../../tokens/spacing.dart';

/// Semantic variants for [ToastView].
enum ToastVariant { success, warning, error }

/// A success/warning/error toast, shown as a [SnackBar] via [ToastView.show].
class ToastView extends StatelessWidget {
  const ToastView({
    super.key,
    required this.message,
    required this.variant,
    this.decoration,
  });

  final String message;
  final ToastVariant variant;
  final BoxDecoration? decoration;

  static void show(
    BuildContext context, {
    required String message,
    ToastVariant variant = ToastVariant.success,
    Duration duration = const Duration(seconds: 3),
  }) {
    final colors = AppColors.of(context);
    final backgroundColor = _backgroundFor(variant, colors);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: ToastView(message: message, variant: variant),
        backgroundColor: backgroundColor,
        duration: duration,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
      ),
    );
  }

  static Color _backgroundFor(ToastVariant variant, AppColors colors) {
    switch (variant) {
      case ToastVariant.success:
        return colors.success;
      case ToastVariant.warning:
        return colors.warning;
      case ToastVariant.error:
        return colors.error;
    }
  }

  IconData get _icon {
    switch (variant) {
      case ToastVariant.success:
        return Icons.check_circle_outline;
      case ToastVariant.warning:
        return Icons.warning_amber_outlined;
      case ToastVariant.error:
        return Icons.error_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final foreground = switch (variant) {
      ToastVariant.success => colors.onSuccess,
      ToastVariant.warning => colors.onWarning,
      ToastVariant.error => colors.onError,
    };

    return Semantics(
      liveRegion: true,
      label: message,
      child: Container(
        decoration: decoration,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(_icon, color: foreground, size: 20),
            const SizedBox(width: AppSpacing.sm),
            Flexible(
              child: Text(
                message,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(color: foreground),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
