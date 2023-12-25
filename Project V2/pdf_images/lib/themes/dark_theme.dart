// import 'package:flutter/material.dart';
//
// ThemeData darkTheme() {
//   return ThemeData(
//     brightness: Brightness.dark,
//     scaffoldBackgroundColor: Colors.grey[850],
//     appBarTheme: const AppBarTheme(
//       backgroundColor: Colors.black,
//       titleTextStyle: TextStyle(color: Colors.white),
//     ),
//     elevatedButtonTheme: ElevatedButtonThemeData(
//       style: ElevatedButton.styleFrom(
//         foregroundColor: Colors.white, backgroundColor: Colors.grey[700], // Keep the text color as white
//       ),
//     ),
//     textTheme: const TextTheme(
//       displayLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
//       labelLarge: TextStyle(color: Colors.black),
//     ),
//   );
// }
import 'package:flutter/material.dart';

ThemeData darkTheme() {
  return ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.grey[850],
    appBarTheme: const AppBarTheme(
      //backgroundColor: Color(0xFFFDB813), // Light yellow color
      backgroundColor: Colors.black,
      titleTextStyle: TextStyle(color: Colors.white, fontFamily: 'Poppins'),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.black, // Light yellow color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),

    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: 'Poppins'),
      labelLarge: TextStyle(color: Colors.black, fontFamily: 'Poppins'),
      bodyLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, fontFamily: 'Poppins', color: Colors.white),
      bodySmall: TextStyle(fontSize: 16, color: Colors.white),
      titleLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: 'Poppins'),
        titleMedium: TextStyle(fontSize: 16,color: Colors.white, fontFamily: 'Poppins'),
    ),
  );
}

