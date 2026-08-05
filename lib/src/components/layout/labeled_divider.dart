import 'package:flutter/material.dart';

import '../display/divider_line.dart';
import '../../theme/theme.dart';

/// Where the label sits along a [LabeledDivider].
enum LabeledDividerAlignment { leading, center, trailing }

/// A horizontal divider with a centered (or leading/trailing) text label
/// breaking the line, e.g. "or" between two sign-in options.
///
/// Reuses this library's existing [DividerLine] for the line segments
/// flanking the label rather than reaching for Material's own `Divider`
/// directly, keeping the hairline styling consistent with the rest of the
/// library.
class LabeledDivider extends StatelessWidget {
  const LabeledDivider({
    super.key,
    required this.label,
    this.alignment = LabeledDividerAlignment.center,
  
    this.theme,});

  final String label;
  final LabeledDividerAlignment alignment;

  final SyzygyTheme? theme;
  @override
  Widget build(BuildContext context) {
    final theme = this.theme ?? SyzygyThemeProvider.of(context);


    final (leadingFlex, trailingFlex) = switch (alignment) {
      LabeledDividerAlignment.leading => (1, 4),
      LabeledDividerAlignment.center => (1, 1),
      LabeledDividerAlignment.trailing => (4, 1),
    };

    return Row(
      children: [
        Expanded(flex: leadingFlex, child: const DividerLine()),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: theme.spacing.sm),
          child: Text(label, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: theme.colors.textTertiary)),
        ),
        Expanded(flex: trailingFlex, child: const DividerLine()),
      ],
    );
  }
}
