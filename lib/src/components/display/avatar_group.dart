import 'package:flutter/material.dart';

import 'avatar.dart';
import '../../theme/theme.dart';

/// An overlapping stack of up to [max] [Avatar]s, with a "+N" overflow
/// circle if [avatars] has more entries than [max].
class AvatarGroup extends StatelessWidget {
  const AvatarGroup({
    super.key,
    required this.avatars,
    this.max = 4,
    this.size = AvatarSize.medium,
  
    this.theme,});

  final List<String> avatars;
  final int max;
  final AvatarSize size;

  double get _dimension => switch (size) {
        AvatarSize.small => 32,
        AvatarSize.medium => 44,
        AvatarSize.large => 64,
      };

  final SyzygyTheme? theme;
  @override
  Widget build(BuildContext context) {
    final theme = this.theme ?? SyzygyThemeProvider.of(context);

    final visible = avatars.take(max).toList();
    final overflow = avatars.length - visible.length;
    final overlap = _dimension * 0.6;

    return SizedBox(
      height: _dimension,
      width: overlap * (visible.length + (overflow > 0 ? 1 : 0)) + (_dimension - overlap),
      child: Stack(
        children: [
          for (var i = 0; i < visible.length; i++)
            Positioned(
              left: overlap * i,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: theme.colors.surface, width: 2),
                ),
                child: Avatar(initials: visible[i], size: size),
              ),
            ),
          if (overflow > 0)
            Positioned(
              left: overlap * visible.length,
              child: Container(
                width: _dimension,
                height: _dimension,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: theme.colors.surfaceTertiary,
                  border: Border.all(color: theme.colors.surface, width: 2),
                ),
                child: Text(
                  '+$overflow',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(color: theme.colors.onSurface),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
