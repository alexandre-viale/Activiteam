import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'theme.dart';

TextTheme textTheme = GoogleFonts.nunitoTextTheme(
  TextTheme(
    displayLarge: const TextStyle(
      fontSize: 96,
      fontWeight: FontWeight.w300,
      color: Colors.black,
    ),
    displayMedium: const TextStyle(
      fontSize: 60,
      fontWeight: FontWeight.w400,
      color: primaryColor,
    ),
    displaySmall: TextStyle(
      fontSize: 48,
      fontWeight: FontWeight.w500,
      color: Colors.grey[800],
    ),
    headlineLarge: const TextStyle(
      fontSize: 48,
      fontWeight: FontWeight.w600,
      color: primaryColor,
    ),
    headlineMedium: const TextStyle(
      fontSize: 34,
      fontWeight: FontWeight.w600,
      color: primaryColor,
    ),
    headlineSmall: const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w700,
      color: Colors.black,
    ),
    titleLarge: const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w800,
      color: primaryColor,
    ),
    titleMedium: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      color: Colors.black,
    ),
    titleSmall: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      color: Colors.black,
    ),
    bodyLarge: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.normal,
      color: Colors.black,
    ),
    bodyMedium: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.normal,
      color: Colors.black,
    ),
    labelLarge: const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: secondaryColor,
    ),
    bodySmall: const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w300,
      color: Colors.black,
    ),
    labelSmall: const TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.w400,
      color: Colors.black,
    ),
  ),
);
