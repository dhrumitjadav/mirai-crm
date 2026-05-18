import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirai_crm/screens/campaigns/campaign_detail_screen.dart';
import 'package:mirai_crm/utils/responsive.dart';
import 'package:mirai_crm/utils/common_colors.dart';
import 'package:mirai_crm/widgets/campaigns/campaign_filter_sheet.dart';
import 'package:mirai_crm/widgets/campaigns/campaign_list_card.dart';

class CampaignsScreen extends StatefulWidget {
  const CampaignsScreen({super.key});

  @override
  State<CampaignsScreen> createState() => _CampaignsScreenState();
}

class _CampaignsScreenState extends State<CampaignsScreen> {
  static const _tabs = [
    'All',
    'Active',
    'Paused',
    'Scheduled',
    'Draft',
    'Hold',
  ];

  static final _campaigns = [
    CampaignItem(
      title: 'Webinar Funnel',
      dateRange: 'Mar 15 – Apr 30, 2026',
      type: 'DISTRIBUTION',
      status: 'Active',
      members: const [
        CampaignMember(initials: 'A', color: Color(0xff60A5FA)),
        CampaignMember(initials: 'R', color: Color(0xff10B981)),
        CampaignMember(initials: 'FA', color: Color(0xff6366F1)),
      ],
      extraMembers: 1,
      memberCount: 4,
      teamCount: 1,
      progressLabel: 'Leads Conversion',
      converted: 62,
      total: 250,
    ),
    CampaignItem(
      title: 'Q4 Spring Sale',
      dateRange: 'Apr 01 – Apr 30, 2026',
      type: 'OUTBOUND',
      status: 'Active',
      members: const [
        CampaignMember(initials: 'N', color: Color(0xff6366F1)),
        CampaignMember(initials: 'S', color: Color(0xffEC4899)),
      ],
      extraMembers: 3,
      memberCount: 5,
      teamCount: 2,
      progressLabel: 'Leads Conversion',
      converted: 118,
      total: 400,
    ),
    CampaignItem(
      title: 'SaaS Webinar Promo',
      dateRange: 'Feb 10 – Mar 28, 2026',
      type: 'INBOUND',
      status: 'Paused',
      members: const [
        CampaignMember(initials: 'K', color: Color(0xff10B981)),
        CampaignMember(initials: 'M', color: Color(0xffF59E0B)),
        CampaignMember(initials: 'A', color: Color(0xff6366F1)),
      ],
      extraMembers: 0,
      memberCount: 3,
      teamCount: 1,
      progressLabel: 'Leads Conversion',
      converted: 80,
      total: 312,
    ),
    CampaignItem(
      title: 'Retargeting Display Ads',
      dateRange: 'May 01 – May 31, 2026',
      type: 'RETARGETING',
      status: 'Scheduled',
      members: const [
        CampaignMember(initials: 'R', color: Color(0xffEC4899)),
        CampaignMember(initials: 'N', color: Color(0xff6366F1)),
      ],
      extraMembers: 0,
      memberCount: 2,
      teamCount: 1,
      progressLabel: 'Leads Conversion',
      converted: 0,
      total: 54,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    RS.init(context);
    return DefaultTabController(
      length: _tabs.length,
      child: Column(
        children: [
          _buildTabBar(context),
          Expanded(
            child: TabBarView(
              children: [
                _buildAllTab(context),
                ...List.generate(_tabs.length - 1, (_) => _buildEmptyTab()),
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
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: RS.HS(16)),
        child: TabBar(
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          labelColor: CommonColors.primaryColor,
          unselectedLabelColor: CommonColors.textTertiary,
          labelStyle: TextStyle(
            fontSize: RS.FS(14),
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: RS.FS(14),
            fontWeight: FontWeight.w500,
          ),
          indicatorColor: CommonColors.primaryColor,
          indicatorWeight: 2,
          indicatorSize: TabBarIndicatorSize.tab,
          dividerColor: CommonColors.borderDefault,
          tabs: _tabs.map((t) => Tab(text: t)).toList(),
        ),
      ),
    );
  }

  Widget _buildAllTab(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoBanner(context),
        _buildListHeader(context),
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.fromLTRB(
              RS.HS(16),
              RS.VS(4),
              RS.HS(16),
              RS.VS(16),
            ),
            itemCount: _campaigns.length,
            itemBuilder: (_, i) => CampaignListCard(
              campaign: _campaigns[i],
              onTap: () => Get.to(() => CampaignDetailScreen(campaign: _campaigns[i])),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoBanner(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(RS.HS(16), RS.VS(12), RS.HS(16), 0),
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
              'Create or edit campaign from the Web Admin Panel. Mobile is for monitoring and pause/resume control.',
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

  Widget _buildListHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(RS.HS(16), RS.VS(14), RS.HS(16), RS.VS(4)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'All Campaigns (122)',
            style: TextStyle(
              fontSize: RS.FS(15),
              fontWeight: FontWeight.w600,
              color: CommonColors.textPrimary,
            ),
          ),
          GestureDetector(
            onTap: () => showCampaignFilterSheet(context),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: RS.HS(10),
                vertical: RS.VS(5),
              ),
              decoration: BoxDecoration(
                border: Border.all(color: CommonColors.borderSubtle),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.tune_rounded,
                    size: RS.HS(14),
                    color: CommonColors.textSecondary,
                  ),
                  SizedBox(width: RS.HS(4)),
                  Text(
                    'Filter',
                    style: TextStyle(
                      fontSize: RS.FS(14),
                      color: CommonColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyTab() {
    return const Center(
      child: Text(
        'No campaigns',
        style: TextStyle(color: CommonColors.greyAEAEAE),
      ),
    );
  }
}
