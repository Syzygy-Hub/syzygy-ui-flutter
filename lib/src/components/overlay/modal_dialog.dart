import 'package:flutter/material.dart';

import '../../tokens/colors.dart';
import '../../tokens/radius.dart';
import '../../tokens/spacing.dart';

/// A centered dialog card, wrapping [showDialog]/[Dialog]. Named
/// `ModalDialog` (not `Dialog`) to avoid ambiguity with Flutter Material's
/// own `Dialog`/`AlertDialog`.
class ModalDialog extends StatelessWidget {
  const ModalDialog({super.key, required this.child});

  final Widget child;

  static Future<T?> show<T>(BuildContext context, {required WidgetBuilder builder}) {
    return showDialog<T>(
      context: context,
      builder: (context) => ModalDialog(child: builder(context)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return Dialog(
      backgroundColor: colors.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppRadius.lg)),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: child,
      ),
    );
  }
}
