import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mirai_crm/utils/common_colors.dart';
import 'package:mirai_crm/utils/common_img.dart';
import 'package:mirai_crm/utils/responsive.dart';
import 'package:mirai_crm/widgets/app_card.dart';
import 'package:mirai_crm/widgets/app_divider.dart';

({Color bg, Color text}) _leadStatusBadge(String status) => switch (status) {
  'CONVERTED' => (bg: CommonColors.green50, text: CommonColors.green600),
  'NEW' => (bg: CommonColors.info50, text: CommonColors.info700),
  _ => (bg: CommonColors.grey75, text: CommonColors.grey650),
};

class CampaignLeadsTab extends StatelessWidget {
  const CampaignLeadsTab({super.key});

  static final _recentLeads = [
    _RecentLead(
      initials: 'MR',
      name: 'Michael Rodriguez',
      timeAgo: '2m ago',
      agentName: 'Alex',
      status: 'NEW',
    ),
    _RecentLead(
      initials: 'EC',
      name: 'Emily Chen',
      timeAgo: '2m ago',
      agentName: 'Alex',
      status: 'CONVERTED',
    ),
    _RecentLead(
      initials: 'RP',
      name: 'Robert Pattinson',
      timeAgo: '2m ago',
      agentName: 'Alex',
      status: 'CONVERTED',
    ),
    _RecentLead(
      initials: 'AK',
      name: 'Ananya Krishnan',
      timeAgo: '2m ago',
      agentName: 'Alex',
      status: 'PENDING',
    ),
  ];

  static const _leadStages = [
    _LeadStage(
      name: 'New',
      count: 90,
      total: 256,
      color: CommonColors.success500,
    ),
    _LeadStage(
      name: 'Connected',
      count: 41,
      total: 256,
      color: Color(0xFFF97316),
    ),
    _LeadStage(
      name: 'Follow-up',
      count: 65,
      total: 256,
      color: CommonColors.success500,
    ),
    _LeadStage(name: 'Hold', count: 52, total: 256, color: Color(0xFFF97316)),
    _LeadStage(
      name: 'Converted',
      count: 54,
      total: 256,
      color: CommonColors.success500,
    ),
    _LeadStage(
      name: 'Lost',
      count: 21,
      total: 256,
      color: CommonColors.red500,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    RS.init(context);
    return SingleChildScrollView(
      padding: EdgeInsets.all(RS.HS(16)),
      child: Column(
        children: [
          _buildRecentLeadsCard(),
          SizedBox(height: RS.VS(12)),
          _buildLeadsByStageCard(),
        ],
      ),
    );
  }

  Widget _buildRecentLeadsCard() {
    return AppCard(
      title: 'Recent Leads',
      onViewAll: () {},
      showDivider: true,
      child: Column(
        children: _recentLeads.indexed
            .map(
              (entry) => Column(
                children: [
                  _buildLeadRow(entry.$2),
                  if (entry.$1 < _recentLeads.length - 1)
                    AppDivider(indent: RS.HS(14), endIndent: RS.HS(14)),
                ],
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildLeadRow(_RecentLead lead) {
    final sc = _leadStatusBadge(lead.status);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: RS.HS(10), vertical: RS.VS(16)),
      child: Row(
        children: [
          Container(
            width: RS.HS(40),
            height: RS.HS(40),
            decoration: BoxDecoration(
              color: CommonColors.red50,
              borderRadius: BorderRadius.circular(8),
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
          SizedBox(width: RS.HS(10)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  lead.name,
                  style: TextStyle(
                    fontSize: RS.FS(14),
                    fontWeight: FontWeight.w700,
                    color: CommonColors.textPrimary,
                  ),
                ),
                SizedBox(height: RS.VS(2)),
                Row(
                  children: [
                    Text(
                      lead.timeAgo,
                      style: TextStyle(
                        fontSize: RS.FS(12),
                        color: CommonColors.textSecondary,
                      ),
                    ),
                    SizedBox(width: RS.HS(16)),
                    SvgPicture.asset(
                      CommonImg.crmPersonOutlined,
                      width: RS.HS(12),
                      height: RS.HS(12),
                      colorFilter: const ColorFilter.mode(
                        CommonColors.blackColor,
                        BlendMode.srcIn,
                      ),
                    ),
                    SizedBox(width: RS.HS(6)),
                    Text(
                      lead.agentName,
                      style: TextStyle(
                        fontSize: RS.FS(12),
                        color: CommonColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(width: RS.HS(8)),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: RS.HS(8),
              vertical: RS.VS(4),
            ),
            decoration: BoxDecoration(
              color: sc.bg,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              lead.status,
              style: TextStyle(
                fontSize: RS.FS(10),
                fontWeight: FontWeight.w600,
                color: sc.text,
              ),
            ),
          ),
          SizedBox(width: RS.HS(6)),
          SvgPicture.asset(
            CommonImg.crmArrowRightOutlined,
            width: RS.HS(16),
            height: RS.HS(16),
            colorFilter: const ColorFilter.mode(
              CommonColors.greyAEAEAE,
              BlendMode.srcIn,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLeadsByStageCard() {
    return AppCard(
      radius: 10,
      title: 'Leads By Stage (256)',
      showDivider: true,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          RS.HS(16),
          RS.VS(12),
          RS.HS(16),
          RS.VS(16),
        ),
        child: Column(
          children: _leadStages.indexed
              .expand(
                (entry) => [
                  _buildStageRow(entry.$2),
                  if (entry.$1 < _leadStages.length - 1)
                    AppDivider(indent: 0, endIndent: 0),
                ],
              )
              .toList(),
        ),
      ),
    );
  }

  Widget _buildStageRow(_LeadStage stage) {
    final progress = stage.total > 0 ? stage.count / stage.total : 0.0;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: RS.VS(12)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                stage.name,
                style: TextStyle(
                  fontSize: RS.FS(14),
                  fontWeight: FontWeight.w700,
                  color: CommonColors.textPrimary,
                ),
              ),
              Text(
                stage.count.toString(),
                style: TextStyle(
                  fontSize: RS.FS(16),
                  fontWeight: FontWeight.w500,
                  color: CommonColors.textSecondary,
                ),
              ),
            ],
          ),
          SizedBox(height: RS.VS(10)),
          ClipRRect(
            borderRadius: BorderRadius.circular(3),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: RS.VS(5),
              borderRadius: BorderRadius.all(Radius.circular(3)),
              backgroundColor: CommonColors.grey100,
              valueColor: AlwaysStoppedAnimation<Color>(stage.color),
            ),
          ),
        ],
      ),
    );
  }
}

class _RecentLead {
  final String initials;
  final String name;
  final String timeAgo;
  final String agentName;
  final String status;

  const _RecentLead({
    required this.initials,
    required this.name,
    required this.timeAgo,
    required this.agentName,
    required this.status,
  });
}

class _LeadStage {
  final String name;
  final int count;
  final int total;
  final Color color;

  const _LeadStage({
    required this.name,
    required this.count,
    required this.total,
    required this.color,
  });
}
