import 'package:flutter/material.dart';

class MenuItem {
  const MenuItem(this.title, this.icon, this.onTap);

  final String title;
  final IconData icon;
  final VoidCallback onTap;
}
