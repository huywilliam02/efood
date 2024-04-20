import 'package:flutter/material.dart';

ThemeData dark = ThemeData(
  fontFamily: 'Roboto',
  primaryColor: const Color(0xFFFF6F70),
  secondaryHeaderColor: const Color(0xFF00AA6D),
  disabledColor: const Color(0xffa2a7ad),
  brightness: Brightness.dark,
  hintColor: const Color(0xFFbebebe),
  cardColor: Colors.black,
  textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(foregroundColor: const Color(
      0xffe2e2e2))), colorScheme: const ColorScheme.dark(primary: Color(0xff5d9df8), secondary: Color(
      0xff6ca6f8), tertiary: Color(0xFFF4F6FA)).copyWith(background: const Color(0xFF343636)).copyWith(error: const Color(0xFFdd3135)),
);
