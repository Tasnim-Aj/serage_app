import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class AppThemes {
  static final lightTheme = ThemeData(
      primaryColor: DawnColors.primary,
      // scaffoldBackgroundColor: DawnColors.dark,
      cardColor: DawnColors.dark,
      // iconTheme: IconThemeData(color: Colors.black),
      textTheme: TextTheme(
          titleLarge: TextStyle(
            fontSize: 30.sp,
            fontWeight: FontWeight.w400,
            height: 1.0,
            letterSpacing: 0,
            color: DawnColors.textColor,
          ),
          titleMedium: GoogleFonts.inter(
            fontWeight: FontWeight.w400,
            fontSize: 23.sp,
            height: 1,
            letterSpacing: 0.0,
            color: DawnColors.white,
          ),
          bodyLarge: GoogleFonts.inter(
            fontWeight: FontWeight.w400,
            fontSize: 25.sp,
            height: 1,
            letterSpacing: 0.0,
            color: DawnColors.black,
          ),
          bodyMedium: GoogleFonts.inter(
            fontWeight: FontWeight.w400,
            fontSize: 15.sp,
            height: 1,
            letterSpacing: 0.0,
            color: DawnColors.black,
          ),
          bodySmall: GoogleFonts.inter(
            fontWeight: FontWeight.w400,
            fontSize: 12.sp,
            height: 1,
            letterSpacing: 0.0,
            color: DawnColors.textColor2,
          ),
          displayLarge: GoogleFonts.inter(
            fontWeight: FontWeight.w400,
            fontSize: 20.sp,
            height: 1,
            letterSpacing: 0.0,
            color: DawnColors.textColor,
          )),
      buttonTheme: ButtonThemeData(
        buttonColor: DawnColors.primary,
      ));

  static final darkTheme = ThemeData(
      primaryColor: DuskColors.primary,
      // scaffoldBackgroundColor: Colors.grey[900],
      cardColor: DuskColors.dark,
      textTheme: TextTheme(
          titleLarge: TextStyle(
            fontSize: 30.sp,
            fontWeight: FontWeight.w400,
            height: 1.0,
            letterSpacing: 0,
            color: DuskColors.titleTextColor,
          ),
          titleMedium: GoogleFonts.inter(
            fontWeight: FontWeight.w400,
            fontSize: 23.sp,
            height: 1,
            letterSpacing: 0.0,
            color: DawnColors.white,
          ),
          bodyLarge: GoogleFonts.inter(
            fontWeight: FontWeight.w400,
            fontSize: 25.sp,
            height: 1,
            letterSpacing: 0.0,
            color: DuskColors.accent1,
          ),
          bodyMedium: GoogleFonts.inter(
            fontWeight: FontWeight.w400,
            fontSize: 15.sp,
            height: 1,
            letterSpacing: 0.0,
            color: DawnColors.black,
          ),
          bodySmall: GoogleFonts.inter(
            fontWeight: FontWeight.w400,
            fontSize: 12.sp,
            height: 1,
            letterSpacing: 0.0,
            color: DuskColors.accent2,
          ),
          displayLarge: GoogleFonts.inter(
            fontWeight: FontWeight.w400,
            fontSize: 20.sp,
            height: 1,
            letterSpacing: 0.0,
            color: DuskColors.textColor,
          )),
      buttonTheme: ButtonThemeData(
        buttonColor: DuskColors.primary,
      )
      // iconTheme: IconThemeData(color: Colors.white),
      // textTheme: TextTheme(
      //   bodyLarge: TextStyle(color: Colors.white),
      // ),
      );
}
