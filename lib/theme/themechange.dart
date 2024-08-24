// ignore_for_file: duplicate_import

import 'package:flutter/material.dart';
import 'package:habittrackerapp/theme/Colors.dart';


class AppThemes {
  static final lightTheme = ThemeData(
    primarySwatch:Colors.teal,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.kBackgroundColor,
      titleTextStyle: TextStyle(color: Colors.white),
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: AppColors.kFormLabelColor),
      bodyMedium: TextStyle(color: AppColors.kFormLabelColor),
    ),
    // Add more theme properties here
  );

  static final darkTheme = ThemeData(
    primarySwatch:  Colors.blueGrey,
    scaffoldBackgroundColor: Colors.white70,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.blueGrey,
      titleTextStyle: TextStyle(color: Colors.white),
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white70),
    ),
   
  );
}
