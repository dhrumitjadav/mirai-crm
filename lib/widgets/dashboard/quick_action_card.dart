import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mirai_crm/utils/app_size.dart';
import 'package:mirai_crm/utils/common_colors.dart';

class QuickActionCard extends StatelessWidget {
  final String label;
  final String subtitle;
  final String svgIcon;
  final Color color;
  final VoidCallback onTap;

  const QuickActionCard({
    super.key,
    required this.label,
    required this.subtitle,
    required this.svgIcon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: context.h(60),
        padding: EdgeInsets.symmetric(
          horizontal: context.w(12),
          vertical: context.h(10),
        ),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.07),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: color.withValues(alpha: 0.35), width: 1.5),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              svgIcon,
              width: context.w(20),
              height: context.w(20),
              colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
            ),
            SizedBox(width: context.w(6)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    label,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: context.s(13),
                      height: 1,
                      fontWeight: FontWeight.w600,
                      color: CommonColors.blackColor,
                    ),
                  ),
                  SizedBox(height: context.w(5)),
                  Text(
                    subtitle,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: context.s(11),
                      height: 1,
                      fontWeight: FontWeight.w400,
                      color: CommonColors.hintColor,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, size: context.w(14), color: color),
          ],
        ),
      ),
    );
  }
}
