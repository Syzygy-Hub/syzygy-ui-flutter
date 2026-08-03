import 'package:flutter/material.dart';

/// A layout that arranges [children] horizontally (in a [Row]) above
/// [breakpoint] available width, and vertically (in a [Column]) below it.
/// Uses [LayoutBuilder], Flutter's own mechanism for reading available
/// constraints, to decide which to render.
class AdaptiveStack extends StatelessWidget {
  const AdaptiveStack({super.key, required this.breakpoint, required this.children});

  final double breakpoint;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= breakpoint) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          );
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        );
      },
    );
  }
}
