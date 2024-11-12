import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryLight = Color(0xFF5D9CEC);
  static const Color backgroundLight = Color(0xFFDFECDB);
  static const Color backgroundDark = Color(0xFF060E1E);
  static const Color black = Color(0xFF363636);
  static const Color white = Color(0xFFFFFFFF);
  static const Color grey = Color(0xFFC8C9CB);
  static const Color green = Color(0xFF61E757);
  static const Color red = Color(0xFFEC4B4B);

  static ThemeData lightTheme = ThemeData(
      textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(foregroundColor: primaryLight)),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(backgroundColor: primaryLight)),
      textTheme: const TextTheme(
        bodySmall:
            TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: white),
        titleLarge:
            TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: black),
        titleMedium:
            TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: black),
        titleSmall:
            TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: black),
        labelLarge: TextStyle(
            fontSize: 15, fontWeight: FontWeight.bold, color: primaryLight),
      ),
      primaryColor: primaryLight,
      scaffoldBackgroundColor: backgroundLight,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
          backgroundColor: white,
          selectedItemColor: primaryLight,
          unselectedItemColor: grey,
          showSelectedLabels: false,
          showUnselectedLabels: false),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: primaryLight,
          foregroundColor: white,
          shape: CircleBorder(side: BorderSide(color: white, width: 4))));
  static ThemeData darkTheme = ThemeData();
}
