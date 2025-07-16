import 'package:flutter/material.dart';

import 'app_colors.dart';

ThemeData dawnTheme = ThemeData(
  colorScheme: ColorScheme.light(
    primary: DawnColors.primary,
    background: Colors.transparent,
  ),
  scaffoldBackgroundColor: Colors.transparent,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      textStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: DawnColors.textColor,
      ),
      backgroundColor: DawnColors.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.black),
      ),
    ),
  ),
);
