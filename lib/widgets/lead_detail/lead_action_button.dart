import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mirai_crm/utils/responsive.dart';
import 'package:mirai_crm/utils/common_colors.dart';

class LeadActionButton extends StatelessWidget {
  final String svgPath;
  final Color color;

  const LeadActionButton({super.key, required this.svgPath, required this.color});

  @override
  Widget build(BuildContext context) {
    RS.init(context);
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: RS.VS(52),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: SvgPicture.asset(
            svgPath,
            width: RS.HS(24),
            height: RS.HS(24),
            colorFilter: const ColorFilter.mode(
              CommonColors.whiteColor,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }
}
