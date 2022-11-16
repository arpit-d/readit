import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'custom_colors.dart';

class CustomTheme {
  static ThemeData get lightTheme {
    return ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primaryColor: CustomColors.primary,
        scaffoldBackgroundColor: Colors.white,
        textTheme: GoogleFonts.montserratTextTheme(),
        scrollbarTheme: ScrollbarThemeData(
          thumbVisibility: MaterialStateProperty.all(true),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            textStyle: TextStyle(fontWeight: FontWeight.bold),
            backgroundColor: CustomColors.primary,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0)),
          ),
        ),
        buttonTheme: ButtonThemeData(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
          buttonColor: CustomColors.primary,
        ));
  }
}
