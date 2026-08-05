import 'package:flutter/material.dart';

import '../../theme/theme.dart';

/// A labeled multi-line text field, matching [TextInput]'s visual style but
/// backed by Flutter's own `minLines`/`maxLines` `TextField` params.
class TextArea extends StatelessWidget {
  const TextArea({
    super.key,
    required this.label,
    this.controller,
    this.hintText,
    this.errorText,
    this.minLines = 3,
    this.maxLines = 6,
    this.enabled = true,
    this.onChanged,
  
    this.theme,});

  final String label;
  final TextEditingController? controller;
  final String? hintText;
  final String? errorText;
  final int minLines;
  final int maxLines;
  final bool enabled;
  final ValueChanged<String>? onChanged;

  final SyzygyTheme? theme;
  @override
  Widget build(BuildContext context) {
    final theme = this.theme ?? SyzygyThemeProvider.of(context);

    final hasError = errorText != null && errorText!.isNotEmpty;

    return Semantics(
      textField: true,
      label: label,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context)
                .textTheme
                .labelLarge
                ?.copyWith(color: theme.colors.onSurface),
          ),
          SizedBox(height: theme.spacing.xs),
          TextFormField(
            controller: controller,
            enabled: enabled,
            minLines: minLines,
            maxLines: maxLines,
            onChanged: onChanged,
            style: Theme.of(context).textTheme.bodyMedium,
            decoration: InputDecoration(
              hintText: hintText,
              errorText: errorText,
              filled: true,
              fillColor: theme.colors.surface,
              contentPadding: EdgeInsets.symmetric(
                horizontal: theme.spacing.md,
                vertical: theme.spacing.sm,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(theme.radius.md),
                borderSide: BorderSide(color: theme.colors.border),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(theme.radius.md),
                borderSide: BorderSide(color: hasError ? theme.colors.error : theme.colors.border),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(theme.radius.md),
                borderSide: BorderSide(color: hasError ? theme.colors.error : theme.colors.primary, width: 2),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(theme.radius.md),
                borderSide: BorderSide(color: theme.colors.error),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
