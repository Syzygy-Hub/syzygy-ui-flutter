import 'package:flutter/animation.dart';

/// Animation duration scale tokens used across the library. Real [Duration]
/// instances, since that's what Flutter's animation APIs take.
class AppAnimationDuration {
  AppAnimationDuration._();

  static const Duration fast = Duration(milliseconds: 150);
  static const Duration normal = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 500);
}

/// Animation easing-curve tokens used across the library, mapped to
/// Flutter's own [Curves].
///
/// Note: Flutter's [Curves] doesn't ship a true physics-based spring curve
/// the way SwiftUI/Compose do. [spring] maps to [Curves.elasticOut], the
/// closest built-in bouncy approximation — not a drop-in equivalent.
class AppAnimationEasing {
  AppAnimationEasing._();

  static const Curve standard = Curves.easeInOut;
  static const Curve decelerate = Curves.decelerate;
  static const Curve accelerate = Curves.easeIn;
  static const Curve spring = Curves.elasticOut;
}
