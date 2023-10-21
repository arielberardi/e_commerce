import 'package:e_commerce/components/onboarding/onboarding_page_content.dart';
import 'package:flutter/material.dart';

class OnboardingImageClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final double w = size.width;
    final double h = size.height;

    final Path path = Path();
    path.moveTo(w * 0.15, 0);
    path.quadraticBezierTo(0, 0, 0, h * 0.15);
    path.cubicTo(0, h * 0.33, 0, h * 0.65, 0, h * 0.82);
    path.cubicTo(0, h * 0.99, w * 0.08, h * 0.99, w * 0.15, h * 0.98);
    path.cubicTo(w * 0.33, h * 0.95, w * 0.70, h * 0.87, w * 0.85, h * 0.83);
    path.cubicTo(w * 0.95, h * 0.80, w, h * 0.80, w, h * 0.67);
    path.quadraticBezierTo(w, h * 0.55, w, h * 0.15);
    path.quadraticBezierTo(w, 0, w * 0.85, 0);
    path.quadraticBezierTo(w * 0.70, 0, w * 0.15, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}

class OnboardingBody extends StatelessWidget {
  const OnboardingBody({
    super.key,
    required this.page,
  });

  final OnboardingPageContent page;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipPath(
          clipper: OnboardingImageClipper(),
          child: Image.asset(page.imagePath, fit: BoxFit.cover),
        ),
        const SizedBox(height: 40.0),
        Text(
          page.title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 15.0),
        Text(
          page.body,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
