import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    primarySwatch: Colors.indigo,
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.grey[50],
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.indigo,
      titleTextStyle: GoogleFonts.poppins(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),
    textTheme: GoogleFonts.poppinsTextTheme().copyWith(
      titleLarge: GoogleFonts.poppins(
        color: Colors.indigo[800],
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: GoogleFonts.poppins(
        color: Colors.grey[800],
      ),
      bodyMedium: GoogleFonts.poppins(
        color: Colors.grey[600],
      ),
    ),
  );

  static final darkTheme = ThemeData(
    primarySwatch: Colors.indigo,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.grey[900],
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.indigo[800],
      titleTextStyle: GoogleFonts.poppins(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
    ),
    textTheme: GoogleFonts.poppinsTextTheme().copyWith(
      titleLarge: GoogleFonts.poppins(
        color: Colors.indigo[100],
        fontWeight: FontWeight.w600,
      ),
      bodyLarge: GoogleFonts.poppins(
        color: Colors.grey[300],
      ),
      bodyMedium: GoogleFonts.poppins(
        color: Colors.grey[400],
      ),
    ),
  );
}