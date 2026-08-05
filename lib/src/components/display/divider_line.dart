import 'package:flutter/material.dart';

import '../../theme/theme.dart';

/// A hairline horizontal rule. Named `DividerLine` (not `Divider`) to avoid
/// colliding with Flutter Material's own [Divider].
class DividerLine extends StatelessWidget {
  const DividerLine({super.key,
    this.theme,});

  final SyzygyTheme? theme;
  @override
  Widget build(BuildContext context) {
    final theme = this.theme ?? SyzygyThemeProvider.of(context);

    return ExcludeSemantics(
      child: Divider(height: 1, thickness: 1, color: theme.colors.border),
    );
  }
}
