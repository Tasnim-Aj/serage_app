import 'package:flutter/material.dart';

class AppThemes {
  static final ThemeData lightTheme = ThemeData(
    primaryColor: Colors.blue,
    colorScheme: ColorScheme.light(
      primary: Colors.blue,
      secondary: Colors.green,
    ),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      color: Colors.blue,
      iconTheme: IconThemeData(color: Colors.white),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    primaryColor: Colors.indigo,
    colorScheme: ColorScheme.dark(
      primary: Colors.indigo,
      secondary: Colors.purple,
    ),
    scaffoldBackgroundColor: Colors.grey[900],
    appBarTheme: AppBarTheme(
      color: Colors.indigo,
      iconTheme: IconThemeData(color: Colors.white),
    ),
  );
}
