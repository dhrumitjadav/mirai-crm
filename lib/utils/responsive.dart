// ignore_for_file: non_constant_identifier_names

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

typedef RS = Responsive;

class Responsive {
  static MediaQueryData? _mediaQueryData;
  static double? sw;
  static double? sh;

  static void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    sw = _mediaQueryData!.size.width;
    sh = _mediaQueryData!.size.height;
  }

  /// Convert width percentage to pixels
  static double widthPx(double widthPercent) {
    if (sw == null) return widthPercent;
    return (sw! * widthPercent) / 100;
  }

  /// Convert height percentage to pixels
  static double heightPx(double heightPercent) {
    if (sh == null) return heightPercent;
    return ((sh! - getStatusBarHeight()) * heightPercent) / 100;
  }

  /// Font scaling based on screen width
  static double font(double size) {
    if (sw == null) return size;
    return (sw! * size) / 100;
  }

  /// Get status bar height
  static double getStatusBarHeight() {
    if (_mediaQueryData == null) return 0;
    return _mediaQueryData!.padding.top;
  }

  /// Check if device is iPhone X or newer (notch)
  static bool isIPhoneX() {
    if (kIsWeb || !Platform.isIOS || _mediaQueryData == null) return false;
    final double height = _mediaQueryData!.size.height;
    final double width = _mediaQueryData!.size.width;
    return [780, 812, 844, 896, 926].contains(height.round()) ||
        [780, 812, 844, 896, 926].contains(width.round());
  }

  /// Get bottom padding for safe area
  static double getBottomPadding() {
    if (_mediaQueryData == null) return 0;
    return _mediaQueryData!.padding.bottom;
  }

  /// Check if device is a tablet
  static bool isTablet() {
    if (_mediaQueryData == null) return false;
    return _mediaQueryData!.size.shortestSide >= 600;
  }

  // ── Scaling from baseline 375x812 (iPhone 11) ──

  static const double _guidelineBaseWidth = 375;
  static const double _guidelineBaseHeight = 812;

  /// Horizontal Scale - scales size proportionally to screen width
  static double HS(double size) {
    if (sw == null) return size;
    return (sw! / _guidelineBaseWidth) * size;
  }

  /// Vertical Scale - scales size proportionally to screen height
  static double VS(double size) {
    if (sh == null) return size;
    return (sh! / _guidelineBaseHeight) * size;
  }

  /// Moderate Scale - blend between fixed and horizontal scale
  static double MS(double size, [double factor = 0.5]) {
    if (sw == null) return size;
    return size + (HS(size) - size) * factor;
  }

  /// Font Scale - moderate scale for text
  static double FS(double size, [double factor = 0.5]) {
    if (sw == null) return size;
    return size + (HS(size) - size) * factor;
  }
}
