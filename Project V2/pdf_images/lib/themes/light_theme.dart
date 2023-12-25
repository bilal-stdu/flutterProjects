// import 'package:flutter/material.dart';
//
// ThemeData lightTheme() {
//   return ThemeData(
//     primarySwatch: Colors.blue,
//     appBarTheme: const AppBarTheme(
//       backgroundColor: Colors.blue,
//       titleTextStyle: TextStyle(color: Colors.white),
//     ),
//     elevatedButtonTheme: ElevatedButtonThemeData(
//       style: ElevatedButton.styleFrom(
//         foregroundColor: Colors.white, backgroundColor: Colors.blue, // Keep the text color as white
//       ),
//     ),
//     textTheme: const TextTheme(
//       displayLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
//       labelLarge: TextStyle(color: Colors.white),
//     ),
//
//   );
// }
import 'package:flutter/material.dart';

ThemeData lightTheme() {
  return ThemeData(
    primarySwatch: Colors.blue,
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF8115c4),
      titleTextStyle: TextStyle(color: Colors.white, fontFamily: 'Poppins'),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white, backgroundColor: const Color(0xFF8115c4),
      ),
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black, fontFamily: 'Poppins'),
      labelLarge: TextStyle(color: Colors.white, fontFamily: 'Poppins'),
      bodyLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, fontFamily: 'Poppins', color: Colors.black),
      bodySmall: TextStyle(fontSize: 16, color: Color(0xFF757575)),
    ),
  );
}

