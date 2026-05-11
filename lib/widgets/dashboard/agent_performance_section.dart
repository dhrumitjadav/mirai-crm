import 'package:flutter/material.dart';
import 'package:mirai_crm/utils/app_size.dart';
import 'package:mirai_crm/utils/common_colors.dart';
import 'package:mirai_crm/widgets/section_header.dart';

class AgentPerformanceSection extends StatelessWidget {
  const AgentPerformanceSection({super.key});

  static const _agents = [
    _Agent(
      initials: 'SD',
      name: 'Sarah Disouza',
      percent: 92,
      barColor: Color(0xFF047857),
    ),
    _Agent(
      initials: 'MT',
      name: 'Marcus Thompson',
      percent: 20,
      barColor: Color(0xFFEB3A24),
    ),
    _Agent(
      initials: 'PP',
      name: 'Priya Patel',
      percent: 65,
      barColor: Color(0xFFF97316),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        context.w(16),
        context.h(14),
        context.w(16),
        context.h(4),
      ),
      decoration: BoxDecoration(
        color: CommonColors.whiteColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: CommonColors.blackColor.withValues(alpha: 0.04),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(title: 'Agent Performance', onViewAll: () {}),
          SizedBox(height: context.h(14)),
          ..._agents.map((a) => _AgentRow(agent: a)),
        ],
      ),
    );
  }
}

class _AgentRow extends StatelessWidget {
  final _Agent agent;

  const _AgentRow({required this.agent});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: context.h(14)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: context.w(38),
                height: context.w(38),
                decoration: BoxDecoration(
                  color: Color(0xFFECFDF5),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    agent.initials,
                    style: TextStyle(
                      fontSize: context.s(14),
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF059669),
                    ),
                  ),
                ),
              ),
              SizedBox(width: context.w(10)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      agent.name,
                      style: TextStyle(
                        fontSize: context.s(14),
                        fontWeight: FontWeight.w700,
                        color: CommonColors.txtPrimary,
                      ),
                    ),
                    SizedBox(height: context.h(2)),
                    Text(
                      '${agent.closed} closed this month',
                      style: TextStyle(
                        fontSize: context.s(12),
                        color: CommonColors.txtSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                '${agent.percent}%',
                style: TextStyle(
                  fontSize: context.s(16),
                  fontWeight: FontWeight.w500,
                  color: CommonColors.txtSecondary,
                ),
              ),
            ],
          ),
          SizedBox(height: context.h(10)),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: agent.percent / 100,
              minHeight: context.h(5),
              backgroundColor: CommonColors.borderColor,
              valueColor: AlwaysStoppedAnimation<Color>(agent.barColor),
            ),
          ),
        ],
      ),
    );
  }
}

class _Agent {
  final String initials;
  final String name;
  final int percent;
  final Color barColor;

  int get closed => (percent * 1.2).round();

  const _Agent({
    required this.initials,
    required this.name,
    required this.percent,
    required this.barColor,
  });
}
