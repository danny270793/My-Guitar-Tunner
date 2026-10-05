import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  // Red is reserved for destructive actions, so the accent colour drives the
  // regular buttons and the error colour stays the only red in the palette.
  static ThemeData get dark {
    final base = ThemeData.dark(useMaterial3: true);
    return base.copyWith(
      colorScheme: base.colorScheme.copyWith(
        primary: const Color(0xFF9A93FF),
        onPrimary: const Color(0xFF1B1464),
        secondary: const Color(0xFF7C74F0),
        surface: const Color(0xFF121212),
      ),
      scaffoldBackgroundColor: const Color(0xFF0A0A0A),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF0A0A0A),
        elevation: 0,
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        clipBehavior: Clip.antiAlias,
      ),
    );
  }

  static ThemeData get light {
    final base = ThemeData.light(useMaterial3: true);
    return base.copyWith(
      colorScheme: base.colorScheme.copyWith(
        primary: const Color(0xFF4F46C8),
        onPrimary: Colors.white,
        secondary: const Color(0xFF6A62E6),
      ),
      scaffoldBackgroundColor: const Color(0xFFFAFAFA),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFFFAFAFA),
        elevation: 0,
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        clipBehavior: Clip.antiAlias,
      ),
    );
  }
}
