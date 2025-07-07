import 'package:flutter/material.dart';

class AppTheme {
  // Base Colors
  static const Color primaryColor = Color(0xFF7F85F0); // Deep Purple
  static const Color secondaryColor = primaryColor; // Purple used everywhere
  static const Color accentColor = Colors.white;
  static const Color backgroundColor = Color.fromARGB(
    255,
    12,
    11,
    11,
  ); // Darker Background
  static const Color textColor = Color.fromARGB(255, 29, 26, 26);
  static const Color greyTextColor = Colors.grey;
  static const Color dividerColor = Color.fromARGB(255, 15, 15, 15);

  // Text Styles
  static const TextStyle displayLarge = TextStyle(
    fontSize: 32.0,
    fontWeight: FontWeight.bold,
    color: textColor,
  );

  static const TextStyle displayMedium = TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.w600,
    color: textColor,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.normal,
    color: textColor,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.normal,
    color: greyTextColor,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 12.0,
    fontWeight: FontWeight.w300,
    color: greyTextColor,
  );

  // Elevated Button Style
  static final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
    backgroundColor: primaryColor, // Using purple
    foregroundColor: Colors.white,
    textStyle: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      letterSpacing: 1.0,
    ),
    padding: const EdgeInsets.symmetric(vertical: 16),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(4), // Flat, square-ish
    ),
    elevation: 0, // Flat design
  );

  // TextButton Style
  static final ButtonStyle textButtonStyle = TextButton.styleFrom(
    foregroundColor: primaryColor, // Purple for text buttons
    textStyle: const TextStyle(fontWeight: FontWeight.w600),
  );

  // Outlined Button Style
  static final ButtonStyle outlinedButtonStyle = OutlinedButton.styleFrom(
    foregroundColor: primaryColor, // Purple for outlined buttons
    side: const BorderSide(color: dividerColor),
    textStyle: const TextStyle(fontWeight: FontWeight.w600),
  );

  // Input Fields Style
  static final InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
    filled: true,
    fillColor: const Color.fromARGB(255, 240, 240, 240),
    hintStyle: const TextStyle(color: Color.fromARGB(255, 22, 18, 18)),
    labelStyle: const TextStyle(color: Color.fromARGB(255, 20, 10, 10)),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: Color.fromARGB(255, 248, 248, 248)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(color: Color.fromARGB(223, 255, 255, 255)),
    ),
  );

  // AppBar Theme (Updated to use purple)
  static const AppBarTheme appBarTheme = AppBarTheme(
    color: primaryColor, // Deep Purple
    iconTheme: IconThemeData(color: accentColor),
    titleTextStyle: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: accentColor,
    ),
  );

  // Bottom Navigation
  static final BottomNavigationBarThemeData bottomNavigationBarTheme =
      BottomNavigationBarThemeData(
        backgroundColor: primaryColor, // Purple
        selectedItemColor: primaryColor, // Purple
        unselectedItemColor: Colors.white70,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w300),
      );

  // FAB Theme
  static final FloatingActionButtonThemeData floatingActionButtonTheme =
      FloatingActionButtonThemeData(
        backgroundColor: primaryColor, // Purple for FAB
        foregroundColor: backgroundColor,
        elevation: 8,
      );

  // Final ThemeData
  static ThemeData themeData = ThemeData(
    brightness: Brightness.dark,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundColor,
    textTheme: const TextTheme(
      displayLarge: displayLarge,
      displayMedium: displayMedium,
      bodyLarge: bodyLarge,
      bodyMedium: bodyMedium,
      bodySmall: caption,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(style: buttonStyle),
    textButtonTheme: TextButtonThemeData(style: textButtonStyle),
    outlinedButtonTheme: OutlinedButtonThemeData(style: outlinedButtonStyle),
    inputDecorationTheme: inputDecorationTheme,
    appBarTheme: appBarTheme,
    bottomNavigationBarTheme: bottomNavigationBarTheme,
    floatingActionButtonTheme: floatingActionButtonTheme,
    iconTheme: const IconThemeData(color: accentColor),
    dividerColor: dividerColor,
    useMaterial3: true,
  );
}
