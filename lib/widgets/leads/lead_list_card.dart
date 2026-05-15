import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mirai_crm/utils/responsive.dart';
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
  final bool isSelectMode;
  final bool isSelected;

  const LeadListCard({
    super.key,
    required this.lead,
    this.isSelectMode = false,
    this.isSelected = false,
  });

  Color get _priorityColor {
    switch (lead.priority.toLowerCase()) {
      case 'high':
        return CommonColors.warning800;
      case 'medium':
        return CommonColors.warning500;
      default:
        return CommonColors.green500;
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
    RS.init(context);
    final showBadge = lead.isRecentlyAdded && !isSelectMode;
    return Stack(
      clipBehavior: Clip.none,
      children: [
        if (showBadge)
          Positioned(
            top: -10,
            left: 0,
            child: Container(
              height: RS.VS(37),
              margin: const EdgeInsets.only(top: 3),
              alignment: Alignment.topLeft,
              padding: EdgeInsets.fromLTRB(
                RS.HS(12),
                RS.VS(7),
                RS.HS(17),
                0,
              ),
              decoration: BoxDecoration(
                color: CommonColors.green600,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(RS.HS(6)),
                  topRight: Radius.circular(RS.HS(6)),
                ),
              ),
              child: Text(
                'Recently Added',
                style: TextStyle(
                  fontSize: RS.FS(10),
                  color: CommonColors.whiteColor,
                ),
              ),
            ),
          ),
        Container(
          margin: EdgeInsets.only(
            bottom: RS.VS(12),
            top: showBadge ? RS.VS(21) : 0,
          ),
          padding: EdgeInsets.all(RS.VS(16)),
          decoration: BoxDecoration(
            color: isSelected
                ? CommonColors.primaryColor.withValues(alpha: 0.04)
                : CommonColors.whiteColor,
            borderRadius: BorderRadius.circular(14),
            border: isSelected ? Border.all(color: CommonColors.red200) : null,
            boxShadow: isSelected
                ? null
                : [
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
              if (showBadge) SizedBox(height: RS.VS(6)),
              Padding(
                padding: EdgeInsets.only(bottom: RS.HS(14)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (isSelectMode) ...[
                      _SelectCircle(isSelected: isSelected),
                      SizedBox(width: RS.HS(10)),
                    ],
                    Container(
                      width: RS.HS(56),
                      height: RS.HS(56),
                      decoration: BoxDecoration(
                        color: CommonColors.red50,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Center(
                        child: Text(
                          lead.initials,
                          style: TextStyle(
                            fontSize: RS.FS(14),
                            fontWeight: FontWeight.w600,
                            color: CommonColors.red600,
                          ),
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
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: RS.FS(15),
                              fontWeight: FontWeight.w600,
                              color: CommonColors.textPrimary,
                            ),
                          ),
                          Text(
                            lead.time,
                            style: TextStyle(
                              fontSize: RS.FS(12),
                              fontWeight: FontWeight.w500,
                              color: CommonColors.textTertiary,
                            ),
                          ),
                          Text.rich(
                            TextSpan(
                              text: 'Assigned to ',
                              style: TextStyle(
                                fontSize: RS.FS(12),
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
                    if (!isSelectMode) ...[
                      SizedBox(width: RS.HS(5)),
                      _ActionBtn(
                        svgPath: CommonImg.crmPhoneOutlined,
                        color: const Color(0xFF2563EB),
                      ),
                      SizedBox(width: RS.HS(8)),
                      _ActionBtn(
                        svgPath: CommonImg.crmWhatsappOutlined,
                        color: const Color(0xFF16A34A),
                      ),
                    ],
                  ],
                ),
              ),
              AppDivider(),
              Padding(
                padding: EdgeInsets.only(top: RS.VS(14)),
                child: Row(
                  children: [
                    _InfoPair(
                      label: 'Source',
                      value: lead.source,
                      valueColor: CommonColors.textPrimary,
                    ),
                    SizedBox(width: RS.HS(20)),
                    _InfoPair(
                      label: 'Priority',
                      value: lead.priority,
                      valueColor: _priorityColor,
                    ),
                    const Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: RS.HS(12),
                        vertical: RS.VS(5),
                      ),
                      decoration: BoxDecoration(
                        color: _statusColor.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(RS.HS(10)),
                      ),
                      child: Text(
                        lead.status,
                        style: TextStyle(
                          fontSize: RS.FS(11),
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

class _SelectCircle extends StatelessWidget {
  final bool isSelected;

  const _SelectCircle({required this.isSelected});

  @override
  Widget build(BuildContext context) {
    RS.init(context);
    return Container(
      width: RS.HS(22),
      height: RS.HS(22),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isSelected ? CommonColors.primaryColor : Colors.transparent,
        border: Border.all(
          color: isSelected ? CommonColors.primaryColor : CommonColors.grey300,
          width: 1.5,
        ),
      ),
      child: isSelected
          ? Icon(Icons.check, size: RS.HS(12), color: CommonColors.whiteColor)
          : null,
    );
  }
}

class _ActionBtn extends StatelessWidget {
  final String svgPath;
  final Color color;

  const _ActionBtn({required this.svgPath, required this.color});

  @override
  Widget build(BuildContext context) {
    RS.init(context);
    return Container(
      width: RS.HS(36),
      height: RS.HS(36),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: SvgPicture.asset(
          svgPath,
          width: RS.HS(18),
          height: RS.HS(18),
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
    RS.init(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: RS.FS(12),
            color: CommonColors.textTertiary,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: RS.VS(4)),
        Text(
          value,
          style: TextStyle(
            fontSize: RS.FS(14),
            fontWeight: FontWeight.w500,
            color: valueColor,
          ),
        ),
      ],
    );
  }
}
