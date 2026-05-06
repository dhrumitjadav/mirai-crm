import 'package:flutter/material.dart';

// Base design dimensions (standard design frame)
const double _designWidth = 375.0;
const double _designHeight = 812.0;

extension AppSize on BuildContext {
  /// Scale a width/horizontal value relative to design width
  double w(double size) => size * MediaQuery.of(this).size.width / _designWidth;

  /// Scale a height/vertical value relative to design height
  double h(double size) =>
      size * MediaQuery.of(this).size.height / _designHeight;

  /// Scale font size relative to design width
  double s(double size) => size * MediaQuery.of(this).size.width / _designWidth;

  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;
}
