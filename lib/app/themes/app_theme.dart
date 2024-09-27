import 'package:flutter/material.dart';
import 'package:liquor_ordering_system/app/constants/theme_constant.dart';

class AppTheme {
  AppTheme._();

  static getApplicationTheme(bool isDark) {
    return ThemeData(
      // change the theme according to the user preference
      colorScheme: isDark
          ? const ColorScheme.dark(
              primary: ThemeConstant.primaryColor,
            )
          : const ColorScheme.light(
              primary: ThemeConstant.primaryColor,
            ),
      // change elevated button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
        elevation: 0,
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xFFD29062),
        textStyle: const TextStyle(
          fontSize: 16,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      )),

      //change text field theme
      inputDecorationTheme: const InputDecorationTheme(
        contentPadding: EdgeInsets.all(10),
        border: OutlineInputBorder(),
        labelStyle: TextStyle(
          fontSize: 20,
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: ThemeConstant.primaryColor,
          ),
        ),
      ),

      //circular progress indicator theme
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: ThemeConstant.primaryColor,
      ),
    );
  }
}
