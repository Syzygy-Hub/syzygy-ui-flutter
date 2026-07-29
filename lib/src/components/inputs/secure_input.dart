import 'package:flutter/material.dart';

import '../../tokens/colors.dart';
import '../../tokens/radius.dart';
import '../../tokens/spacing.dart';

/// A password input field with a show/hide visibility toggle.
class SecureInput extends StatefulWidget {
  const SecureInput({
    super.key,
    required this.label,
    this.controller,
    this.hintText,
    this.errorText,
    this.enabled = true,
    this.onChanged,
    this.decoration,
  });

  final String label;
  final TextEditingController? controller;
  final String? hintText;
  final String? errorText;
  final bool enabled;
  final ValueChanged<String>? onChanged;
  final InputDecoration? decoration;

  @override
  State<SecureInput> createState() => _SecureInputState();
}

class _SecureInputState extends State<SecureInput> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final hasError = widget.errorText != null && widget.errorText!.isNotEmpty;

    return Semantics(
      textField: true,
      label: widget.label,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: colors.onSurface,
                ),
          ),
          const SizedBox(height: AppSpacing.xs),
          ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 48),
            child: TextFormField(
              controller: widget.controller,
              enabled: widget.enabled,
              obscureText: _obscure,
              onChanged: widget.onChanged,
              style: Theme.of(context).textTheme.bodyMedium,
              decoration: widget.decoration ??
                  InputDecoration(
                    hintText: widget.hintText,
                    errorText: widget.errorText,
                    filled: true,
                    fillColor: colors.surface,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: AppSpacing.sm,
                    ),
                    suffixIcon: Semantics(
                      button: true,
                      label: _obscure ? 'Show password' : 'Hide password',
                      child: SizedBox(
                        height: 48,
                        width: 48,
                        child: IconButton(
                          onPressed: () {
                            setState(() => _obscure = !_obscure);
                          },
                          icon: Icon(
                            _obscure
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                          ),
                        ),
                      ),
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
