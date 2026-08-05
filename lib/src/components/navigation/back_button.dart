import 'package:flutter/material.dart';

import '../../theme/theme.dart';

/// A consistent back-navigation button, defaulting to [Navigator.pop].
class AppBackButton extends StatelessWidget {
  const AppBackButton({
    super.key,
    this.onPressed,
    this.style,
    this.semanticLabel = 'Back',
  
    this.theme,});

  final VoidCallback? onPressed;
  final ButtonStyle? style;
  final String semanticLabel;

  final SyzygyTheme? theme;
  @override
  Widget build(BuildContext context) {
    final theme = this.theme ?? SyzygyThemeProvider.of(context);


    return Semantics(
      button: true,
      label: semanticLabel,
      child: SizedBox(
        height: 48,
        width: 48,
        child: IconButton(
          onPressed: onPressed ?? () => Navigator.of(context).maybePop(),
          tooltip: semanticLabel,
          icon: const Icon(Icons.arrow_back),
          color: theme.colors.onSurface,
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
