/// Elevation scale tokens used across the library. These are plain double
/// values consumable directly by Flutter's own elevation-aware widgets, e.g.
/// `Material(elevation: AppElevation.md, ...)` or as a shadow blur radius on
/// a [BoxShadow].
class AppElevation {
  AppElevation._();

  static const double none = 0.0;
  static const double sm = 1.0;
  static const double md = 4.0;
  static const double lg = 8.0;
}
