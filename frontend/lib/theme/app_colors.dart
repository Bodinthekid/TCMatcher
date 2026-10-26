import 'package:flutter/material.dart';

class AppColors {
  static const Color background = Color(0xFF0B0A10);
  static const Color surface = Color(0xFF151421);
  static const Color surfaceLight = Color(0xFF1E1C2E);
  static const Color cardBorder = Color(0xFF2B2840);

  static const Color primaryPurple = Color(0xFF6E62F6);
  static const Color primaryPurpleDark = Color(0xFF282254);
  static const Color accentCyan = Color(0xFF14F1C6);
  static const Color accentCyanDark = Color(0xFF103838);

  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFF9E9BC0);
  static const Color textMuted = Color(0xFF6C698B);

  static const Color pokemonGold = Color(0xFFE5B842);
  static const Color yugiohPurple = Color(0xFF9B62F6);
  static const Color magicOrange = Color(0xFFE86A45);
  static const Color onePieceBlue = Color(0xFF38B6FF);

  static const Color statusOnline = Color(0xFF19E68C);
  static const Color statusAvailable = Color(0xFF7B68EE);
  static const Color statusOffline = Color(0xFF6C698B);
  static const Color errorRed = Color(0xFFE05263);
  static const Color winGreen = Color(0xFF19E68C);
  static const Color winGreenBg = Color(0xFF11352B);
  static const Color lossRed = Color(0xFFE86A45);
  static const Color lossRedBg = Color(0xFF381E24);

  static ThemeData get darkTheme {
    return ThemeData.dark().copyWith(
      scaffoldBackgroundColor: background,
      primaryColor: primaryPurple,
      colorScheme: const ColorScheme.dark(
        primary: primaryPurple,
        secondary: accentCyan,
        surface: surface,
        error: errorRed,
      ),
      textTheme: const TextTheme(
        headlineMedium: TextStyle(
          color: textPrimary,
          fontSize: 28,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.5,
        ),
        titleLarge: TextStyle(
          color: textPrimary,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
        titleMedium: TextStyle(
          color: textPrimary,
          fontSize: 15,
          fontWeight: FontWeight.w600,
        ),
        bodyMedium: TextStyle(
          color: textSecondary,
          fontSize: 13,
        ),
      ),
    );
  }
}