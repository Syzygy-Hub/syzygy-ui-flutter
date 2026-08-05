import 'package:flutter/material.dart' hide BottomSheet;

import '../../tokens/radius.dart';
import '../../theme/theme.dart';

/// A bottom-anchored sheet with a grab handle, wrapping
/// [showModalBottomSheet]. Hides Flutter Material's own `BottomSheet` so
/// this library can keep the friendly `BottomSheet` name — the same
/// convention already used by [Badge].
class BottomSheet extends StatelessWidget {
  const BottomSheet({super.key, required this.child,
    this.theme,});

  final Widget child;

  static Future<T?> show<T>(BuildContext context, {required WidgetBuilder builder}) {
    final colors = SyzygyThemeProvider.of(context).colors;
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

  final SyzygyTheme? theme;
  @override
  Widget build(BuildContext context) {
    final theme = this.theme ?? SyzygyThemeProvider.of(context);


    return Padding(
      padding: EdgeInsets.all(theme.spacing.lg),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 36,
            height: 4,
            margin: EdgeInsets.only(bottom: theme.spacing.md),
            decoration: BoxDecoration(
              color: theme.colors.border,
              borderRadius: BorderRadius.circular(theme.radius.full),
            ),
          ),
          child,
        ],
      ),
    );
  }
}
