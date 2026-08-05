import 'package:flutter/material.dart';

import '../../theme/theme.dart';

/// An interactive star rating input — the tappable counterpart to the
/// read-only [StarRatingView]. Tapping a star reports its 1-based position
/// via [onRatingChange].
class RatingInput extends StatelessWidget {
  const RatingInput({
    super.key,
    required this.rating,
    required this.onRatingChange,
    this.maxRating = 5,
  
    this.theme,});

  final int rating;
  final ValueChanged<int> onRatingChange;
  final int maxRating;

  final SyzygyTheme? theme;
  @override
  Widget build(BuildContext context) {
    final theme = this.theme ?? SyzygyThemeProvider.of(context);


    return Semantics(
      label: 'Rate $rating out of $maxRating stars',
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(maxRating, (index) {
          final star = index + 1;
          final filled = star <= rating;
          return Semantics(
            button: true,
            label: '$star star${star == 1 ? '' : 's'}',
            child: InkWell(
              onTap: () => onRatingChange(star),
              child: SizedBox(
                width: 44,
                height: 44,
                child: Center(
                  child: Icon(
                    filled ? Icons.star : Icons.star_border,
                    color: filled ? theme.colors.warning : theme.colors.secondary,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
