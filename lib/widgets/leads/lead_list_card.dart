import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mirai_crm/utils/app_size.dart';
import 'package:mirai_crm/utils/common_colors.dart';
import 'package:mirai_crm/utils/common_img.dart';
import 'package:mirai_crm/widgets/app_divider.dart';

class LeadListItem {
  final String initials;
  final String name;
  final String time;
  final String assignedTo;
  final String source;
  final String priority;
  final String status;
  final bool isRecentlyAdded;

  const LeadListItem({
    required this.initials,
    required this.name,
    required this.time,
    required this.assignedTo,
    required this.source,
    required this.priority,
    required this.status,
    this.isRecentlyAdded = false,
  });
}

class LeadListCard extends StatelessWidget {
  final LeadListItem lead;

  const LeadListCard({super.key, required this.lead});

  Color get _priorityColor {
    switch (lead.priority.toLowerCase()) {
      case 'high':
        return CommonColors.appRedColor;
      case 'medium':
        return CommonColors.orangeColor;
      default:
        return CommonColors.appGreenColor;
    }
  }

  Color get _statusColor {
    switch (lead.status.toLowerCase()) {
      case 'new':
        return CommonColors.appGreenColor;
      case 'converted':
        return CommonColors.primaryColor;
      case 'pending':
        return CommonColors.orangeColor;
      default:
        return CommonColors.greyAEAEAE;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        if (lead.isRecentlyAdded)
          Positioned(
            top: -10,
            left: 0,
            child: Container(
              height: context.h(37),
              margin: EdgeInsets.only(top: 3),
              alignment: Alignment.topLeft,
              padding: EdgeInsets.fromLTRB(
                context.w(12),
                context.h(7),
                context.w(17),
                context.w(0),
              ),
              decoration: BoxDecoration(
                color: CommonColors.green600,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(context.w(6)),
                  topRight: Radius.circular(context.w(6)),
                ),
              ),
              child: Text(
                'Recently Added',
                style: TextStyle(
                  fontSize: context.s(10),
                  color: CommonColors.whiteColor,
                ),
              ),
            ),
          ),
        Container(
          margin: EdgeInsets.only(
            bottom: context.h(12),
            top: lead.isRecentlyAdded ? context.h(21) : 0,
          ),
          padding: EdgeInsets.all(context.h(24)),
          decoration: BoxDecoration(
            color: CommonColors.whiteColor,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.06),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (lead.isRecentlyAdded) SizedBox(height: context.h(6)),
              Padding(
                padding: EdgeInsets.only(bottom: context.w(14)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Avatar
                    Container(
                      width: context.w(56),
                      height: context.w(56),
                      decoration: BoxDecoration(
                        color: CommonColors.red50,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Center(
                        child: Text(
                          lead.initials,
                          style: TextStyle(
                            fontSize: context.s(14),
                            fontWeight: FontWeight.w600,
                            color: CommonColors.red600,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: context.w(12)),
                    // Name / time / assigned
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            lead.name,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: context.s(15),
                              fontWeight: FontWeight.w600,
                              color: CommonColors.textPrimary,
                            ),
                          ),
                          Text(
                            lead.time,
                            style: TextStyle(
                              fontSize: context.s(12),
                              fontWeight: FontWeight.w500,
                              color: CommonColors.textTertiary,
                            ),
                          ),
                          Text.rich(
                            TextSpan(
                              text: 'Assigned to ',
                              style: TextStyle(
                                fontSize: context.s(12),
                                color: CommonColors.textTertiary,
                              ),
                              children: [
                                TextSpan(
                                  text: lead.assignedTo,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: CommonColors.textPrimary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: context.w(5)),
                    // Action buttons
                    _ActionBtn(
                      svgPath: CommonImg.crmPhoneOutlined,
                      color: const Color(0xFF2563EB),
                    ),
                    SizedBox(width: context.w(8)),
                    _ActionBtn(
                      svgPath: CommonImg.crmWhatsappOutlined,
                      color: const Color(0xFF16A34A),
                    ),
                  ],
                ),
              ),
              // SizedBox(height: context.h(14)),
              AppDivider(),
              Padding(
                padding: EdgeInsets.only(top: context.h(20)),
                child: Row(
                  children: [
                    _InfoPair(
                      label: 'Source',
                      value: lead.source,
                      valueColor: CommonColors.textPrimary,
                    ),
                    SizedBox(width: context.w(20)),
                    _InfoPair(
                      label: 'Priority',
                      value: lead.priority,
                      valueColor: _priorityColor,
                    ),
                    const Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: context.w(12),
                        vertical: context.h(5),
                      ),
                      decoration: BoxDecoration(
                        color: _statusColor.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(context.w(10)),
                      ),
                      child: Text(
                        lead.status,
                        style: TextStyle(
                          fontSize: context.s(11),
                          fontWeight: FontWeight.w600,
                          color: _statusColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ActionBtn extends StatelessWidget {
  final String svgPath;
  final Color color;

  const _ActionBtn({required this.svgPath, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.w(36),
      height: context.w(36),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: SvgPicture.asset(
          svgPath,
          width: context.w(18),
          height: context.w(18),
          colorFilter: const ColorFilter.mode(
            CommonColors.whiteColor,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}

class _InfoPair extends StatelessWidget {
  final String label;
  final String value;
  final Color valueColor;

  const _InfoPair({
    required this.label,
    required this.value,
    required this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: context.s(12),
            color: CommonColors.textTertiary,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: context.h(4)),
        Text(
          value,
          style: TextStyle(
            fontSize: context.s(14),
            fontWeight: FontWeight.w500,
            color: valueColor,
          ),
        ),
      ],
    );
  }
}
