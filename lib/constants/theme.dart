import 'package:flutter/material.dart';

ThemeData themeData = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  primaryColor: const Color(0xFF2B3A67),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: const Color(0xFF00BFA6),
      textStyle: const TextStyle(color: Color(0xFF333333), fontFamily: 'Roboto'),

      side: const BorderSide(
        color: Color(0xFF2B3A67),
        width: 0.7,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // Set the border radius here
      ),
    ),
  ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w700),
      titleMedium: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w700),
      titleSmall: TextStyle(fontFamily: 'Roboto'),
      bodyLarge: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w400),
      bodyMedium: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w400),
      bodySmall: TextStyle(fontFamily: 'Roboto',fontWeight: FontWeight.w400),
      headlineLarge: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w500),
      headlineMedium: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.w500),
      headlineSmall: TextStyle(fontFamily: 'Roboto'),
    ),
  inputDecorationTheme: InputDecorationTheme(
    border: outlineInputBorder,
    errorBorder: outlineInputBorder,
    enabledBorder: outlineInputBorder,
    prefixIconColor: Colors.grey,
    suffixIconColor: Colors.grey,
    focusedBorder: outlineInputBorder,
    disabledBorder: outlineInputBorder,
  ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF00BFA6),
        textStyle: const TextStyle(fontSize: 18.0, color: Colors.white, fontFamily: 'Roboto'),
        disabledBackgroundColor: Colors.grey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0), // Set border radius to 10
        ),
      ),
    ),

    canvasColor: const Color(0xFFffffff),
  appBarTheme: const AppBarTheme(

    backgroundColor: Color(0xFF2B3A67),
    elevation: 0.0,
    toolbarTextStyle: TextStyle(color: Colors.white, fontFamily: 'Roboto', fontWeight: FontWeight.w700),
    iconTheme: IconThemeData(color: Colors.white),
  )
);
OutlineInputBorder outlineInputBorder = const OutlineInputBorder(
  borderSide: BorderSide(
  color: Colors.grey,
  )
);