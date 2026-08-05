import 'package:flutter/material.dart';

import '../../tokens/spacing.dart';
import '../../theme/theme.dart';

/// A wrapping row layout for chips/tags, using Flutter's native [Wrap]
/// widget directly (it already wraps to the next line when a row is full)
/// rather than reimplementing wrapping logic from scratch.
class FlowLayout extends StatelessWidget {
  const FlowLayout({super.key, this.spacing = AppSpacing.sm, required this.children,
    this.theme,});

  final double spacing;
  final List<Widget> children;

  final SyzygyTheme? theme;
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: spacing,
      runSpacing: spacing,
      children: children,
    );
  }
}
