import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mirai_crm/utils/app_size.dart';
import 'package:mirai_crm/utils/common_colors.dart';
import 'package:mirai_crm/utils/common_img.dart';

class LeadData {
  final String initials;
  final String name;
  final String time;
  final String agent;
  final String status;
  final Color color;

  const LeadData({
    required this.initials,
    required this.name,
    required this.time,
    required this.agent,
    required this.status,
    required this.color,
  });
}

class LeadCard extends StatelessWidget {
  final LeadData lead;

  const LeadCard({super.key, required this.lead});

  Color get _statusColor {
    switch (lead.status) {
      case 'NEW':
        return CommonColors.primaryColor;
      case 'CONVERTED':
        return CommonColors.appGreenColor;
      default:
        return CommonColors.grey3B4A5E;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.w(14),
        vertical: context.h(12),
      ),
      child: Row(
        children: [
          Container(
            width: context.w(40),
            height: context.h(40),
            decoration: BoxDecoration(
              color: lead.color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: Text(
              lead.initials,
              style: TextStyle(
                fontSize: context.s(14),
                fontWeight: FontWeight.w600,
                height: 1,
                color: lead.color,
              ),
            ),
          ),
          SizedBox(width: context.w(12)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  lead.name,
                  style: TextStyle(
                    fontSize: context.s(14),
                    fontWeight: FontWeight.w700,
                    height: 1,
                    color: CommonColors.blackColor,
                  ),
                ),
                SizedBox(height: context.h(2)),
                Row(
                  children: [
                    Text(
                      lead.time,
                      style: TextStyle(
                        fontSize: context.s(12),
                        color: CommonColors.greyAEAEAE,
                      ),
                    ),
                    SizedBox(width: context.w(16)),
                    SvgPicture.asset(
                      CommonImg.crmPersonOutlined,
                      height: context.h(12),
                      colorFilter: ColorFilter.mode(
                        CommonColors.blackColor,
                        BlendMode.srcIn,
                      ),
                    ),
                    SizedBox(width: context.w(2)),
                    Text(
                      lead.agent,
                      style: TextStyle(
                        fontSize: context.s(12),
                        fontWeight: FontWeight.w500,
                        color: CommonColors.txtPrimary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: context.w(8),
              vertical: context.h(4),
            ),
            decoration: BoxDecoration(
              color: _statusColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              lead.status,
              style: TextStyle(
                fontSize: context.s(10),
                fontWeight: FontWeight.w700,
                color: _statusColor,
              ),
            ),
          ),
          SizedBox(width: context.w(6)),
          SvgPicture.asset(
            CommonImg.crmArrowRightFilled,
            height: context.h(18),
            colorFilter: ColorFilter.mode(
              CommonColors.greyAEAEAE,
              BlendMode.srcIn,
            ),
          ),
        ],
      ),
    );
  }
}
