import 'package:flutter/material.dart';

ThemeData light = ThemeData(
  fontFamily: 'Roboto',
  primaryColor: const Color(0xFFFF6F70),
  secondaryHeaderColor: const Color(0xFF00AA6D),
  disabledColor: const Color(0xFFBABFC4),
  brightness: Brightness.light,
  highlightColor: const Color(0xFFF4F6FA),
  hintColor: const Color(0xFF9F9F9F),
  cardColor: Colors.white,
  textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(foregroundColor: const Color(
      0xff1c1c1c))), colorScheme: const ColorScheme.light(primary: Color(0xff5d9df8), secondary: Color(
      0xff6ca6f8), tertiary: Color(0xFFF4F6FA)).copyWith(background: const Color(0xFFF3F3F3)).copyWith(error: const Color(0xFFE84D4F)),

);