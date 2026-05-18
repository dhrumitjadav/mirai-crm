import 'package:flutter/material.dart';
import 'package:mirai_crm/utils/common_colors.dart';
import 'package:mirai_crm/utils/responsive.dart';
import 'package:mirai_crm/widgets/app_card.dart';
import 'package:mirai_crm/widgets/app_divider.dart';

class CampaignPerformanceTab extends StatelessWidget {
  const CampaignPerformanceTab({super.key});

  static const _metrics = [
    _Metric(label: 'Conversation Rate', value: 0.25, display: '25%'),
    _Metric(label: 'Follow-up Compliance', value: 0.47, display: '47%'),
    _Metric(label: 'Response SLA', value: 0.52, display: '52%'),
    _Metric(label: 'Lead Saturation', value: 0.24, display: '24%'),
  ];

  static const _activities = [
    _Activity(
      type: 'Created',
      description: 'Campaign Launched',
      time: 'Today, 10:00 AM',
      dotColor: CommonColors.success500,
    ),
    _Activity(
      type: 'Edited',
      description: 'Campaign Launched',
      time: 'Today, 10:00 AM',
      dotColor: CommonColors.info500,
    ),
    _Activity(
      type: 'Paused',
      description: 'Campaign Launched',
      time: 'Today, 10:00 AM',
      dotColor: Color(0xFFF97316),
    ),
    _Activity(
      type: 'Resumed',
      description: 'Campaign Launched',
      time: 'Today, 10:00 AM',
      dotColor: CommonColors.success500,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    RS.init(context);
    return SingleChildScrollView(
      padding: EdgeInsets.all(RS.HS(16)),
      child: Column(
        children: [
          _buildPerformanceSummaryCard(),
          SizedBox(height: RS.VS(12)),
          _buildActivityTimelineCard(),
          SizedBox(height: RS.VS(12)),
          _buildInfoBanner(),
          SizedBox(height: RS.VS(4)),
        ],
      ),
    );
  }

  Widget _buildPerformanceSummaryCard() {
    return AppCard(
      title: 'Performance Summary',
      showDivider: true,
      child: Column(
        children: _metrics.indexed
            .expand(
              (entry) => [
                _buildMetricRow(entry.$2),
                if (entry.$1 < _metrics.length - 1)
                  AppDivider(indent: RS.HS(16), endIndent: RS.HS(16)),
              ],
            )
            .toList(),
      ),
    );
  }

  Widget _buildMetricRow(_Metric metric) {
    return Padding(
      padding: EdgeInsets.fromLTRB(RS.HS(16), RS.VS(14), RS.HS(16), RS.VS(14)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                metric.label,
                style: TextStyle(
                  fontSize: RS.FS(14),
                  fontWeight: FontWeight.w700,
                  color: CommonColors.textPrimary,
                ),
              ),
              Text(
                metric.display,
                style: TextStyle(
                  fontSize: RS.FS(16),
                  fontWeight: FontWeight.w500,
                  color: CommonColors.percent41to60,
                ),
              ),
            ],
          ),
          SizedBox(height: RS.VS(10)),
          ClipRRect(
            borderRadius: BorderRadius.circular(3),
            child: LinearProgressIndicator(
              value: metric.value,
              minHeight: RS.VS(5),
              borderRadius: const BorderRadius.all(Radius.circular(3)),
              backgroundColor: CommonColors.grey100,
              valueColor: const AlwaysStoppedAnimation<Color>(
                CommonColors.percent41to60,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityTimelineCard() {
    return AppCard(
      title: 'Activity Timeline',
      showDivider: true,
      child: Column(
        children: _activities.indexed
            .map(
              (entry) => Column(
                children: [
                  _buildActivityRow(entry.$2),
                  if (entry.$1 < _activities.length - 1)
                    AppDivider(indent: RS.HS(14), endIndent: RS.HS(14)),
                ],
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildActivityRow(_Activity activity) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: RS.HS(14), vertical: RS.VS(14)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: RS.VS(3)),
            child: Container(
              width: RS.HS(8),
              height: RS.HS(8),
              decoration: BoxDecoration(
                color: activity.dotColor,
                shape: BoxShape.circle,
              ),
            ),
          ),
          SizedBox(width: RS.HS(10)),
          Expanded(
            child: Column(
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
                        text: ' ${activity.description}',
                        style: TextStyle(
                          fontSize: RS.FS(12),
                          fontWeight: FontWeight.w400,
                          color: CommonColors.textTertiary,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: RS.VS(2)),
                Text(
                  activity.time,
                  style: TextStyle(
                    fontSize: RS.FS(12),
                    color: CommonColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoBanner() {
    return Container(
      padding: EdgeInsets.all(RS.HS(12)),
      decoration: BoxDecoration(
        color: CommonColors.info50,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: CommonColors.info600),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline_rounded,
            size: RS.HS(16),
            color: CommonColors.info600,
          ),
          SizedBox(width: RS.HS(8)),
          Expanded(
            child: Text(
              'Detailed analytics, historical comparisons and exports are available on the Web Admin Panel.',
              style: TextStyle(
                fontSize: RS.FS(12),
                color: CommonColors.info600,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Metric {
  final String label;
  final double value;
  final String display;

  const _Metric({
    required this.label,
    required this.value,
    required this.display,
  });
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
