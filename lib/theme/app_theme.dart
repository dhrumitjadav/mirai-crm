import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mirai_crm/utils/common_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: CommonColors.scaffoldBgColor,
    fontFamily: 'DMSans',
    colorScheme: ColorScheme.fromSeed(
      seedColor: CommonColors.primaryColor,
      brightness: Brightness.light,
    ),

    visualDensity: VisualDensity.adaptivePlatformDensity,

    appBarTheme: const AppBarTheme(
      backgroundColor: CommonColors.whiteColor,
      surfaceTintColor: Colors.transparent,
      elevation: 1,
      systemOverlayStyle: SystemUiOverlayStyle(
        // statusBarColor: CommonColors.scaffoldBgColor,
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
