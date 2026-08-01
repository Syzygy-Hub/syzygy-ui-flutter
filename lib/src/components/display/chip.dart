import 'package:flutter/material.dart' hide Chip;

import '../../tokens/colors.dart';
import '../../tokens/radius.dart';
import '../../tokens/spacing.dart';

/// A compact tag/chip with an optional trailing remove button. Hides
/// Flutter Material's own `Chip` so this library can keep the friendly
/// `Chip` name — the same convention already used by [Badge].
class Chip extends StatelessWidget {
  const Chip({super.key, required this.text, this.onRemove});

  final String text;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return Semantics(
      label: text,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: AppSpacing.xs),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(AppRadius.full),
          border: Border.all(color: colors.border),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(text, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: colors.onSurface)),
            if (onRemove != null) ...[
              const SizedBox(width: AppSpacing.xs),
              Semantics(
                button: true,
                label: 'Remove $text',
                child: InkWell(
                  onTap: onRemove,
                  child: Icon(Icons.close, size: 14, color: colors.secondary),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
