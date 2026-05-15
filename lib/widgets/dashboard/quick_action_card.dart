import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mirai_crm/utils/responsive.dart';
import 'package:mirai_crm/utils/common_colors.dart';
import 'package:mirai_crm/utils/common_img.dart';

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
    RS.init(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: RS.VS(60),
        padding: EdgeInsets.symmetric(
          horizontal: RS.HS(12),
          vertical: RS.VS(10),
        ),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              svgIcon,
              width: RS.HS(20),
              height: RS.HS(20),
              colorFilter: ColorFilter.mode(
                CommonColors.whiteColor,
                BlendMode.srcIn,
              ),
            ),
            SizedBox(width: RS.HS(6)),
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
                      fontSize: RS.FS(13),
                      height: 1,
                      fontWeight: FontWeight.w600,
                      color: CommonColors.whiteColor,
                    ),
                  ),
                  SizedBox(height: RS.HS(5)),
                  Text(
                    subtitle,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: RS.FS(11),
                      height: 1,
                      fontWeight: FontWeight.w400,
                      color: CommonColors.whiteColor,
                    ),
                  ),
                ],
              ),
            ),
            SvgPicture.asset(
              CommonImg.crmArrowRightOutlined,
              width: RS.HS(20),
              height: RS.HS(20),
              colorFilter: ColorFilter.mode(
                CommonColors.whiteColor,
                BlendMode.srcIn,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
