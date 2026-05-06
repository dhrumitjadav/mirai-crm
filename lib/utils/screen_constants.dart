import 'package:flutter/material.dart';

Size? screenSize;
double defaultScreenWidth = 380.0;
double defaultScreenHeight = 800.0;
double screenWidth = defaultScreenWidth;
double screenHeight = defaultScreenHeight;

class ScreenConstant {
  static double size0 = 0.0;
  static double size1 = 1.0;
  static double size2 = 2.0;
  static double size4 = 4.0;
  static double size5 = 5.0;
  static double size6 = 6.0;
  static double size8 = 8.0;
  static double size10 = 10;
  static double size12 = 12;
  static double size14 = 14;
  static double size16 = 16;
  static double size18 = 18;
  static double size20 = 20;
  static double size24 = 24;
  static double size28 = 28;
  static double size30 = 30;
  static double size32 = 32;
  static double size36 = 36;
  static double size40 = 40;
  static double size44 = 44;
  static double size48 = 48;
  static double size50 = 50;
  static double size56 = 56;
  static double size60 = 60;
  static double size70 = 70;
  static double size80 = 80;
  static double size100 = 100;
  static double size120 = 120;
  static double size150 = 150;
  static double size200 = 200;
  static double size250 = 250;
  static double size300 = 300;

  static double screenWidthHalf = screenWidth / 2;
  static double screenWidthThird = screenWidth / 3;
  static double screenWidthFourth = screenWidth / 4;
  static double screenWidthFifth = screenWidth / 5;

  static double screenHeightHalf = screenHeight / 2;
  static double screenHeightThird = screenHeight / 3;
  static double screenHeightFourth = screenHeight / 4;
  static double screenHeightFifth = screenHeight / 5;

  static double defaultIconSize = 80.0;
  static double snackBarHeight = 50.0;

  static EdgeInsets spacingAllZero = const EdgeInsets.all(0);
  static EdgeInsets spacingAllSmall = EdgeInsets.all(size10);
  static EdgeInsets spacingAllMedium = EdgeInsets.all(size16);
  static EdgeInsets spacingAllLarge = EdgeInsets.all(size20);

  static void setScreenAwareConstant(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    screenWidth = screenSize?.width ?? defaultScreenWidth;
    screenHeight = screenSize?.height ?? defaultScreenHeight;

    screenWidthHalf = screenWidth / 2;
    screenWidthThird = screenWidth / 3;
    screenWidthFourth = screenWidth / 4;
    screenWidthFifth = screenWidth / 5;

    screenHeightHalf = screenHeight / 2;
    screenHeightThird = screenHeight / 3;
    screenHeightFourth = screenHeight / 4;
    screenHeightFifth = screenHeight / 5;

    FontSize.setDefaultFontSize();
  }
}

class FontSize {
  static double s10 = 10.0;
  static double s11 = 11.0;
  static double s12 = 12.0;
  static double s13 = 13.0;
  static double s14 = 14.0;
  static double s15 = 15.0;
  static double s16 = 16.0;
  static double s17 = 17.0;
  static double s18 = 18.0;
  static double s20 = 20.0;
  static double s22 = 22.0;
  static double s24 = 24.0;
  static double s26 = 26.0;
  static double s28 = 28.0;
  static double s30 = 30.0;
  static double s34 = 34.0;
  static double s36 = 36.0;
  static double s40 = 40.0;

  static setDefaultFontSize() {
    s10 = 10.0;
    s12 = 12.0;
    s14 = 14.0;
    s16 = 16.0;
    s18 = 18.0;
    s20 = 20.0;
    s22 = 22.0;
    s24 = 24.0;
    s26 = 26.0;
    s28 = 28.0;
    s30 = 30.0;
    s34 = 34.0;
    s36 = 36.0;
    s40 = 40.0;
  }
}
