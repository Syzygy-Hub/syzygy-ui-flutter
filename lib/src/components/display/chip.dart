import 'package:flutter/material.dart' hide Chip;

import '../../theme/theme.dart';

/// A compact tag/chip with an optional trailing remove button. Hides
/// Flutter Material's own `Chip` so this library can keep the friendly
/// `Chip` name — the same convention already used by [Badge].
class Chip extends StatelessWidget {
  const Chip({super.key, required this.text, this.onRemove,
    this.theme,});

  final String text;
  final VoidCallback? onRemove;

  final SyzygyTheme? theme;
  @override
  Widget build(BuildContext context) {
    final theme = this.theme ?? SyzygyThemeProvider.of(context);


    return Semantics(
      label: text,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: theme.spacing.sm, vertical: theme.spacing.xs),
        decoration: BoxDecoration(
          color: theme.colors.surface,
          borderRadius: BorderRadius.circular(theme.radius.full),
          border: Border.all(color: theme.colors.border),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(text, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: theme.colors.onSurface)),
            if (onRemove != null) ...[
              SizedBox(width: theme.spacing.xs),
              Semantics(
                button: true,
                label: 'Remove $text',
                child: InkWell(
                  onTap: onRemove,
                  child: Icon(Icons.close, size: 14, color: theme.colors.secondary),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
