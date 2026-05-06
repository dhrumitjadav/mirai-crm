import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mirai_crm/utils/common_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: CommonColors.scaffoldBgColor,
    fontFamily: 'Lexend',
    colorScheme: ColorScheme.fromSeed(
      seedColor: CommonColors.primaryColor,
      brightness: Brightness.light,
    ),

    visualDensity: VisualDensity.adaptivePlatformDensity,

    appBarTheme: const AppBarTheme(
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: CommonColors.scaffoldBgColor,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: CommonColors.scaffoldBgColor,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: CommonColors.primaryColor,
      brightness: Brightness.dark,
    ),
  );
}
