class SyzygySpacing {
  const SyzygySpacing({
    required this.xxs, required this.xs, required this.sm, required this.md,
    required this.lg, required this.xl, required this.xxl, required this.xxxl,
  });
  final double xxs, xs, sm, md, lg, xl, xxl, xxxl;
  static const defaultSpacing = SyzygySpacing(
    xxs: 2, xs: 4, sm: 8, md: 16, lg: 24, xl: 32, xxl: 48, xxxl: 64,
  );
}
