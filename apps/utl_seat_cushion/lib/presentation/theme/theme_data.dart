import 'package:flutter/material.dart';

extension CustomTheme on ThemeData {
  Color get screenBackgroundColor => brightness == Brightness.light
      ? Colors.white
      : Colors.black;
  Color get seatCushionUnitBorderColor => brightness == Brightness.light
      ? Colors.black
      : Colors.white;
  Color get ischiumPointBorderColor => brightness == Brightness.light
      ? Colors.black
      : Colors.white;
  Color get ischiumPointFilledColor => brightness == Brightness.light
      ? Colors.pinkAccent
      : Colors.pinkAccent;
  Color get downloadIconColor => brightness == Brightness.light
      ? Colors.green
      : Colors.green[700]!;
  Color get saveIconColor => brightness == Brightness.light
      ? Colors.orange
      : Colors.orange[700]!;
  Color get clearOldDataButtonIconColor => brightness == Brightness.light
      ? Colors.red
      : Colors.red[900]!;
}
