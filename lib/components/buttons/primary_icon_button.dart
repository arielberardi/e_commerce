import 'package:flutter/material.dart';

class PrimaryIconButton extends StatelessWidget {
  const PrimaryIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.size = 30,
    this.padding = const EdgeInsets.all(10.0),
    this.radius = 50.0,
  });

  final IconData icon;
  final VoidCallback onPressed;
  final EdgeInsetsGeometry? padding;
  final double size;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(radius),
        ),
        child: Icon(icon, color: Colors.white, size: size),
      ),
    );
  }
}
