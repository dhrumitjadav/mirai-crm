import 'package:flutter/material.dart';
import 'package:mirai_crm/utils/common_colors.dart';
import 'package:mirai_crm/utils/responsive.dart';
import 'package:mirai_crm/widgets/app_divider.dart';

void showCampaignHistorySheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (_) => const _CampaignHistorySheet(),
  );
}

class _CampaignHistorySheet extends StatelessWidget {
  const _CampaignHistorySheet();

  static const _activities = [
    _Activity(
      type: 'Created',
      description: 'Campaign Launched',
      time: 'Today, 10:30 AM',
      dotColor: CommonColors.success500,
    ),
    _Activity(
      type: 'Edited',
      description: 'Campaign Launched',
      time: 'Today, 10:30 AM',
      dotColor: CommonColors.info500,
    ),
    _Activity(
      type: 'Paused',
      description: 'Campaign Launched',
      time: 'Today, 10:30 AM',
      dotColor: Color(0xFFF97316),
    ),
    _Activity(
      type: 'Resumed',
      description: 'Campaign Launched',
      time: 'Today, 10:30 AM',
      dotColor: Color(0xFF8B5CF6),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    RS.init(context);
    return Container(
      decoration: const BoxDecoration(
        color: CommonColors.whiteColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.only(top: RS.VS(10), bottom: RS.VS(6)),
            width: RS.HS(36),
            height: RS.VS(4),
            decoration: BoxDecoration(
              color: CommonColors.grey300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
              RS.HS(20),
              RS.VS(8),
              RS.HS(16),
              RS.VS(16),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Campaign Activity',
                    style: TextStyle(
                      fontSize: RS.FS(18),
                      fontWeight: FontWeight.w700,
                      color: CommonColors.textPrimary,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(
                    Icons.close,
                    size: RS.HS(22),
                    color: CommonColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          const AppDivider(indent: 0, endIndent: 0),
          ..._activities.indexed.map(
            (entry) => Column(
              children: [
                _buildActivityRow(context, entry.$2),
                if (entry.$1 < _activities.length - 1)
                  AppDivider(indent: RS.HS(20), endIndent: RS.HS(20)),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
              RS.HS(16),
              RS.VS(16),
              RS.HS(16),
              RS.VS(16) + MediaQuery.of(context).padding.bottom,
            ),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: CommonColors.primaryColor,
                  foregroundColor: CommonColors.whiteColor,
                  padding: EdgeInsets.symmetric(vertical: RS.VS(16)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Apply',
                  style: TextStyle(
                    fontSize: RS.FS(16),
                    fontWeight: FontWeight.w600,
                    color: CommonColors.whiteColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityRow(BuildContext context, _Activity activity) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: RS.HS(20),
        vertical: RS.VS(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: RS.VS(3)),
            child: Container(
              width: RS.HS(9),
              height: RS.HS(9),
              decoration: BoxDecoration(
                color: activity.dotColor,
                shape: BoxShape.circle,
              ),
            ),
          ),
          SizedBox(width: RS.HS(12)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: activity.type,
                      style: TextStyle(
                        fontSize: RS.FS(14),
                        fontWeight: FontWeight.w600,
                        color: CommonColors.textPrimary,
                      ),
                    ),
                    TextSpan(
                      text: '  ${activity.description}',
                      style: TextStyle(
                        fontSize: RS.FS(13),
                        fontWeight: FontWeight.w400,
                        color: CommonColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: RS.VS(4)),
              Text(
                activity.time,
                style: TextStyle(
                  fontSize: RS.FS(12),
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

class _Activity {
  final String type;
  final String description;
  final String time;
  final Color dotColor;

  const _Activity({
    required this.type,
    required this.description,
    required this.time,
    required this.dotColor,
  });
}
