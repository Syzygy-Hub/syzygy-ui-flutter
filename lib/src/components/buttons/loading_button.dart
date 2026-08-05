import 'package:flutter/material.dart';

import '../../theme/theme.dart';

/// A button with a built-in loading spinner that replaces the label while
/// [isLoading] is true, and is disabled for the duration.
class LoadingButton extends StatelessWidget {
  const LoadingButton({
    super.key,
    required this.label,
    required this.isLoading,
    required this.onPressed,
  
    this.theme,});

  final String label;
  final bool isLoading;
  final VoidCallback onPressed;

  final SyzygyTheme? theme;
  @override
  Widget build(BuildContext context) {
    final theme = this.theme ?? SyzygyThemeProvider.of(context);


    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: theme.colors.primary,
        foregroundColor: theme.colors.onPrimary,
      ),
      child: isLoading
          ? SizedBox(
              width: theme.spacing.md,
              height: theme.spacing.md,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(theme.colors.onPrimary),
              ),
            )
          : Text(label),
    );
  }
}
