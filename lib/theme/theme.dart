import 'package:chess_timer/theme/colors.dart';
import 'package:chess_timer/theme/dimensions.dart';
import 'package:flutter/material.dart';

class ChessTimerTheme {
  static final themeData = ThemeData(
    primaryColor: Palette.primaryColor,
    accentColor: Palette.primaryColor,
    scaffoldBackgroundColor: Palette.backgroundColor,
    buttonTheme: ButtonThemeData(
        buttonColor: Palette.primaryColor,
        textTheme: ButtonTextTheme.primary,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimensions.borderRadius))),
    cardTheme: CardTheme(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimensions.borderRadius))),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}
