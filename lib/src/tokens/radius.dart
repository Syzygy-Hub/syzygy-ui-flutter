/// Border radius scale tokens used across the library.
class AppRadius {
  AppRadius._();

  static const double xs = 2.0;
  static const double sm = 4.0;
  static const double md = 8.0;
  static const double lg = 16.0;
  // Note: xl intentionally shares lg's numeric value. They're distinct
  // semantic tokens (e.g. "large card" vs "extra-large sheet corner") that
  // happen to resolve to the same pixel value today — not a bug.
  static const double xl = 16.0;
  static const double full = 9999.0;
}
