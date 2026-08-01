import 'package:flutter/material.dart' hide BottomSheet;

import '../../tokens/colors.dart';
import '../../tokens/radius.dart';
import '../../tokens/spacing.dart';

/// A bottom-anchored sheet with a grab handle, wrapping
/// [showModalBottomSheet]. Hides Flutter Material's own `BottomSheet` so
/// this library can keep the friendly `BottomSheet` name — the same
/// convention already used by [Badge].
class BottomSheet extends StatelessWidget {
  const BottomSheet({super.key, required this.child});

  final Widget child;

  static Future<T?> show<T>(BuildContext context, {required WidgetBuilder builder}) {
    final colors = AppColors.of(context);
    return showModalBottomSheet<T>(
      context: context,
      backgroundColor: colors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(AppRadius.lg),
          topRight: Radius.circular(AppRadius.lg),
        ),
      ),
      builder: (context) => BottomSheet(child: builder(context)),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 36,
            height: 4,
            margin: const EdgeInsets.only(bottom: AppSpacing.md),
            decoration: BoxDecoration(
              color: colors.border,
              borderRadius: BorderRadius.circular(AppRadius.full),
            ),
          ),
          child,
        ],
      ),
    );
  }
}
