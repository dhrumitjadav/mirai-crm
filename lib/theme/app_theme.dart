import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mirai_crm/utils/common_colors.dart';

class AppTheme {
  static TextTheme _withLetterSpacing(TextTheme base) {
    const ls = -0.3;
    return base.copyWith(
      displayLarge: base.displayLarge?.copyWith(letterSpacing: ls),
      displayMedium: base.displayMedium?.copyWith(letterSpacing: ls),
      displaySmall: base.displaySmall?.copyWith(letterSpacing: ls),
      headlineLarge: base.headlineLarge?.copyWith(letterSpacing: ls),
      headlineMedium: base.headlineMedium?.copyWith(letterSpacing: ls),
      headlineSmall: base.headlineSmall?.copyWith(letterSpacing: ls),
      titleLarge: base.titleLarge?.copyWith(letterSpacing: ls),
      titleMedium: base.titleMedium?.copyWith(letterSpacing: ls),
      titleSmall: base.titleSmall?.copyWith(letterSpacing: ls),
      bodyLarge: base.bodyLarge?.copyWith(letterSpacing: ls),
      bodyMedium: base.bodyMedium?.copyWith(letterSpacing: ls),
      bodySmall: base.bodySmall?.copyWith(letterSpacing: ls),
      labelLarge: base.labelLarge?.copyWith(letterSpacing: ls),
      labelMedium: base.labelMedium?.copyWith(letterSpacing: ls),
      labelSmall: base.labelSmall?.copyWith(letterSpacing: ls),
    );
  }

  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: CommonColors.scaffoldBgColor,
    fontFamily: 'DMSans',
    textTheme: _withLetterSpacing(ThemeData.light().textTheme),
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
