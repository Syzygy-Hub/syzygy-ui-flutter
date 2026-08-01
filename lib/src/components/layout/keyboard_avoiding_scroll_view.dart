import 'package:flutter/material.dart';

/// A scrollable container that automatically insets its content to avoid
/// the on-screen keyboard. Flutter's [Scaffold] already resizes for the
/// keyboard by default; this wraps [SingleChildScrollView] so content
/// scrolls into view instead of just being clipped when space runs out.
class KeyboardAvoidingScrollView extends StatelessWidget {
  const KeyboardAvoidingScrollView({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: MediaQuery.of(context).viewInsets,
      child: child,
    );
  }
}
