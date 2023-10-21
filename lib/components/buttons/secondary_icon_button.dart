import 'package:flutter/material.dart';

class SecondaryIconButton extends StatelessWidget {
  const SecondaryIconButton({
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
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(radius),
        ),
        child: Icon(icon, color: Colors.black, size: size),
      ),
    );
  }
}
