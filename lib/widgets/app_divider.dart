import 'package:flutter/material.dart';
import 'package:mirai_crm/utils/responsive.dart';
import 'package:mirai_crm/utils/common_colors.dart';

class AppDivider extends StatelessWidget {
  final double? indent;
  final double? endIndent;
  final Color? color;
  final double thickness;

  const AppDivider({
    super.key,
    this.indent,
    this.endIndent,
    this.color,
    this.thickness = 1,
  });

  @override
  Widget build(BuildContext context) {
    RS.init(context);
    return Divider(
      color: color ?? CommonColors.borderSubtle,
      indent: indent ?? RS.HS(10),
      endIndent: endIndent ?? RS.HS(10),
      thickness: thickness,
      height: thickness,
    );
  }
}

class AppVerticalDivider extends StatelessWidget {
  final double? indent;
  final double? endIndent;
  final Color? color;
  final double thickness;

  const AppVerticalDivider({
    super.key,
    this.indent,
    this.endIndent,
    this.color,
    this.thickness = 1,
  });

  @override
  Widget build(BuildContext context) {
    RS.init(context);
    return VerticalDivider(
      color: color ?? CommonColors.borderSubtle,
      indent: indent,
      endIndent: endIndent,
      thickness: thickness,
      width: thickness,
    );
  }
}
