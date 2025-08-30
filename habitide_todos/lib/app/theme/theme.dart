import 'package:flutter/material.dart';

import 'typography.dart';

class AppTheme {
  static final ThemeData dark = ThemeData(
    primaryColor: Color(0xFF007AFF),
    colorScheme: ColorScheme.dark(
      primary: Color(0xFF007AFF),
      secondary: Color(0xFFFF9500),
      background: Color(0xFF121212),
      surface: Color(0xFF1E1E1E),
      error: Color(0xFFFF3B30),
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onBackground: Colors.white,
      onSurface: Colors.white,
      onError: Colors.white,
    ),
    scaffoldBackgroundColor: Color(0xFF121212),
    textTheme: TextTheme(
      displayLarge: AppTypography.screenTitle,
      displayMedium: AppTypography.sectionHeader,
      bodyLarge: AppTypography.body,
      bodyMedium: AppTypography.subtext,
      labelLarge: AppTypography.buttonText,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFF1E1E1E),
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: AppTypography.sectionHeader,
    ),
    cardTheme: CardThemeData(
      color: Color(0xFF1E1E1E),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Color(0xFF2C2C2E),
      hintStyle: AppTypography.subtext,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Color(0xFF007AFF),
    ),
  );
}
