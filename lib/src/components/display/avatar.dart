import 'package:flutter/material.dart';

import '../../theme/theme.dart';

/// Size options for [Avatar].
enum AvatarSize { small, medium, large }

extension on AvatarSize {
  double get dimension => switch (this) {
        AvatarSize.small => 32,
        AvatarSize.medium => 44,
        AvatarSize.large => 64,
      };
}

/// A circular avatar showing a fallback initials label.
class Avatar extends StatelessWidget {
  const Avatar({
    super.key,
    required this.initials,
    this.size = AvatarSize.medium,
  
    this.theme,});

  final String initials;
  final AvatarSize size;

  final SyzygyTheme? theme;
  @override
  Widget build(BuildContext context) {
    final theme = this.theme ?? SyzygyThemeProvider.of(context);


    return Semantics(
      label: initials,
      child: Container(
        width: size.dimension,
        height: size.dimension,
        alignment: Alignment.center,
        decoration: BoxDecoration(color: theme.colors.primary, shape: BoxShape.circle),
        child: Text(
          initials,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(color: theme.colors.onPrimary),
        ),
      ),
    );
  }
}
