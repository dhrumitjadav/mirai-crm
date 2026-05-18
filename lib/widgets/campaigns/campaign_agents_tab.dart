import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mirai_crm/utils/common_colors.dart';
import 'package:mirai_crm/utils/common_img.dart';
import 'package:mirai_crm/utils/responsive.dart';
import 'package:mirai_crm/widgets/app_card.dart';
import 'package:mirai_crm/widgets/app_divider.dart';

class CampaignAgentsTab extends StatelessWidget {
  const CampaignAgentsTab({super.key});

  static const _agents = [
    _Agent(
      name: 'Sarah Disouza',
      subtitle: '45 closed this month',
      metric: '92%',
    ),
    _Agent(
      name: 'Marcus Thompson',
      subtitle: '45 closed this month',
      metric: '92%',
      initials: 'MT',
    ),
    _Agent(
      name: 'Priya Patel',
      subtitle: '45 closed this month',
      metric: '92%',
      initials: 'PP',
    ),
  ];

  static const _teams = [
    _Team(name: 'Sales 1', memberCount: 6),
    _Team(name: 'Sales 1', memberCount: 4),
  ];

  @override
  Widget build(BuildContext context) {
    RS.init(context);
    return SingleChildScrollView(
      padding: EdgeInsets.all(RS.HS(16)),
      child: Column(
        children: [
          _buildAgentPerformanceCard(),
          SizedBox(height: RS.VS(12)),
          _buildTeamsCard(),
        ],
      ),
    );
  }

  Widget _buildAgentPerformanceCard() {
    return AppCard(
      title: 'Agent Performance',
      onViewAll: () {},
      showDivider: true,
      child: Column(
        children: _agents.indexed
            .map(
              (entry) => Column(
                children: [
                  _buildAgentRow(entry.$2),
                  if (entry.$1 < _agents.length - 1)
                    AppDivider(indent: RS.HS(14), endIndent: RS.HS(14)),
                ],
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildAgentRow(_Agent agent) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: RS.HS(10), vertical: RS.VS(14)),
      child: Row(
        children: [
          if (agent.initials == null)
            ClipRRect(
              borderRadius: BorderRadius.circular(RS.HS(20)),
              child: Image.asset(
                CommonImg.profilePicture,
                width: RS.HS(40),
                height: RS.HS(40),
                fit: BoxFit.cover,
              ),
            )
          else
            Container(
              width: RS.HS(40),
              height: RS.HS(40),
              decoration: BoxDecoration(
                color: CommonColors.green50,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  agent.initials!,
                  style: TextStyle(
                    fontSize: RS.FS(13),
                    fontWeight: FontWeight.w600,
                    color: CommonColors.green600,
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
                  agent.name,
                  style: TextStyle(
                    fontSize: RS.FS(14),
                    fontWeight: FontWeight.w600,
                    color: CommonColors.textPrimary,
                  ),
                ),
                SizedBox(height: RS.VS(3)),
                Text(
                  agent.subtitle,
                  style: TextStyle(
                    fontSize: RS.FS(12),
                    color: CommonColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Text(
            agent.metric,
            style: TextStyle(
              fontSize: RS.FS(15),
              fontWeight: FontWeight.w700,
              color: CommonColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeamsCard() {
    return AppCard(
      title: 'Teams (${_teams.length})',
      showDivider: true,
      child: Column(
        children: _teams.indexed
            .map(
              (entry) => Column(
                children: [
                  _buildTeamRow(entry.$2),
                  if (entry.$1 < _teams.length - 1)
                    AppDivider(indent: RS.HS(14), endIndent: RS.HS(14)),
                ],
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildTeamRow(_Team team) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: RS.HS(10), vertical: RS.VS(14)),
      child: Row(
        children: [
          Container(
            width: RS.HS(40),
            height: RS.HS(40),
            decoration: BoxDecoration(
              color: CommonColors.info50,
              shape: BoxShape.circle
            ),
            child: Center(
              child: SvgPicture.asset(
                CommonImg.crmTeamOutlined,
                width: RS.HS(20),
                height: RS.HS(20),
                colorFilter: const ColorFilter.mode(
                  CommonColors.info600,
                  BlendMode.srcIn,
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
                  team.name,
                  style: TextStyle(
                    fontSize: RS.FS(14),
                    fontWeight: FontWeight.w600,
                    color: CommonColors.textPrimary,
                  ),
                ),
                SizedBox(height: RS.VS(3)),
                Text(
                  '${team.memberCount} members',
                  style: TextStyle(
                    fontSize: RS.FS(12),
                    color: CommonColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
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
}

class _Agent {
  final String name;
  final String subtitle;
  final String metric;
  final String? initials;

  const _Agent({
    required this.name,
    required this.subtitle,
    required this.metric,
    this.initials,
  });
}

class _Team {
  final String name;
  final int memberCount;

  const _Team({required this.name, required this.memberCount});
}
