import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:mirai_crm/utils/app_size.dart';
import 'package:mirai_crm/utils/common_colors.dart';
import 'package:mirai_crm/widgets/section_header.dart';

class LeadStatusChart extends StatelessWidget {
  const LeadStatusChart({super.key});

  static const _segments = [
    _Segment(label: 'Converted', value: 45, color: Color(0xFFD97706)),
    _Segment(label: 'Active', value: 24, color: Color(0xFFEA580C)),
    _Segment(label: 'Pending', value: 20, color: Color(0xFF991B1B)),
    _Segment(label: 'Lost', value: 65, color: Color(0xFF65A30D)),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.w(17)),
      decoration: BoxDecoration(
        color: CommonColors.whiteColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: CommonColors.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(title: 'Lead Status'),
          SizedBox(height: context.h(16)),
          Row(
            children: [
              SizedBox(
                width: context.w(130),
                height: context.w(130),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    PieChart(
                      PieChartData(
                        sectionsSpace: 0,
                        centerSpaceRadius: context.w(42),
                        sections: _segments
                            .map(
                              (s) => PieChartSectionData(
                                value: s.value.toDouble(),
                                color: s.color,
                                radius: context.w(15),
                                showTitle: false,
                              ),
                            )
                            .toList(),
                        startDegreeOffset: -60,
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '12.4K',
                          style: TextStyle(
                            fontSize: context.s(12),
                            fontWeight: FontWeight.w800,
                            color: CommonColors.txtPrimary,
                          ),
                        ),
                        Text(
                          'Total',
                          style: TextStyle(
                            fontSize: context.s(10),
                            color: CommonColors.greyAEAEAE,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(width: context.w(24)),
              SizedBox(
                width: context.w(130),
                height: context.w(130),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _segments
                      .map(
                        (s) => Padding(
                          padding: EdgeInsets.only(bottom: context.h(12)),
                          child: Row(
                            children: [
                              Container(
                                width: context.w(8),
                                height: context.w(8),
                                decoration: BoxDecoration(
                                  color: s.color,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              SizedBox(width: context.w(6)),
                              Expanded(
                                child: Text(
                                  s.label,
                                  style: TextStyle(
                                    fontSize: context.s(12),
                                    fontWeight: FontWeight.w600,
                                    color: CommonColors.txtSecondary,
                                  ),
                                ),
                              ),
                              Text(
                                '${s.value}%',
                                style: TextStyle(
                                  fontSize: context.s(12),
                                  fontWeight: FontWeight.w700,
                                  color: CommonColors.txtPrimary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Segment {
  final String label;
  final int value;
  final Color color;

  const _Segment({
    required this.label,
    required this.value,
    required this.color,
  });
}
