import 'package:flutter/material.dart';

import '../../tokens/colors.dart';
import '../feedback/shimmer_view.dart';

/// Asynchronously loads a remote image using Flutter's core [Image.network]
/// (which handles async loading and caching natively — no third-party
/// image-loading dependency needed), showing a [ShimmerView] placeholder
/// while loading and a fallback glyph if the load fails.
class LazyImageView extends StatelessWidget {
  const LazyImageView({
    super.key,
    required this.url,
    this.fit = BoxFit.cover,
  });

  final String? url;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    if (url == null || url!.isEmpty) {
      return _fallback(colors);
    }

    return Image.network(
      url!,
      fit: fit,
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return const ShimmerView();
      },
      errorBuilder: (context, error, stackTrace) => _fallback(colors),
    );
  }

  Widget _fallback(AppColors colors) {
    return Semantics(
      label: 'Image failed to load',
      child: Container(
        color: colors.surface,
        alignment: Alignment.center,
        child: Icon(Icons.broken_image_outlined, color: colors.secondary),
      ),
    );
  }
}
