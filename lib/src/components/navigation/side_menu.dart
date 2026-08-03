import 'package:flutter/material.dart' hide Drawer;
import 'package:flutter/material.dart' as material show Drawer;

import '../../tokens/colors.dart';

/// A themed slide-in side menu panel, also known as `Drawer` in other parts
/// of the Syzygy ecosystem.
///
/// This wraps Flutter Material's own `Drawer` (used via
/// `Scaffold(drawer: ...)`) rather than building a fully custom standalone
/// overlay. Flutter's `Scaffold` already handles the slide-in animation,
/// scrim, edge-swipe-to-open gesture, and `Navigator`/`Scaffold` integration
/// for free — reimplementing all of that from scratch would only add risk
/// (duplicated gesture-conflict bugs, missed accessibility behavior Material
/// already gets right) for no real design benefit, since this library's
/// customization needs here are purely cosmetic (colors/typography).
class SideMenu extends StatelessWidget {
  const SideMenu({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return material.Drawer(
      backgroundColor: colors.surface,
      child: child,
    );
  }
}
