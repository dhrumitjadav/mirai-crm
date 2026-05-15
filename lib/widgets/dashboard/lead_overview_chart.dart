import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:mirai_crm/utils/responsive.dart';
import 'package:mirai_crm/utils/common_colors.dart';
import 'package:mirai_crm/widgets/section_header.dart';

class LeadOverviewChart extends StatefulWidget {
  const LeadOverviewChart({super.key});

  @override
  State<LeadOverviewChart> createState() => _LeadOverviewChartState();
}

class _LeadOverviewChartState extends State<LeadOverviewChart> {
  bool _isMonthly = true;

  static const _monthlyData = [18.0, 22.0, 15.0, 28.0, 25.0, 10.0, 5.0];
  static const _weeklyData = [12.0, 23.0, 28.0, 28.0, 25.0, 10.0, 8.0];
  static const _monthLabels = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul'];
  static const _weekLabels = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

  List<double> get _data => _isMonthly ? _monthlyData : _weeklyData;

  List<String> get _labels => _isMonthly ? _monthLabels : _weekLabels;

  @override
  Widget build(BuildContext context) {
    RS.init(context);
    return Container(
      padding: EdgeInsets.all(RS.VS(16)),
      decoration: BoxDecoration(
        color: CommonColors.whiteColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: CommonColors.borderDefault),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(
            title: 'Lead Overview',
            trailing: _buildToggle(context),
          ),
          SizedBox(height: RS.VS(16)),
          SizedBox(
            height: RS.VS(190),
            child: BarChart(
              duration: const Duration(milliseconds: 300),
              BarChartData(
                maxY: 38,
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: 10,
                  getDrawingHorizontalLine: (_) =>
                      FlLine(color: CommonColors.borderSubtle, strokeWidth: 1),
                ),
                borderData: FlBorderData(show: false),
                titlesData: FlTitlesData(
                  leftTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: RS.VS(28),
                      getTitlesWidget: (value, _) {
                        final i = value.toInt();
                        if (i < 0 || i >= _labels.length) {
                          return const SizedBox.shrink();
                        }
                        return Padding(
                          padding: EdgeInsets.only(top: RS.VS(6)),
                          child: Text(
                            _labels[i],
                            style: TextStyle(
                              fontSize: RS.FS(11),
                              color: CommonColors.textSecondary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                barTouchData: BarTouchData(
                  enabled: false,
                  touchTooltipData: BarTouchTooltipData(
                    getTooltipColor: (_) => Colors.transparent,
                    tooltipPadding: EdgeInsets.zero,
                    tooltipMargin: RS.VS(4),
                    getTooltipItem: (_, __, rod, ___) => BarTooltipItem(
                      '${rod.toY.toInt()}%',
                      TextStyle(
                        fontSize: RS.FS(11),
                        fontWeight: FontWeight.w500,
                        color: CommonColors.info600,
                      ),
                    ),
                  ),
                ),
                barGroups: List.generate(_data.length, (i) {
                  final dimmed = i >= 5;
                  return BarChartGroupData(
                    x: i,
                    showingTooltipIndicators: const [0],
                    barRods: [
                      BarChartRodData(
                        toY: _data[i],
                        color: dimmed
                            ? CommonColors.info50
                            : CommonColors.info600,
                        width: RS.HS(28),
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(4),
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToggle(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _toggleBtn(context, 'Monthly', _isMonthly),
        SizedBox(width: RS.HS(10)),
        _toggleBtn(context, 'Weekly', !_isMonthly),
      ],
    );
  }

  Widget _toggleBtn(BuildContext context, String label, bool active) {
    return GestureDetector(
      onTap: () => setState(() => _isMonthly = label == 'Monthly'),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(
          horizontal: RS.HS(8),
          vertical: RS.VS(2.5),
        ),
        decoration: BoxDecoration(
          color: active ? CommonColors.info50 : null,
          border: active ? Border.all(color: CommonColors.info600) : null,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: RS.FS(12),
            fontWeight: FontWeight.w500,
            color: CommonColors.textPrimary,
          ),
        ),
      ),
    );
  }
}
