import 'package:flutter/material.dart';

import '../../theme/theme.dart';

/// Where [NetworkStatusBanner] anchors within its parent.
enum NetworkBannerPosition { top, bottom }

/// A banner showing "No internet connection" when offline, auto-dismissing
/// (via an `AnimatedSwitcher`/`AnimatedSlide`-style show/hide) when
/// connectivity returns.
///
/// Flutter's core SDK has no built-in connectivity-detection API — the
/// standard solution is the third-party `connectivity_plus` package (which
/// itself wraps iOS's native `NWPathMonitor` and Android's native
/// `ConnectivityManager` — both first-party OS APIs with no Flutter-SDK
/// equivalent). Given this library's zero-third-party-dependency goal,
/// `NetworkStatusBanner` does NOT attempt to detect connectivity itself.
/// It is a controlled/presentational widget: the consumer supplies
/// [isOffline] (e.g. sourced from `connectivity_plus`, a custom platform
/// channel, or their own heuristic) and this widget only handles the
/// presentation (position, styling, show/hide animation, optional manual
/// override).
class NetworkStatusBanner extends StatelessWidget {
  const NetworkStatusBanner({
    super.key,
    required this.isOffline,
    this.manualOverride,
    this.position = NetworkBannerPosition.top,
    this.message = 'No internet connection',
  
    this.theme,});

  /// Whether the device is currently offline. The consumer is responsible
  /// for sourcing this (this widget performs no connectivity detection).
  final bool isOffline;

  /// When non-null, overrides [isOffline] — e.g. to force-show the banner
  /// for testing, or force-hide it during a known-flaky transition.
  final bool? manualOverride;

  final NetworkBannerPosition position;
  final String message;

  final SyzygyTheme? theme;
  @override
  Widget build(BuildContext context) {
    final theme = this.theme ?? SyzygyThemeProvider.of(context);

    final visible = manualOverride ?? isOffline;

    final banner = Material(
      color: theme.colors.destructive,
      child: SafeArea(
        top: position == NetworkBannerPosition.top,
        bottom: position == NetworkBannerPosition.bottom,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: theme.spacing.md, vertical: theme.spacing.sm),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.wifi_off, color: theme.colors.onDestructive, size: 16),
              SizedBox(width: theme.spacing.xs),
              Text(message, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: theme.colors.onDestructive)),
            ],
          ),
        ),
      ),
    );

    return AnimatedSize(
      duration: const Duration(milliseconds: 200),
      alignment: position == NetworkBannerPosition.top ? Alignment.topCenter : Alignment.bottomCenter,
      child: visible ? banner : const SizedBox(width: double.infinity, height: 0),
    );
  }
}
