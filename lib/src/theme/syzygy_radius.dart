class SyzygyRadius {
  const SyzygyRadius({
    required this.xs, required this.sm, required this.md,
    required this.lg, required this.xl, required this.full,
  });
  final double xs, sm, md, lg, xl, full;

  static const defaultRadius = SyzygyRadius(xs: 2, sm: 4, md: 8, lg: 16, xl: 24, full: 9999);
  static const sharp = SyzygyRadius(xs: 0, sm: 0, md: 0, lg: 0, xl: 0, full: 0);
}
