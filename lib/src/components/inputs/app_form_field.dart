import 'package:flutter/material.dart';

import '../../tokens/colors.dart';
import '../../tokens/spacing.dart';

/// A generic composable wrapper: a [label] above an arbitrary [child]
/// input slot, with an optional [error] message (shown in Material's error
/// color) or [helperText] (shown in a secondary color when there's no
/// error). Named `AppFormField` (not `FormField`) to avoid colliding with
/// Flutter's own `FormField<T>` — the abstract base class used internally
/// by `TextFormField` etc. — the same naming-collision-avoidance convention
/// already used by `AppIconButton`/`AppBackButton`/`SyzygyAppBar`.
class AppFormField extends StatelessWidget {
  const AppFormField({
    super.key,
    required this.label,
    required this.child,
    this.error,
    this.helperText,
  });

  final String label;
  final Widget child;
  final String? error;
  final String? helperText;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final hasError = error != null && error!.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(color: colors.onSurface),
        ),
        const SizedBox(height: AppSpacing.xs),
        child,
        if (hasError || (helperText != null && helperText!.isNotEmpty)) ...[
          const SizedBox(height: AppSpacing.xxs),
          Text(
            hasError ? error! : helperText!,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: hasError ? colors.error : colors.textTertiary,
                ),
          ),
        ],
      ],
    );
  }
}
