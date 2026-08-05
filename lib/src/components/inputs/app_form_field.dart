import 'package:flutter/material.dart';

import '../../theme/theme.dart';

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
  
    this.theme,});

  final String label;
  final Widget child;
  final String? error;
  final String? helperText;

  final SyzygyTheme? theme;
  @override
  Widget build(BuildContext context) {
    final theme = this.theme ?? SyzygyThemeProvider.of(context);

    final hasError = error != null && error!.isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(color: theme.colors.onSurface),
        ),
        SizedBox(height: theme.spacing.xs),
        child,
        if (hasError || (helperText != null && helperText!.isNotEmpty)) ...[
          SizedBox(height: theme.spacing.xxs),
          Text(
            hasError ? error! : helperText!,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: hasError ? theme.colors.error : theme.colors.textTertiary,
                ),
          ),
        ],
      ],
    );
  }
}
