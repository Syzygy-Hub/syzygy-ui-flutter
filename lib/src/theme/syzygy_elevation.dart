class SyzygyElevation {
  const SyzygyElevation({required this.none, required this.sm, required this.md, required this.lg});
  final double none, sm, md, lg;
  static const defaultElevation = SyzygyElevation(none: 0, sm: 1, md: 4, lg: 8);
}
