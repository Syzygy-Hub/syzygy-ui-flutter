import 'package:flutter/material.dart';

import '../../tokens/colors.dart';

/// A hairline horizontal rule. Named `DividerLine` (not `Divider`) to avoid
/// colliding with Flutter Material's own [Divider].
class DividerLine extends StatelessWidget {
  const DividerLine({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return ExcludeSemantics(
      child: Divider(height: 1, thickness: 1, color: colors.border),
    );
  }
}
