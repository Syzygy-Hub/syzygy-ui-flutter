import 'package:flutter/material.dart';

import '../../theme/theme.dart';

/// A star rating display. Pass [onRatingChanged] to make it interactively
/// tappable; omit it for a read-only display.
class StarRatingView extends StatelessWidget {
  const StarRatingView({
    super.key,
    required this.rating,
    this.maxRating = 5,
    this.onRatingChanged,
  
    this.theme,});

  final int rating;
  final int maxRating;
  final ValueChanged<int>? onRatingChanged;

  final SyzygyTheme? theme;
  @override
  Widget build(BuildContext context) {
    final theme = this.theme ?? SyzygyThemeProvider.of(context);


    return Semantics(
      label: 'Rating: $rating out of $maxRating stars',
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(maxRating, (index) {
          final star = index + 1;
          final filled = star <= rating;
          final icon = Icon(
            filled ? Icons.star : Icons.star_border,
            color: filled ? theme.colors.warning : theme.colors.secondary,
          );

          if (onRatingChanged == null) return icon;

          return Semantics(
            button: true,
            label: '$star star${star == 1 ? '' : 's'}',
            child: InkWell(
              onTap: () => onRatingChanged!(star),
              child: SizedBox(width: 44, height: 44, child: Center(child: icon)),
            ),
          );
        }),
      ),
    );
  }
}
