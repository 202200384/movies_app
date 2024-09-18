import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movies_app/Ui/Utils/app_colors.dart';

class MyThemeData {
  static final ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.whiteColorText,
    scaffoldBackgroundColor: AppColors.backgroundColor,
    textTheme: TextTheme(
      bodyLarge: GoogleFonts.poppins(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: AppColors.whiteColorText),
      bodyMedium: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.w400,
          color: AppColors.whiteColorText),
      bodySmall: GoogleFonts.poppins(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: AppColors.whiteColorText),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(
          color: AppColors.buttonNavigationBarColor,
          width: 2,
        ),
      ),
    ),
  );
}