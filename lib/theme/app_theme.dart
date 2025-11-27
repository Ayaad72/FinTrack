import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: const Color(0xfff6f4ee), // Creamy background
    primaryColor: Colors.deepPurpleAccent,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.deepPurple,
      primary: Colors.deepPurpleAccent,
      secondary: const Color(0xFF6B4EFF),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: Colors.black87,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(color: Colors.black87),
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.black87, fontSize: 16),
      bodyMedium: TextStyle(color: Colors.black54, fontSize: 14),
      headlineSmall: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 24,
      ),
    ),
    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(color: Colors.grey.shade200),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: Colors.grey.shade200),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: Colors.grey.shade200),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Colors.deepPurpleAccent, width: 2),
      ),
      hintStyle: TextStyle(color: Colors.grey[400]),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Colors.deepPurpleAccent,
      foregroundColor: Colors.white,
      elevation: 4,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepPurpleAccent,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        elevation: 2,
      ),
    ),
    iconTheme: const IconThemeData(color: Colors.deepPurpleAccent),
  );
}
