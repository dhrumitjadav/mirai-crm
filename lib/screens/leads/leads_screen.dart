import 'package:flutter/material.dart';
import 'package:mirai_crm/utils/app_size.dart';
import 'package:mirai_crm/utils/common_colors.dart';
import 'package:mirai_crm/widgets/leads/lead_list_card.dart';

class LeadsScreen extends StatelessWidget {
  const LeadsScreen({super.key});

  static const _tabs = ['All', 'New', 'Contacted', 'Un-read', 'Follow-up'];

  static const _leads = [
    LeadListItem(
      initials: 'MR',
      name: 'Michael Rodriguez',
      time: 'Yesterday, 04:10 PM',
      assignedTo: 'Nour',
      source: 'Facebook Ad',
      priority: 'Medium',
      status: 'New',
      isRecentlyAdded: true,
    ),
    LeadListItem(
      initials: 'MR',
      name: 'Michael Rodriguez',
      time: 'Yesterday, 04:10 PM',
      assignedTo: 'Nour',
      source: 'Facebook Ad',
      priority: 'Medium',
      status: 'New',
    ),
    LeadListItem(
      initials: 'EC',
      name: 'Emily Chen',
      time: '2 days ago, 11:30 AM',
      assignedTo: 'Alex',
      source: 'Google Ad',
      priority: 'High',
      status: 'Contacted',
    ),
    LeadListItem(
      initials: 'RP',
      name: 'Robert Pattinson',
      time: '3 days ago, 09:00 AM',
      assignedTo: 'Sara',
      source: 'Referral',
      priority: 'Low',
      status: 'Converted',
    ),
    LeadListItem(
      initials: 'AK',
      name: 'Ananya Krishnan',
      time: '4 days ago, 02:15 PM',
      assignedTo: 'Alex',
      source: 'Website',
      priority: 'Medium',
      status: 'Pending',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Column(
        children: [
          _buildTabBar(context),
          Expanded(
            child: TabBarView(
              children: [
                _buildLeadsList(context),
                ...(List.generate(_tabs.length - 1, (_) => _buildEmptyTab())),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar(BuildContext context) {
    return Container(
      color: CommonColors.whiteColor,
      child: TabBar(
        isScrollable: true,
        tabAlignment: TabAlignment.start,
        labelColor: CommonColors.appRedColor,
        unselectedLabelColor: CommonColors.txtTertiary,
        labelStyle: TextStyle(
          fontSize: context.s(14),
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: context.s(14),
          fontWeight: FontWeight.w500,
        ),
        indicatorColor: CommonColors.appRedColor,
        indicatorWeight: 2,
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: CommonColors.borderColor,
        tabs: _tabs.map((t) => Tab(text: t)).toList(),
      ),
    );
  }

  Widget _buildListHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.w(16),
        vertical: context.h(10),
      ),
      child: Row(
        children: [
          Text(
            'All Leads (122)',
            style: TextStyle(
              fontSize: context.s(15),
              fontWeight: FontWeight.w600,
              color: CommonColors.txtPrimary,
            ),
          ),
          const Spacer(),
          _HeaderAction(icon: Icons.swap_vert_rounded, label: 'Sort'),
          SizedBox(width: context.w(8)),
          _HeaderAction(icon: null, label: 'Select'),
        ],
      ),
    );
  }

  Widget _buildLeadsList(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(bottom: context.h(16)),
      children: [
        _buildListHeader(context),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: context.w(16)),
          child: Column(
            children: _leads.map((l) => LeadListCard(lead: l)).toList(),
          ),
        ),
        _buildFooter(context),
      ],
    );
  }

  Widget _buildEmptyTab() {
    return const Center(
      child: Text('No leads', style: TextStyle(color: CommonColors.greyAEAEAE)),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: context.h(10)),
      child: Column(
        children: [
          Container(margin:EdgeInsets.symmetric(horizontal: context.w(50)),child: Divider(color: Color(0xFFD1D5DB))),
          Text(
            'Showing leads from the last 7 days',
            style: TextStyle(
              fontSize: context.s(11),
              color: CommonColors.greyAEAEAE,
            ),
          ),
          SizedBox(height: context.h(2)),
          Text.rich(
            TextSpan(
              text: 'Use ',
              style: TextStyle(
                fontSize: context.s(11),
                color: CommonColors.greyAEAEAE,
              ),
              children: [
                TextSpan(
                  text: 'filter',
                  style: TextStyle(
                    color: CommonColors.appRedColor,
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.underline,
                    decorationColor: CommonColors.appRedColor,
                  ),
                ),
                const TextSpan(text: ' to see older leads.'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderAction extends StatelessWidget {
  final IconData? icon;
  final String label;

  const _HeaderAction({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.w(10),
        vertical: context.h(5),
      ),
      decoration: BoxDecoration(
        border: Border.all(color: CommonColors.borderSubtle),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: context.w(14), color: CommonColors.txtSecondary),
            SizedBox(width: context.w(4)),
          ],
          Text(
            label,
            style: TextStyle(
              fontSize: context.s(14),
              color: CommonColors.txtSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
