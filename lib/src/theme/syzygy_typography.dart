import 'package:flutter/material.dart';

class SyzygyTypography {
  const SyzygyTypography({
    required this.largeTitle, required this.display, required this.title,
    required this.headline, required this.body, required this.callout,
    required this.subheadline, required this.footnote, required this.caption,
  });
  final TextStyle largeTitle, display, title, headline, body, callout, subheadline, footnote, caption;

  static const defaultTypography = SyzygyTypography(
    largeTitle: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
    display: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
    title: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
    headline: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
    body: TextStyle(fontSize: 17, fontWeight: FontWeight.normal),
    callout: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
    subheadline: TextStyle(fontSize: 15, fontWeight: FontWeight.normal),
    footnote: TextStyle(fontSize: 13, fontWeight: FontWeight.normal),
    caption: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
  );

  static const highContrast = SyzygyTypography(
    largeTitle: TextStyle(fontSize: 34, fontWeight: FontWeight.w900),
    display: TextStyle(fontSize: 28, fontWeight: FontWeight.w900),
    title: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
    headline: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
    body: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
    callout: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    subheadline: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
    footnote: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
    caption: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
  );
}
