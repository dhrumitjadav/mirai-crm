import 'package:flutter/material.dart';
import 'package:mirai_crm/utils/app_size.dart';
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
    return Divider(
      color: color ?? CommonColors.borderSubtle,
      indent: indent ?? context.w(10),
      endIndent: endIndent ?? context.w(10),
      thickness: thickness,
      height: thickness,
    );
  }
}
