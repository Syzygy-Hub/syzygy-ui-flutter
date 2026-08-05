import 'package:flutter/material.dart';

import '../../theme/theme.dart';

/// A tappable icon-only button with a minimum 48dp touch target.
class AppIconButton extends StatelessWidget {
  const AppIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.semanticLabel,
    this.color,
    this.style,
  
    this.theme,});

  final IconData icon;
  final VoidCallback? onPressed;

  /// Required so screen readers can describe an icon-only control.
  final String semanticLabel;
  final Color? color;
  final ButtonStyle? style;

  final SyzygyTheme? theme;
  @override
  Widget build(BuildContext context) {
    final theme = this.theme ?? SyzygyThemeProvider.of(context);

    final disabled = onPressed == null;

    return Semantics(
      button: true,
      enabled: !disabled,
      label: semanticLabel,
      child: SizedBox(
        height: 48,
        width: 48,
        child: IconButton(
          onPressed: onPressed,
          tooltip: semanticLabel,
          icon: Icon(icon),
          color: color ?? (disabled ? theme.colors.onDisabled : theme.colors.onSurface),
          style: style ??
              IconButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(theme.radius.full),
                ),
              ),
        ),
      ),
    );
  }
}
