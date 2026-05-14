import 'package:flutter/material.dart';
import 'package:mirai_crm/utils/app_size.dart';
import 'package:mirai_crm/utils/common_colors.dart';
import 'package:mirai_crm/widgets/section_header.dart';
import 'package:mirai_crm/widgets/dashboard/lead_card.dart';

class RecentLeadsSection extends StatelessWidget {
  final List<LeadData> leads;
  final VoidCallback? onViewAll;

  const RecentLeadsSection({super.key, required this.leads, this.onViewAll});

  @override
  Widget build(BuildContext context) {
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
              horizontal: context.w(16),
              vertical: context.h(10),
            ),
            child: SectionHeader(title: 'Recent Leads', onViewAll: onViewAll),
          ),
          Divider(
            color: CommonColors.borderSubtle,
            indent: context.w(16),
            endIndent: context.w(16),
          ),
          ...List.generate(
            leads.length,
            (i) => Column(
              children: [
                LeadCard(lead: leads[i]),
                if (i < leads.length - 1)
                  Divider(
                    color: CommonColors.borderSubtle,
                    indent: context.w(16),
                    endIndent: context.w(16),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
