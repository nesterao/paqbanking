import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../shared/shared.dart';

class Themes {
  final ThemeData lightTheme = ThemeData.light().copyWith(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    appBarTheme: const AppBarTheme(
      color: kLightPrimaryColor,
    ),
    primaryColorLight: kLightPrimaryColor,
    accentColor: kAccentColor,
    scaffoldBackgroundColor: kContentColorDarkTheme,
    textTheme: TextTheme(
      headline1: GoogleFonts.robotoCondensed(
        color: kLightPrimaryColor,
      ),
      headline2: GoogleFonts.roboto(
        fontWeight: FontWeight.w600,
        color: Colors.black54,
      ),
      headline5: GoogleFonts.roboto(
        color: Colors.black26,
        fontWeight: FontWeight.w500,
      ),
      headline6: GoogleFonts.roboto(
        color: kLightPrimaryColor,
        fontWeight: FontWeight.w500,
      ),
      caption: GoogleFonts.robotoCondensed(
        fontWeight: FontWeight.w500,
        color: kLightSecondaryColor,
      ),
      button: GoogleFonts.roboto(
        fontWeight: FontWeight.w600,
        color: Colors.black54,
      ),
    ),
    colorScheme: const ColorScheme.light(
      primary: kLightPrimaryColor,
      secondary: kLightTertiaryColor,
      surface: Colors.red,
      error: kErrorColor,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(6),
          ),
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        backgroundColor: kLightSecondaryColor,
        side: const BorderSide(
          color: kAccentColor,
          width: 2,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(6),
          ),
        ),
      ),
    ),
  );

  final ThemeData darkTheme = ThemeData.dark().copyWith(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    appBarTheme: const AppBarTheme(
      color: kDarkPrimaryColor,
    ),
    primaryColor: kDarkPrimaryColor,
    accentColor: kAccentColor,
    scaffoldBackgroundColor: kContentColorLightTheme,
    textTheme: TextTheme(
      headline1: GoogleFonts.robotoCondensed(
        color: kDarkTertiaryColor,
      ),
      headline2: GoogleFonts.roboto(
        fontWeight: FontWeight.w600,
        color: Colors.black54,
      ),
      headline5: GoogleFonts.roboto(
        color: kDarkTertiaryColor,
        fontWeight: FontWeight.w500,
      ),
      headline6: GoogleFonts.roboto(
        color: kDarkSecondaryColor,
        fontWeight: FontWeight.w500,
      ),
      caption: GoogleFonts.robotoCondensed(
        fontWeight: FontWeight.w500,
        color: kDarkTertiaryColor,
      ),
      button: GoogleFonts.roboto(
        fontWeight: FontWeight.w600,
        color: kAccentColor,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 5,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(6),
          ),
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        side: const BorderSide(
          color: kAccentColor,
          width: 2,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(6),
          ),
        ),
      ),
    ),
    colorScheme: const ColorScheme.dark(
      primary: kDarkPrimaryColor,
      secondary: kAccentColor,
      error: kErrorColor,
    ),
  );
}
