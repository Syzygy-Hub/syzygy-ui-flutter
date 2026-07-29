import 'package:flutter/material.dart';

import '../../tokens/colors.dart';
import '../../tokens/radius.dart';
import '../../tokens/spacing.dart';

/// A labeled text field with optional error state and character counter.
class TextInput extends StatelessWidget {
  const TextInput({
    super.key,
    required this.label,
    this.controller,
    this.hintText,
    this.errorText,
    this.maxLength,
    this.keyboardType,
    this.obscureText = false,
    this.enabled = true,
    this.onChanged,
    this.decoration,
  });

  final String label;
  final TextEditingController? controller;
  final String? hintText;
  final String? errorText;
  final int? maxLength;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool enabled;
  final ValueChanged<String>? onChanged;
  final InputDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final hasError = errorText != null && errorText!.isNotEmpty;

    return Semantics(
      textField: true,
      label: label,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: colors.onSurface,
                ),
          ),
          const SizedBox(height: AppSpacing.xs),
          ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 48),
            child: TextFormField(
              controller: controller,
              enabled: enabled,
              obscureText: obscureText,
              keyboardType: keyboardType,
              maxLength: maxLength,
              onChanged: onChanged,
              style: Theme.of(context).textTheme.bodyMedium,
              buildCounter: maxLength == null
                  ? null
                  : (
                      context, {
                      required currentLength,
                      required isFocused,
                      required maxLength,
                    }) {
                      return Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          '$currentLength/$maxLength',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: colors.secondary,
                              ),
                        ),
                      );
                    },
              decoration: decoration ??
                  InputDecoration(
                    hintText: hintText,
                    errorText: errorText,
                    filled: true,
                    fillColor: colors.surface,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: AppSpacing.sm,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppRadius.md),
                      borderSide: BorderSide(color: colors.border),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppRadius.md),
                      borderSide: BorderSide(
                        color: hasError ? colors.error : colors.border,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppRadius.md),
                      borderSide: BorderSide(
                        color: hasError ? colors.error : colors.primary,
                        width: 2,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(AppRadius.md),
                      borderSide: BorderSide(color: colors.error),
                    ),
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
