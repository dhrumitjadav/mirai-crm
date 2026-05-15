import 'package:flutter/material.dart';
import 'package:mirai_crm/utils/responsive.dart';
import 'package:mirai_crm/utils/common_colors.dart';
import 'package:mirai_crm/widgets/app_divider.dart';
import 'package:mirai_crm/widgets/lead_detail/lead_detail_models.dart';

class ActivityTab extends StatelessWidget {
  final List<LeadActivity> activities;

  const ActivityTab({super.key, required this.activities});

  @override
  Widget build(BuildContext context) {
    RS.init(context);
    return SingleChildScrollView(
      padding: EdgeInsets.all(RS.HS(16)),
      child: Container(
        decoration: BoxDecoration(
          color: CommonColors.whiteColor,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: CommonColors.borderSubtle),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(
                RS.HS(16),
                RS.VS(14),
                RS.HS(16),
                RS.VS(14),
              ),
              child: Text(
                'Activity Timeline',
                style: TextStyle(
                  fontSize: RS.FS(15),
                  fontWeight: FontWeight.w600,
                  color: CommonColors.textPrimary,
                ),
              ),
            ),
            AppDivider(indent: 18, endIndent: 18),
            ...activities.indexed.map(
              (entry) => _ActivityItem(
                activity: entry.$2,
                isFirst: entry.$1 == 0,
                isLast: entry.$1 == activities.length - 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActivityItem extends StatelessWidget {
  final LeadActivity activity;
  final bool isFirst;
  final bool isLast;

  const _ActivityItem({
    required this.activity,
    required this.isFirst,
    required this.isLast,
  });

  Color _dotColor() {
    return switch (activity.toStatus.toLowerCase()) {
      'connected' => CommonColors.info500,
      'contacted' => CommonColors.info500,
      'new' => CommonColors.green500,
      'pending' => CommonColors.warning600,
      'follow-up' || 'follow up' => CommonColors.warning600,
      'closed' => CommonColors.grey500,
      _ => CommonColors.grey400,
    };
  }

  static const _lineColor = CommonColors.borderDefault;

  @override
  Widget build(BuildContext context) {
    RS.init(context);
    final dotColor = _dotColor();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: RS.HS(44),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: RS.VS(14) + RS.FS(13) * 0.5,
                      child: Center(
                        child: Container(
                          width: 2,
                          color: isFirst ? Colors.transparent : _lineColor,
                        ),
                      ),
                    ),
                    Container(
                      width: RS.HS(7),
                      height: RS.HS(7),
                      decoration: BoxDecoration(
                        color: dotColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Container(
                          width: 2,
                          color: isLast ? Colors.transparent : _lineColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: RS.HS(8),
                        vertical: RS.VS(14),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              style: TextStyle(
                                fontSize: RS.FS(14),
                                color: CommonColors.textPrimary,
                              ),
                              children: [
                                const TextSpan(text: 'Status set to '),
                                TextSpan(
                                  text: activity.toStatus,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                if (activity.fromStatus != null) ...[
                                  const TextSpan(text: ' from '),
                                  TextSpan(
                                    text: activity.fromStatus,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                          SizedBox(height: RS.VS(4)),
                          Text(
                            '${activity.agent} · ${activity.time}',
                            style: TextStyle(
                              fontSize: RS.FS(12),
                              color: CommonColors.textTertiary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (!isLast) const AppDivider(indent: 0, endIndent: 0),
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
