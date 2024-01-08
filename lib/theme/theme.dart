import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:tp2_dev_mobile/theme/text_theme.dart';

const Color primaryColor = Color(0xFF153854);
const Color secondaryColor = Color.fromRGBO(255, 255, 255, 1);
BorderRadius borderRadius = BorderRadius.circular(15);
ThemeData appTheme() {
  return ThemeData(
    cardTheme: const CardTheme(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        disabledForegroundColor: Colors.white,
        disabledBackgroundColor: primaryColor.withOpacity(0.8),
        backgroundColor: primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius,
        ),
      ),
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: primaryColor,
    ),
    primaryColor: primaryColor,
    secondaryHeaderColor: secondaryColor,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 2,
      iconTheme: const IconThemeData(
        color: primaryColor,
      ),
      centerTitle: true,
      shadowColor: Colors.grey[50],
      titleTextStyle: TextStyle(
        color: primaryColor,
        fontWeight: FontWeight.bold,
        fontSize: 24,
        fontFamily: GoogleFonts.nunito().fontFamily,
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primaryColor,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    ),
    disabledColor: Colors.grey[300],
    fontFamily: GoogleFonts.nunito().fontFamily,
    scaffoldBackgroundColor: Colors.white,
    iconTheme: const IconThemeData(
      color: primaryColor,
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius,
      ),
    ),
    textTheme: textTheme,
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primaryColor,
        padding: const EdgeInsets.all(10),
        textStyle: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius,
        ),
        backgroundColor: primaryColor.withOpacity(0.05),
      ),
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: primaryColor,
    ),
    scrollbarTheme: ScrollbarThemeData(
      thumbColor: MaterialStateProperty.all(primaryColor.withOpacity(1)),
      radius: const Radius.circular(10),
    ),
    listTileTheme: const ListTileThemeData(
      tileColor: Colors.white,
      iconColor: primaryColor,
    ),
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      actionTextColor: Colors.white,
      showCloseIcon: true,
      behavior: SnackBarBehavior.floating,
      closeIconColor: Colors.white,
      contentTextStyle: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
