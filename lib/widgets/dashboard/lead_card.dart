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

  const LeadData({
    required this.initials,
    required this.name,
    required this.time,
    required this.agent,
    required this.status,
  });
}

class LeadCard extends StatelessWidget {
  final LeadData lead;

  const LeadCard({super.key, required this.lead});

  Color get _statusColor {
    switch (lead.status) {
      case 'NEW':
        return CommonColors.info700;
      case 'CONVERTED':
        return CommonColors.green600;
      default:
        return CommonColors.grey650;
    }
  }

  Color get _statusBgColor {
    switch (lead.status) {
      case 'NEW':
        return CommonColors.info50;
      case 'CONVERTED':
        return CommonColors.green50;
      default:
        return CommonColors.grey75;
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
              color: CommonColors.red50,
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: Text(
              lead.initials,
              style: TextStyle(
                fontSize: context.s(14),
                fontWeight: FontWeight.w600,
                height: 1,
                color: CommonColors.red600,
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
                    color: CommonColors.textPrimary,
                  ),
                ),
                SizedBox(height: context.h(2)),
                Row(
                  children: [
                    Text(
                      lead.time,
                      style: TextStyle(
                        fontSize: context.s(12),
                        color: CommonColors.textSecondary,
                      ),
                    ),
                    SizedBox(width: context.w(16)),
                    SvgPicture.asset(
                      CommonImg.crmBookmarkOutlined,
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
                        color: CommonColors.textPrimary,
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
              color: _statusBgColor,
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
            CommonImg.crmArrowRightOutlined,
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
