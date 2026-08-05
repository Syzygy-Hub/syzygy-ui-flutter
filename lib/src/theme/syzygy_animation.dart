
class SyzygyAnimationDuration {
  const SyzygyAnimationDuration({required this.fast, required this.normal, required this.slow});
  final Duration fast, normal, slow;
  static const defaultDuration = SyzygyAnimationDuration(
    fast: Duration(milliseconds: 150),
    normal: Duration(milliseconds: 300),
    slow: Duration(milliseconds: 500),
  );
}

class SyzygyAnimation {
  const SyzygyAnimation({required this.duration});
  final SyzygyAnimationDuration duration;
  static const defaultAnimation = SyzygyAnimation(duration: SyzygyAnimationDuration.defaultDuration);
}
