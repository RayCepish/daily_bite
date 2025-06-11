import 'package:flutter/material.dart';

class AppTheme {
  static const Color surface = Color(0xFFFFFFFF);
  static const Color primaryColor = Color(0xFF94DEA5);
  static const Color secondaryPrimary = Color.fromARGB(183, 53, 206, 26);

  static const Color secondaryColor = Color(0xFFFFF066);
  static const Color accentColor = Color(0xFF826CF6);
  static const Color secondaryAccentColor = Color(0xFF023D54);
  static const Color onSecondary = Color.fromARGB(255, 89, 96, 89);
  static const Color onError = Color.fromARGB(255, 209, 4, 4);

  static const Color chartProteinColor = Color(0xFFFFBE0B);
  static const Color chartFatColor = Color(0xFF219EBC);
  static const Color chartCarbsColor = Color(0xFFFF006E);
  static const Color chartCaloriesColor = Color(0xFF8338EC);

  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: surface,
      checkboxTheme: CheckboxThemeData(
        shape: const CircleBorder(),
        side: const BorderSide(color: primaryColor, width: 1.5),
        fillColor: WidgetStateProperty.resolveWith(
          (states) {
            if (states.contains(WidgetState.selected)) {
              return primaryColor;
            }
            return surface;
          },
        ),
        checkColor: WidgetStateProperty.all(Colors.white),
      ),
      colorScheme: const ColorScheme(
        primary: primaryColor,
        primaryFixed: secondaryPrimary,
        primaryContainer: accentColor,
        secondary: secondaryAccentColor,
        secondaryContainer: secondaryColor,
        surface: surface,
        error: onError,
        onPrimary: Colors.white,
        onSecondary: onSecondary,
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
