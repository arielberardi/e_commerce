import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  fontFamily: GoogleFonts.poppins().fontFamily,
  colorScheme: const ColorScheme.light().copyWith(
    primary: Colors.black,
    secondary: Colors.grey[200],
    background: Colors.white,
    primaryContainer: Colors.grey[200],
  ),
  scaffoldBackgroundColor: Colors.white,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Colors.black,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(45.0)),
      textStyle: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      backgroundColor: Colors.transparent,
      side: const BorderSide(width: 1, color: Colors.black),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(45.0)),
      textStyle: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
  textTheme: TextTheme(
    titleLarge: GoogleFonts.poppins(
      textStyle: ThemeData.light().textTheme.titleLarge,
      fontWeight: FontWeight.bold,
    ),
    titleMedium: GoogleFonts.poppins(
      textStyle: ThemeData.light().textTheme.titleMedium,
      fontWeight: FontWeight.bold,
    ),
    titleSmall: GoogleFonts.poppins(
      textStyle: ThemeData.light().textTheme.titleSmall,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    ),
    bodyLarge: GoogleFonts.poppins(
      textStyle: ThemeData.light().textTheme.bodyLarge,
      fontWeight: FontWeight.bold,
      color: Colors.grey[700],
    ),
    bodyMedium: GoogleFonts.poppins(
      textStyle: ThemeData.light().textTheme.bodyMedium,
      color: Colors.grey[700],
    ),
    bodySmall: GoogleFonts.poppins(
      textStyle: ThemeData.light().textTheme.bodySmall,
      color: Colors.grey[700],
      fontSize: 10,
    ),
    labelLarge: GoogleFonts.poppins(
      textStyle: ThemeData.light().textTheme.labelLarge,
      fontWeight: FontWeight.bold,
    ),
    labelMedium: GoogleFonts.poppins(
      textStyle: ThemeData.light().textTheme.labelMedium,
      color: Colors.grey[700],
    ),
    labelSmall: GoogleFonts.poppins(
      textStyle: ThemeData.light().textTheme.labelSmall,
      fontSize: 10,
    ),
  ),
);
