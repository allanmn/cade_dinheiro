import 'package:cade_o_dinheiro/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static const colors = AppColors();

  const AppTheme._();

  static ThemeData define() {
    return ThemeData(
      primaryColor: colors.primary,
      fontFamily: 'Poppins',
      textTheme: const TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold)),
    );
  }
}
