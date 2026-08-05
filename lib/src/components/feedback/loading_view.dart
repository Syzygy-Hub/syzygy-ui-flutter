import 'package:flutter/material.dart';

import '../../theme/theme.dart';

/// A centered loading indicator with an optional status message.
class LoadingView extends StatelessWidget {
  const LoadingView({
    super.key,
    this.message,
    this.decoration,
  
    this.theme,});

  final String? message;
  final BoxDecoration? decoration;

  final SyzygyTheme? theme;
  @override
  Widget build(BuildContext context) {
    final theme = this.theme ?? SyzygyThemeProvider.of(context);


    return Semantics(
      label: message ?? 'Loading',
      child: Container(
        decoration: decoration,
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(theme.colors.primary),
            ),
            if (message != null) ...[
              SizedBox(height: theme.spacing.md),
              Text(
                message!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: theme.colors.onSurface,
                    ),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
