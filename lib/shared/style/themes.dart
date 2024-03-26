import 'package:chat_gpt_task/shared/style/color.dart';
import 'package:chat_gpt_task/shared/style/enum/enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

final getThemeData = {
  AppTheme.darkTheme: ThemeData(
    scaffoldBackgroundColor: AppMainColors.secondColor,
    primarySwatch: Colors.green,
    appBarTheme: AppBarTheme(
      titleSpacing: 20.0,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      backgroundColor: AppMainColors.secondColor,
      elevation: 1,
      titleTextStyle: GoogleFonts.raleway(
        color: AppMainColors.whiteColor,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: const IconThemeData(
        color: AppMainColors.whiteColor,
        size: 24,
      ),
      actionsIconTheme: const IconThemeData(
        color: AppMainColors.whiteColor,
        size: 24,
      ),
    ),
    textTheme: TextTheme(
      titleLarge: GoogleFonts.raleway(
        color: AppMainColors.whiteColor,
        fontSize: 18,
        fontWeight: FontWeight.w700,
      ),
      titleMedium: GoogleFonts.raleway(
        fontSize: 16,
        color: AppMainColors.whiteColor,
        fontWeight: FontWeight.w700,
      ),
      labelLarge: GoogleFonts.raleway(
        color: AppMainColors.whiteColor,
        fontSize: 24,
        fontWeight: FontWeight.w700,
      ),
      labelSmall: GoogleFonts.raleway(
        color: AppMainColors.whiteColor,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
      bodyMedium: GoogleFonts.raleway(
        color: AppMainColors.whiteColor,
        fontWeight: FontWeight.w500,
      ),
      bodySmall: GoogleFonts.raleway(
          color: AppMainColors.whiteColor,
          fontWeight: FontWeight.w600,
          fontSize: 12),
      displayLarge: GoogleFonts.raleway(
        color: AppMainColors.whiteColor,
      ),
      displayMedium: GoogleFonts.raleway(
        color: AppMainColors.whiteColor,
      ),
      displaySmall: GoogleFonts.raleway(
        color: AppMainColors.whiteColor,
        fontWeight: FontWeight.bold,
        fontSize: 40,
      ),
      headlineMedium: GoogleFonts.raleway(
        color: AppMainColors.whiteColor,
      ),
      headlineSmall: GoogleFonts.raleway(
        color: AppMainColors.whiteColor,
        fontSize: 32,
        fontWeight: FontWeight.w700,
      ),
      bodyLarge: GoogleFonts.raleway(
        color: AppMainColors.whiteColor,
      ),
    ),
  ),
  AppTheme.lightTheme: ThemeData(
    scaffoldBackgroundColor: AppMainColors.whiteColor,
    primarySwatch: Colors.green,
    appBarTheme: AppBarTheme(
      titleSpacing: 20.0,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      backgroundColor: AppMainColors.whiteColor,
      elevation: 1,
      titleTextStyle: GoogleFonts.raleway(
        color: AppMainColors.darkColor,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: const IconThemeData(
        color: AppMainColors.darkColor,
        size: 24,
      ),
      actionsIconTheme: const IconThemeData(
        color: AppMainColors.darkColor,
        size: 24,
      ),
    ),
    textTheme: TextTheme(
      titleLarge: GoogleFonts.raleway(
        color: AppMainColors.darkColor,
        fontSize: 18,
        fontWeight: FontWeight.w700,
      ),
      titleMedium: GoogleFonts.raleway(
        fontSize: 16,
        color: AppMainColors.darkColor,
        fontWeight: FontWeight.w700,
      ),
      labelLarge: GoogleFonts.raleway(
        color: AppMainColors.darkColor,
        fontSize: 24,
        fontWeight: FontWeight.w700,
      ),
      labelSmall: GoogleFonts.raleway(
        color: AppMainColors.darkColor,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
      bodyMedium: GoogleFonts.raleway(
        color: AppMainColors.darkColor,
        fontWeight: FontWeight.w500,
      ),
      bodySmall: GoogleFonts.raleway(
          color: AppMainColors.darkColor,
          fontWeight: FontWeight.w600,
          fontSize: 12),
      displayLarge: GoogleFonts.raleway(
        color: AppMainColors.darkColor,
      ),
      displayMedium: GoogleFonts.raleway(
        color: AppMainColors.darkColor,
      ),
      displaySmall: GoogleFonts.raleway(
        color: AppMainColors.darkColor,
        fontWeight: FontWeight.bold,
        fontSize: 40,
      ),
      headlineMedium: GoogleFonts.raleway(
        color: AppMainColors.darkColor,
      ),
      headlineSmall: GoogleFonts.raleway(
        color: AppMainColors.darkColor,
        fontSize: 32,
        fontWeight: FontWeight.w700,
      ),
      bodyLarge: GoogleFonts.raleway(
        color: AppMainColors.darkColor,
      ),
    ),
  ),
};
