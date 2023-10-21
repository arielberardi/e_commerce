import 'package:flutter/material.dart';

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    super.key,
    this.text,
    this.icon,
    required this.onPressed,
    this.style,
    this.width,
    this.height,
    this.padding,
  }) : assert(
          text != null || icon != null,
          'Text and Icon cannot both be null',
        );

  final String? text;
  final Widget? icon;
  final VoidCallback onPressed;
  final ButtonStyle? style;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;

  Widget generateButton() {
    if (text != null && icon != null) {
      return OutlinedButton.icon(
        label: Text(text!),
        icon: icon!,
        onPressed: onPressed,
        style: style,
      );
    }

    return OutlinedButton(
        onPressed: onPressed,
        style: style,
        child: icon ?? Text(text!),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: height ?? 50,
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 25.0),
      child: generateButton(),
    );
  }
}
