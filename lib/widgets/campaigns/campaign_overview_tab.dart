import 'package:flutter/material.dart';
import 'package:mirai_crm/utils/common_colors.dart';
import 'package:mirai_crm/utils/responsive.dart';
import 'package:mirai_crm/widgets/app_card.dart';
import 'package:mirai_crm/widgets/app_divider.dart';
import 'package:mirai_crm/widgets/campaigns/campaign_list_card.dart';

class CampaignOverviewTab extends StatelessWidget {
  final CampaignItem campaign;

  const CampaignOverviewTab({super.key, required this.campaign});

  @override
  Widget build(BuildContext context) {
    RS.init(context);
    final progress = campaign.total > 0
        ? campaign.converted / campaign.total
        : 0.0;
    return SingleChildScrollView(
      padding: EdgeInsets.all(RS.HS(16)),
      child: Column(
        children: [
          _buildInfoCard(
            title: 'Campaign counters',
            rows: [
              ('Total Leads', campaign.total.toString()),
              ('Leads Assigned', '125'),
              ('Pending Leads', '21'),
              ('Converted', campaign.converted.toString()),
              ('Lost', '20'),
              ('Avg Response Time', '14 min'),
            ],
          ),
          SizedBox(height: RS.VS(12)),
          _buildConversionCard(progress),
        ],
      ),
    );
  }

  Widget _buildInfoCard({
    required String title,
    Widget? trailing,
    required List<(String, String)> rows,
  }) {
    return AppCard(
      radius: 10,
      title: title,
      trailing: trailing,
      showDivider: true,
      child: Column(
        children: rows.indexed
            .map(
              (entry) => Column(
                children: [
                  _buildInfoRow(entry.$2.$1, entry.$2.$2),
                  if (entry.$1 < rows.length - 1)
                    AppDivider(indent: RS.HS(16), endIndent: RS.HS(16)),
                ],
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: RS.HS(18), vertical: RS.VS(14)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: RS.FS(14),
              fontWeight: FontWeight.w500,
              color: CommonColors.textTertiary,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: RS.FS(14),
              fontWeight: FontWeight.w500,
              color: CommonColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConversionCard(double progress) {
    return AppCard(
      radius: 10,
      title: 'Campaign Conversion',
      showDivider: true,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          RS.HS(18),
          RS.VS(4),
          RS.HS(18),
          RS.VS(16),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  campaign.progressLabel,
                  style: TextStyle(
                    fontSize: RS.FS(13),
                    color: CommonColors.textSecondary,
                  ),
                ),
                Text(
                  '${campaign.converted}/${campaign.total}',
                  style: TextStyle(
                    fontSize: RS.FS(13),
                    fontWeight: FontWeight.w600,
                    color: CommonColors.success600,
                  ),
                ),
              ],
            ),
            SizedBox(height: RS.VS(8)),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: RS.VS(6),
                borderRadius: BorderRadius.all(Radius.circular(3)),
                backgroundColor: CommonColors.grey200,
                valueColor: const AlwaysStoppedAnimation<Color>(
                  CommonColors.success500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
