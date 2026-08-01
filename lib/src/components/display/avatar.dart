import 'package:flutter/material.dart';

import '../../tokens/colors.dart';

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
  });

  final String initials;
  final AvatarSize size;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return Semantics(
      label: initials,
      child: Container(
        width: size.dimension,
        height: size.dimension,
        alignment: Alignment.center,
        decoration: BoxDecoration(color: colors.primary, shape: BoxShape.circle),
        child: Text(
          initials,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(color: colors.onPrimary),
        ),
      ),
    );
  }
}
