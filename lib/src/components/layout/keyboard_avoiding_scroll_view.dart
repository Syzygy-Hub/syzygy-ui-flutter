import 'package:flutter/material.dart';
import '../../theme/theme.dart';

/// A scrollable container that automatically insets its content to avoid
/// the on-screen keyboard. Flutter's [Scaffold] already resizes for the
/// keyboard by default; this wraps [SingleChildScrollView] so content
/// scrolls into view instead of just being clipped when space runs out.
class KeyboardAvoidingScrollView extends StatelessWidget {
  const KeyboardAvoidingScrollView({super.key, required this.child,
    this.theme,});

  final Widget child;

  final SyzygyTheme? theme;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: MediaQuery.of(context).viewInsets,
      child: child,
    );
  }
}
