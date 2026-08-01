import 'package:flutter/material.dart';

/// A single destination shown in `TabBar` or `BottomNavigationBar`.
class TabBarItem<T> {
  const TabBarItem({required this.tag, required this.icon, required this.label});

  final T tag;
  final IconData icon;
  final String label;
}
