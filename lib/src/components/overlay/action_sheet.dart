import 'package:flutter/material.dart' hide BottomSheet;

import 'bottom_sheet.dart';
import '../../theme/theme.dart';

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
  const ActionSheet({super.key, required this.actions,
    this.theme,});

  final List<ActionSheetItem> actions;

  static Future<void> show(BuildContext context, {required List<ActionSheetItem> actions}) {
    return BottomSheet.show<void>(
      context,
      builder: (_) => ActionSheet(actions: actions),
    );
  }

  final SyzygyTheme? theme;
  @override
  Widget build(BuildContext context) {
    final theme = this.theme ?? SyzygyThemeProvider.of(context);


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
                padding: EdgeInsets.symmetric(vertical: theme.spacing.sm),
                child: Text(
                  action.label,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: action.isDestructive ? theme.colors.error : theme.colors.onSurface,
                      ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
