import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData light() {
    const baseTextColor = Color(0xFF172334);
    const mutedText = Color(0xFF5E6C81);

    final textTheme = GoogleFonts.sarabunTextTheme().copyWith(
      headlineSmall: GoogleFonts.sarabun(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: baseTextColor,
      ),
      titleLarge: GoogleFonts.sarabun(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: baseTextColor,
      ),
      titleMedium: GoogleFonts.sarabun(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: baseTextColor,
      ),
      bodyLarge: GoogleFonts.sarabun(
        fontSize: 18,
        color: baseTextColor,
      ),
      bodyMedium: GoogleFonts.sarabun(
        fontSize: 15,
        color: mutedText,
      ),
    );

    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: Colors.transparent,
      textTheme: textTheme,
      colorScheme: const ColorScheme.light(
        primary: Color(0xFFCEDDF4),
        secondary: Color(0xFF8EB3DD),
        surface: Color(0xFFDAE7F6),
      ),
      inputDecorationTheme: InputDecorationTheme(
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.18),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.35)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.35)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Color(0xFFBCEBFF), width: 1.3),
        ),
      ),
    );
  }
}
