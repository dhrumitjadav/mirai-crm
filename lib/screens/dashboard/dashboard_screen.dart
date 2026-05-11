import 'package:flutter/material.dart';
import 'package:mirai_crm/utils/app_size.dart';
import 'package:mirai_crm/utils/common_colors.dart';
import 'package:mirai_crm/utils/common_img.dart';
import 'package:mirai_crm/widgets/dashboard/lead_card.dart';
import 'package:mirai_crm/widgets/dashboard/lead_overview_chart.dart';
import 'package:mirai_crm/widgets/dashboard/active_campaigns_section.dart';
import 'package:mirai_crm/widgets/dashboard/agent_performance_section.dart';
import 'package:mirai_crm/widgets/dashboard/lead_status_chart.dart';
import 'package:mirai_crm/widgets/dashboard/recent_leads_section.dart';
import 'package:mirai_crm/widgets/dashboard/stat_card.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  static const _leads = [
    LeadData(
      initials: 'MR',
      name: 'Michael Rodriguez',
      time: '2m ago',
      agent: 'Alex',
      status: 'NEW',
      color: Color(0xFFD94F4F),
    ),
    LeadData(
      initials: 'EC',
      name: 'Emily Chen',
      time: '2m ago',
      agent: 'Alex',
      status: 'CONVERTED',
      color: Color(0xFFD94F4F),
    ),
    LeadData(
      initials: 'RP',
      name: 'Robert Pattinson',
      time: '2m ago',
      agent: 'Alex',
      status: 'CONVERTED',
      color: Color(0xFFD94F4F),
    ),
    LeadData(
      initials: 'AK',
      name: 'Ananya Krishnan',
      time: '2m ago',
      agent: 'Alex',
      status: 'PENDING',
      color: Color(0xFFD94F4F),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: context.w(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: context.h(18),
        children: [
          Container(),
          _buildStatsGrid(context),
          RecentLeadsSection(leads: _leads, onViewAll: () {}),
          const LeadOverviewChart(),
          const LeadStatusChart(),
          const ActiveCampaignsSection(),
          const AgentPerformanceSection(),
        ],
      ),
    );
  }

  Widget _buildStatsGrid(BuildContext context) {
    const stats = [
      (
        label: 'Total Leads',
        value: '12,450',
        change: '+12%',
        changeLabel: 'vs last mo',
        isPositive: true,
        svgIcon: CommonImg.crmLeadsOutlined,
        iconColor: CommonColors.primaryColor,
      ),
      (
        label: 'Converted\nLeads',
        value: '3,842',
        change: '-8.5%',
        changeLabel: 'vs last mo',
        isPositive: false,
        svgIcon: CommonImg.crmMegaphoneOutlined,
        iconColor: CommonColors.appGreenColor,
      ),
      (
        label: 'Ongoing\nLeads',
        value: '4,120',
        change: '-10%',
        changeLabel: 'vs last mo',
        isPositive: false,
        svgIcon: CommonImg.crmLoadingOutlined,
        iconColor: CommonColors.orangeColor,
      ),
      (
        label: 'Pending Tasks',
        value: '148',
        change: '+18%',
        changeLabel: 'attn req',
        isPositive: true,
        svgIcon: CommonImg.crmTimerOutlined,
        iconColor: CommonColors.appRedColor,
      ),
    ];
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: context.w(10),
      mainAxisSpacing: context.h(10),
      childAspectRatio: 1.49,
      children: stats
          .map(
            (s) => StatCard(
              label: s.label,
              value: s.value,
              change: s.change,
              changeLabel: s.changeLabel,
              isPositive: s.isPositive,
              svgIcon: s.svgIcon,
              iconColor: s.iconColor,
            ),
          )
          .toList(),
    );
  }
}
