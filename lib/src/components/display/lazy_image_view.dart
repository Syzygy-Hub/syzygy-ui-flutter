import 'package:flutter/material.dart';

import '../feedback/shimmer_view.dart';
import '../../theme/theme.dart';

/// Asynchronously loads a remote image using Flutter's core [Image.network]
/// (which handles async loading and caching natively — no third-party
/// image-loading dependency needed), showing a [ShimmerView] placeholder
/// while loading and a fallback glyph if the load fails.
class LazyImageView extends StatelessWidget {
  const LazyImageView({
    super.key,
    required this.url,
    this.fit = BoxFit.cover,
  
    this.theme,});

  final String? url;
  final BoxFit fit;

  final SyzygyTheme? theme;
  @override
  Widget build(BuildContext context) {
    final theme = this.theme ?? SyzygyThemeProvider.of(context);

    if (url == null || url!.isEmpty) {
      return _fallback(theme);
    }

    return Image.network(
      url!,
      fit: fit,
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return const ShimmerView();
      },
      errorBuilder: (context, error, stackTrace) => _fallback(theme),
    );
  }

  Widget _fallback(SyzygyTheme theme) {
    return Semantics(
      label: 'Image failed to load',
      child: Container(
        color: theme.colors.surface,
        alignment: Alignment.center,
        child: Icon(Icons.broken_image_outlined, color: theme.colors.secondary),
      ),
    );
  }
}
