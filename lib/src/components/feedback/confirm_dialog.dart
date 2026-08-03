import 'package:flutter/material.dart';

import '../../tokens/colors.dart';
import '../../tokens/spacing.dart';
import '../overlay/modal_dialog.dart';

/// A preset modal variant of [ModalDialog]: title, message, confirm button,
/// cancel button — the common "are you sure?" pattern, built on top of
/// this library's existing dialog presentation rather than reimplementing
/// `showDialog` plumbing from scratch.
class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog({
    super.key,
    required this.title,
    required this.message,
    this.confirmLabel = 'Confirm',
    this.cancelLabel = 'Cancel',
    this.isDestructive = false,
  });

  final String title;
  final String message;
  final String confirmLabel;
  final String cancelLabel;
  final bool isDestructive;

  /// Shows a [ConfirmDialog] via [ModalDialog.show] and resolves to `true`
  /// if the user confirmed, `false` if cancelled/dismissed.
  static Future<bool> show(
    BuildContext context, {
    required String title,
    required String message,
    String confirmLabel = 'Confirm',
    String cancelLabel = 'Cancel',
    bool isDestructive = false,
  }) async {
    final result = await ModalDialog.show<bool>(
      context,
      builder: (_) => ConfirmDialog(
        title: title,
        message: message,
        confirmLabel: confirmLabel,
        cancelLabel: cancelLabel,
        isDestructive: isDestructive,
      ),
    );
    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleLarge?.copyWith(color: colors.onSurface)),
        const SizedBox(height: AppSpacing.sm),
        Text(message, style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: colors.textTertiary)),
        const SizedBox(height: AppSpacing.lg),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(cancelLabel),
            ),
            const SizedBox(width: AppSpacing.sm),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: TextButton.styleFrom(
                foregroundColor: isDestructive ? colors.error : colors.primary,
              ),
              child: Text(confirmLabel),
            ),
          ],
        ),
      ],
    );
  }
}
