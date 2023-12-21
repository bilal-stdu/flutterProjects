import 'package:flutter/material.dart';

ThemeData darkTheme() {
  return ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.grey[850],
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      titleTextStyle: TextStyle(color: Colors.white),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white, backgroundColor: Colors.grey[700], // Keep the text color as white
      ),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      labelLarge: TextStyle(color: Colors.black),
    ),
  );
}
