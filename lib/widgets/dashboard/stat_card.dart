import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mirai_crm/utils/app_size.dart';
import 'package:mirai_crm/utils/common_colors.dart';
import 'package:mirai_crm/utils/common_img.dart';

class StatCard extends StatelessWidget {
  final String label;
  final String value;
  final String change;
  final String changeLabel;
  final bool? isPositive;
  final String svgIcon;
  final Color iconColor;
  final Color iconBgColor;

  const StatCard({
    super.key,
    required this.label,
    required this.value,
    required this.change,
    required this.changeLabel,
    required this.isPositive,
    required this.svgIcon,
    required this.iconColor,
    required this.iconBgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.w(12)),
      decoration: BoxDecoration(
        color: CommonColors.whiteColor,
        border: Border.all(color: CommonColors.borderDefault),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: context.s(12),
                    color: CommonColors.textPrimary,
                    fontWeight: FontWeight.w500,
                    height: 1.2,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(context.w(5)),
                width: context.w(28),
                height: context.w(28),
                decoration: BoxDecoration(
                  color: iconBgColor,
                  borderRadius: BorderRadius.all(Radius.circular(context.w(4))),
                ),
                child: SvgPicture.asset(
                  svgIcon,
                  colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
                ),
              ),
            ],
          ),
          SizedBox(height: context.h(12)),
          Text(
            value,
            style: TextStyle(
              fontSize: context.s(22),
              fontWeight: FontWeight.w600,
              height: 1,
              color: CommonColors.textPrimary,
            ),
          ),
          SizedBox(height: context.h(4)),
          Row(
            children: [
              if (isPositive != null)
                SvgPicture.asset(
                  height: context.w(12),
                  isPositive!
                      ? CommonImg.crmTrendingUpOutlined
                      : CommonImg.crmTrendingDownOutlined,
                  colorFilter: ColorFilter.mode(
                    isPositive!
                        ? CommonColors.success500
                        : CommonColors.error500,
                    BlendMode.srcIn,
                  ),
                ),
              Text(
                ' $change ',
                style: TextStyle(
                  fontSize: context.s(11),
                  height: 1,
                  fontWeight: FontWeight.w400,
                  color: isPositive!
                      ? CommonColors.success500
                      : CommonColors.error500,
                ),
              ),
              Text(
                changeLabel,
                style: TextStyle(
                  fontSize: context.s(11),
                  height: 1,
                  fontWeight: FontWeight.w400,
                  color: CommonColors.textTertiary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
