import 'package:flutter/material.dart';

/// A themed, opinionated wrapper around Flutter's own [SafeArea].
///
/// Unlike some of this release's other platform-constrained components,
/// this one has no hard problem to solve: Flutter's core SDK already ships
/// a native, first-party `SafeArea` widget that correctly respects
/// `MediaQuery.of(context).padding` for notches/status bars/home
/// indicators on both iOS and Android. `SafeAreaWrapper` exists purely to
/// give this library's consumers a consistent, `syzygy_ui_flutter`-named
/// API surface (matching `SafeArea`'s own `top`/`bottom`/`left`/`right`
/// constructor shape) rather than reaching into `package:flutter/material`
/// directly — it delegates entirely to `SafeArea` underneath.
class SafeAreaWrapper extends StatelessWidget {
  const SafeAreaWrapper({
    super.key,
    required this.child,
    this.top = true,
    this.bottom = true,
    this.left = true,
    this.right = true,
  });

  final Widget child;
  final bool top;
  final bool bottom;
  final bool left;
  final bool right;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: child,
    );
  }
}
