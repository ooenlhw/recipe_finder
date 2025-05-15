import 'package:flutter/material.dart';

final Color kPrimaryColor = Color(0xFFF4B030); // golden yellow
final Color kSecondaryColor = Color(0xFF7D7E19); // olive green
final Color kAccentColor = Colors.white; // dark red

final ThemeData appTheme = ThemeData(
  colorScheme: ColorScheme(
    brightness: Brightness.light,
    primary: kPrimaryColor, // App bar, buttons
    onPrimary: Colors.white, // Text/icon on primary
    secondary: kSecondaryColor, // Floating buttons, highlights
    onSecondary: Colors.white,
    error: Colors.red,
    onError: Colors.white,
    surface: Colors.grey[100]!,
    onSurface: Colors.black,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: kSecondaryColor,
    foregroundColor: kPrimaryColor,
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: kSecondaryColor,
    foregroundColor: Colors.black,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: kPrimaryColor,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  ),
  textTheme: TextTheme(
    headlineLarge: TextStyle(
      color: Colors.white,
      fontSize: 24,
      fontWeight: FontWeight.bold,
    ),
    titleLarge: TextStyle(
      color: kSecondaryColor,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    bodyMedium: TextStyle(
      color: Colors.black,
      fontSize: 16,
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: kPrimaryColor),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: kSecondaryColor),
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedItemColor: Color(0xFFF4B030),
    unselectedItemColor: Color(0xFF7D7E19),
    selectedIconTheme: IconThemeData(size: 28),
    unselectedIconTheme: IconThemeData(size: 24),
    showUnselectedLabels: true,
  ),
);
