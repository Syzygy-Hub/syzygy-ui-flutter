import 'package:flutter/material.dart';

import '../../tokens/spacing.dart';
import '../../theme/theme.dart';

/// A generic container card using token-driven surface color and radius.
class CardView extends StatelessWidget {
  const CardView({
    super.key,
    required this.child,
    this.onTap,
    this.padding = const EdgeInsets.all(AppSpacing.md),
    this.decoration,
    this.semanticLabel,
  
    this.theme,});

  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;
  final BoxDecoration? decoration;
  final String? semanticLabel;

  final SyzygyTheme? theme;
  @override
  Widget build(BuildContext context) {
    final theme = this.theme ?? SyzygyThemeProvider.of(context);


    final content = Container(
      padding: padding,
      decoration: decoration ??
          BoxDecoration(
            color: theme.colors.surface,
            borderRadius: BorderRadius.circular(theme.radius.lg),
            border: Border.all(color: theme.colors.border),
          ),
      child: child,
    );

    if (onTap == null) {
      return Semantics(
        label: semanticLabel,
        container: true,
        child: content,
      );
    }

    return Semantics(
      button: true,
      label: semanticLabel,
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(theme.radius.lg),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(theme.radius.lg),
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 48),
            child: content,
          ),
        ),
      ),
    );
  }
}
