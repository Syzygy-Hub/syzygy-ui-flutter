import 'package:flutter/material.dart';

import '../../tokens/colors.dart';
import '../../tokens/radius.dart';
import '../../tokens/spacing.dart';

enum _Strength { weak, fair, strong, veryStrong }

/// Computes a real (not hardcoded) password-strength heuristic from length
/// and character-class variety, then renders a 4-segment strength bar plus
/// a text label.
class PasswordStrengthIndicator extends StatelessWidget {
  const PasswordStrengthIndicator({super.key, required this.password});

  final String password;

  _Strength get _strength {
    if (password.isEmpty) return _Strength.weak;

    var classes = 0;
    if (password.contains(RegExp(r'[a-z]'))) classes++;
    if (password.contains(RegExp(r'[A-Z]'))) classes++;
    if (password.contains(RegExp(r'[0-9]'))) classes++;
    if (password.contains(RegExp(r'[^a-zA-Z0-9]'))) classes++;

    var score = 0;
    if (password.length >= 8) score++;
    if (password.length >= 12) score++;
    if (classes >= 2) score++;
    if (classes >= 3) score++;
    if (classes >= 4) score++;

    if (score <= 1) return _Strength.weak;
    if (score <= 2) return _Strength.fair;
    if (score <= 3) return _Strength.strong;
    return _Strength.veryStrong;
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final strength = _strength;
    final filledSegments = switch (strength) {
      _Strength.weak => 1,
      _Strength.fair => 2,
      _Strength.strong => 3,
      _Strength.veryStrong => 4,
    };
    final color = switch (strength) {
      _Strength.weak => colors.error,
      _Strength.fair => colors.warning,
      _Strength.strong => colors.success,
      _Strength.veryStrong => colors.primary,
    };
    final label = switch (strength) {
      _Strength.weak => 'Weak',
      _Strength.fair => 'Fair',
      _Strength.strong => 'Strong',
      _Strength.veryStrong => 'Very Strong',
    };

    return Semantics(
      label: 'Password strength: $label',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: List.generate(4, (index) {
              final filled = index < filledSegments;
              return Expanded(
                child: Container(
                  height: 4,
                  margin: EdgeInsets.only(right: index == 3 ? 0 : AppSpacing.xxs),
                  decoration: BoxDecoration(
                    color: filled ? color : colors.border,
                    borderRadius: BorderRadius.circular(AppRadius.xs),
                  ),
                ),
              );
            }),
          ),
          const SizedBox(height: AppSpacing.xxs),
          Text(label, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: color)),
        ],
      ),
    );
  }
}
