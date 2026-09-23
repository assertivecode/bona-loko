import 'package:flutter/material.dart';

/// Defines the design theme tokens for Bona Loko, strictly synchronized
/// with the web application design system (web-app/assets/css/main.css).
class AppTheme {
  AppTheme._();

  // Primary Brand: Warm Orange ("Bona")
  static const Color primaryOrange = Color(0xFFE86A1B);
  static const Color primaryHover = Color(0xFFD25A10);
  static const Color primaryActive = Color(0xFFBC4E0C);
  static const Color primaryLight = Color(0xFFFFF4EC);
  static const Color primaryBorder = Color(0xFFFED7BE);

  // Secondary Brand: Teal-Green ("Loko")
  static const Color secondaryTeal = Color(0xFF269B87);
  static const Color secondaryHover = Color(0xFF1E8271);
  static const Color secondaryActive = Color(0xFF176A5C);
  static const Color secondaryLight = Color(0xFFEDF7F5);
  static const Color secondaryBorder = Color(0xFFBCE4DC);

  // Tertiary Brand: Deep Slate Blue & Amber Gold
  static const Color tertiaryBlue = Color(0xFF1A5F89);
  static const Color tertiaryBlueLight = Color(0xFFEDF5FA);
  static const Color tertiaryGold = Color(0xFFF59E0B);
  static const Color accentSand = Color(0xFFD8BA91);

  // Canvas & Surfaces
  static const Color bgCanvas = Color(0xFFFCFBF7);
  static const Color bgSurface = Color(0xFFFFFFFF);
  static const Color bgSubtle = Color(0xFFF5F2E8);
  static const Color bgCream = Color(0xFFFAF7EF);

  // Borders
  static const Color borderColor = Color(0xFFE8E2D4);
  static const Color borderSubtle = Color(0xFFF0ECDF);
  static const Color borderStrong = Color(0xFFD5CBB8);

  // Typography
  static const Color textPrimary = Color(0xFF1A202C);
  static const Color textSecondary = Color(0xFF4A5568);
  static const Color textMuted = Color(0xFF718096);

  static ThemeData get lightTheme {
    const colorScheme = ColorScheme(
      brightness: Brightness.light,
      primary: primaryOrange,
      onPrimary: Colors.white,
      primaryContainer: primaryLight,
      onPrimaryContainer: primaryActive,
      secondary: secondaryTeal,
      onSecondary: Colors.white,
      secondaryContainer: secondaryLight,
      onSecondaryContainer: secondaryActive,
      tertiary: tertiaryBlue,
      onTertiary: Colors.white,
      tertiaryContainer: tertiaryBlueLight,
      onTertiaryContainer: Color(0xFF144D70),
      error: Color(0xFFBA1A1A),
      onError: Colors.white,
      errorContainer: Color(0xFFFFDAD6),
      onErrorContainer: Color(0xFF410002),
      surface: bgSurface,
      onSurface: textPrimary,
      onSurfaceVariant: textSecondary,
      surfaceContainerLowest: bgSurface,
      surfaceContainerLow: bgCanvas,
      surfaceContainer: bgSubtle,
      surfaceContainerHigh: bgCream,
      surfaceContainerHighest: Color(0xFFEFE9DC),
      outline: borderColor,
      outlineVariant: borderStrong,
      shadow: Color(0x142D2314),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: bgCanvas,
      appBarTheme: const AppBarTheme(
        centerTitle: false,
        elevation: 0,
        backgroundColor: bgCanvas,
        foregroundColor: textPrimary,
        surfaceTintColor: Colors.transparent,
      ),
      cardTheme: CardTheme(
        color: bgSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: borderColor),
        ),
      ),
      sliderTheme: SliderThemeData(
        activeTrackColor: primaryOrange,
        inactiveTrackColor: bgSubtle,
        thumbColor: primaryOrange,
        overlayColor: primaryOrange.withOpacity(0.15),
        trackHeight: 6,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryOrange,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    const colorScheme = ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xFFFF8E47),
      onPrimary: Color(0xFF4E1D00),
      primaryContainer: Color(0xFF702D00),
      onPrimaryContainer: Color(0xFFFFDBCB),
      secondary: Color(0xFF42D6BD),
      onSecondary: Color(0xFF00382E),
      secondaryContainer: Color(0xFF005144),
      onSecondaryContainer: Color(0xFF6FF8DF),
      tertiary: Color(0xFF86C8FF),
      onTertiary: Color(0xFF003352),
      tertiaryContainer: Color(0xFF004B74),
      onTertiaryContainer: Color(0xFFCBE6FF),
      error: Color(0xFFFFB4AB),
      onError: Color(0xFF690005),
      surface: Color(0xFF181C20),
      onSurface: Color(0xFFE1E2E5),
      onSurfaceVariant: Color(0xFFC2C7CF),
      surfaceContainerLowest: Color(0xFF101417),
      surfaceContainerLow: Color(0xFF15191C),
      surfaceContainer: Color(0xFF1D2124),
      surfaceContainerHigh: Color(0xFF272B2E),
      surfaceContainerHighest: Color(0xFF323639),
      outline: Color(0xFF49454E),
      outlineVariant: Color(0xFF38353D),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: const Color(0xFF121517),
      appBarTheme: const AppBarTheme(
        centerTitle: false,
        elevation: 0,
        backgroundColor: Color(0xFF121517),
        foregroundColor: Color(0xFFE1E2E5),
        surfaceTintColor: Colors.transparent,
      ),
      cardTheme: CardTheme(
        color: const Color(0xFF181C20),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: Color(0xFF38353D)),
        ),
      ),
      sliderTheme: SliderThemeData(
        activeTrackColor: const Color(0xFFFF8E47),
        inactiveTrackColor: const Color(0xFF272B2E),
        thumbColor: const Color(0xFFFF8E47),
        overlayColor: const Color(0xFFFF8E47).withOpacity(0.15),
        trackHeight: 6,
      ),
    );
  }
}
