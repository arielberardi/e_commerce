import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BrandLogo extends StatelessWidget {
  const BrandLogo({super.key, this.color = Colors.white});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Fashions',
          textAlign: TextAlign.center,
          style: GoogleFonts.greatVibes(
              color: color,
              fontSize: 50,
              fontWeight: FontWeight.normal,
              decoration: TextDecoration.none,
              height: 0.5),
        ),
        Text(
          'My Life My Style',
          textAlign: TextAlign.center,
          style: GoogleFonts.amaticSc(
            color: color,
            fontSize: 15,
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.none,
            letterSpacing: 1,
          ),
        ),
      ],
    );
  }
}
