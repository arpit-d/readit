import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'custom_colors.dart';

class CustomTheme {
  static ThemeData get lightTheme {
    return ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primaryColor: CustomColors.primary,
        scaffoldBackgroundColor: Color(0xFFE5E5E5),
        textTheme: GoogleFonts.ibmPlexSansTextTheme(),
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
        appBarTheme: AppBarTheme(
            color: Colors.white,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.black)),
        buttonTheme: ButtonThemeData(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
          buttonColor: CustomColors.primary,
        ));
  }
}
