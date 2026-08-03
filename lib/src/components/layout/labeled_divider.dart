import 'package:flutter/material.dart';

import '../../tokens/colors.dart';
import '../../tokens/spacing.dart';
import '../display/divider_line.dart';

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
  });

  final String label;
  final LabeledDividerAlignment alignment;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    final (leadingFlex, trailingFlex) = switch (alignment) {
      LabeledDividerAlignment.leading => (1, 4),
      LabeledDividerAlignment.center => (1, 1),
      LabeledDividerAlignment.trailing => (4, 1),
    };

    return Row(
      children: [
        Expanded(flex: leadingFlex, child: const DividerLine()),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
          child: Text(label, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: colors.textTertiary)),
        ),
        Expanded(flex: trailingFlex, child: const DividerLine()),
      ],
    );
  }
}
