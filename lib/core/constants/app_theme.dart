import 'package:flutter/material.dart';

class AppTheme {
  static const Color surface = Color(0xFFFFFFFF);
  static const Color primaryColor = Color(0xFF94DEA5);
  static const Color secondaryColor = Color(0xFFFFF066);
  static const Color accentColor = Color(0xFF826CF6);
  static const Color secondaryAccentColor = Color(0xFF023D54);

  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: surface,
      colorScheme: const ColorScheme(
        primary: primaryColor,
        primaryContainer: accentColor,
        secondary: secondaryAccentColor,
        secondaryContainer: secondaryColor,
        surface: surface,
        error: Colors.red,
        onPrimary: Colors.white,
        onSecondary: Colors.black,
        onSurface: Colors.black,
        onError: Colors.white,
        brightness: Brightness.light,
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: secondaryAccentColor,
        ),
        headlineMedium: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w500,
          color: secondaryAccentColor,
        ),
        headlineSmall: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.normal,
          color: secondaryAccentColor,
        ),
        titleLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: surface,
        ),
        titleMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: secondaryAccentColor,
        ),
        titleSmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w300,
          color: secondaryAccentColor,
        ),
      ),
    );
  }
}
