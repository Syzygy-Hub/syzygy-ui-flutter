import 'package:flutter/material.dart' hide ColorSwatch;

import '../../tokens/colors.dart';
import '../../tokens/spacing.dart';

/// Shape variant for [ColorSwatchView].
enum ColorSwatchShape { circle, square }

/// A circle or square swatch displaying a single [Color], with an optional
/// label beneath and a selected-state border.
///
/// Named `ColorSwatchView` (not `ColorSwatch`) because Flutter's own
/// `package:flutter/material.dart` already exports a framework class named
/// `ColorSwatch<T>` (the `Map<T, Color>`-based type backing `MaterialColor`)
/// — this file imports material with `hide ColorSwatch` to avoid the clash,
/// the same convention already used elsewhere in this library (e.g.
/// `Chip`, `Badge`) for real name collisions rather than a mere style
/// preference.
class ColorSwatchView extends StatelessWidget {
  const ColorSwatchView({
    super.key,
    required this.color,
    this.shape = ColorSwatchShape.circle,
    this.label,
    this.isSelected = false,
    this.size = 32,
  });

  final Color color;
  final ColorSwatchShape shape;
  final String? label;
  final bool isSelected;
  final double size;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    final swatch = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: shape == ColorSwatchShape.circle ? BoxShape.circle : BoxShape.rectangle,
        borderRadius: shape == ColorSwatchShape.square ? BorderRadius.circular(4) : null,
        border: isSelected ? Border.all(color: colors.focus, width: 2) : null,
      ),
    );

    return Semantics(
      label: label ?? 'Color swatch',
      selected: isSelected,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          swatch,
          if (label != null) ...[
            const SizedBox(height: AppSpacing.xxs),
            Text(label!, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: colors.textTertiary)),
          ],
        ],
      ),
    );
  }
}
