import 'package:flutter/material.dart';
import 'package:mirai_crm/utils/responsive.dart';
import 'package:mirai_crm/utils/common_colors.dart';
import 'package:mirai_crm/widgets/section_header.dart';
import 'package:mirai_crm/widgets/dashboard/lead_card.dart';
import 'package:mirai_crm/widgets/app_divider.dart';

class RecentLeadsSection extends StatelessWidget {
  final List<LeadData> leads;
  final VoidCallback? onViewAll;

  const RecentLeadsSection({super.key, required this.leads, this.onViewAll});

  @override
  Widget build(BuildContext context) {
    RS.init(context);
    return Container(
      decoration: BoxDecoration(
        color: CommonColors.whiteColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: CommonColors.borderDefault),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: RS.HS(16),
              vertical: RS.VS(10),
            ),
            child: SectionHeader(title: 'Recent Leads', onViewAll: onViewAll),
          ),
          AppDivider(),
          ...List.generate(
            leads.length,
            (i) => Column(
              children: [
                LeadCard(lead: leads[i]),
                if (i < leads.length - 1) AppDivider(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
