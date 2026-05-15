import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mirai_crm/utils/responsive.dart';
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
    RS.init(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: RS.HS(14), vertical: RS.VS(12)),
      child: Row(
        children: [
          Container(
            width: RS.HS(40),
            height: RS.VS(40),
            decoration: BoxDecoration(
              color: CommonColors.red50,
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: Text(
              lead.initials,
              style: TextStyle(
                fontSize: RS.FS(14),
                fontWeight: FontWeight.w600,
                height: 1,
                color: CommonColors.red600,
              ),
            ),
          ),
          SizedBox(width: RS.HS(12)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  lead.name,
                  style: TextStyle(
                    fontSize: RS.FS(14),
                    fontWeight: FontWeight.w700,
                    height: 1,
                    color: CommonColors.textPrimary,
                  ),
                ),
                SizedBox(height: RS.VS(2)),
                Row(
                  children: [
                    Text(
                      lead.time,
                      style: TextStyle(
                        fontSize: RS.FS(12),
                        color: CommonColors.textSecondary,
                      ),
                    ),
                    SizedBox(width: RS.HS(16)),
                    SvgPicture.asset(
                      CommonImg.crmPersonOutlined,
                      height: RS.VS(12),
                      colorFilter: ColorFilter.mode(
                        CommonColors.blackColor,
                        BlendMode.srcIn,
                      ),
                    ),
                    SizedBox(width: RS.HS(2)),
                    Text(
                      lead.agent,
                      style: TextStyle(
                        fontSize: RS.FS(12),
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
              horizontal: RS.HS(8),
              vertical: RS.VS(4),
            ),
            decoration: BoxDecoration(
              color: _statusBgColor,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              lead.status,
              style: TextStyle(
                fontSize: RS.FS(10),
                fontWeight: FontWeight.w700,
                color: _statusColor,
              ),
            ),
          ),
          SizedBox(width: RS.HS(6)),
          SvgPicture.asset(
            CommonImg.crmArrowRightOutlined,
            height: RS.VS(18),
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
