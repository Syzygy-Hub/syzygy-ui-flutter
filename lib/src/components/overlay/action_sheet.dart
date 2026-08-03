import 'package:flutter/material.dart' hide BottomSheet;

import '../../tokens/colors.dart';
import '../../tokens/spacing.dart';
import 'bottom_sheet.dart';

/// A single action listed in an [ActionSheet].
class ActionSheetItem {
  const ActionSheetItem({required this.label, this.isDestructive = false, required this.onTap});

  final String label;
  final bool isDestructive;
  final VoidCallback onTap;
}

/// A bottom-anchored sheet listing labelled actions, following the same
/// `showModalBottomSheet`-wrapping, static `.show(context, ...)` convenience
/// convention already used by [BottomSheet].
class ActionSheet extends StatelessWidget {
  const ActionSheet({super.key, required this.actions});

  final List<ActionSheetItem> actions;

  static Future<void> show(BuildContext context, {required List<ActionSheetItem> actions}) {
    return BottomSheet.show<void>(
      context,
      builder: (_) => ActionSheet(actions: actions),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final action in actions)
          Semantics(
            button: true,
            label: action.label,
            child: InkWell(
              onTap: () {
                Navigator.of(context).pop();
                action.onTap();
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                child: Text(
                  action.label,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: action.isDestructive ? colors.error : colors.onSurface,
                      ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
