import 'package:flutter/material.dart';
import 'package:mirai_crm/utils/responsive.dart';
import 'package:mirai_crm/utils/common_colors.dart';
import 'package:mirai_crm/widgets/app_divider.dart';
import 'package:mirai_crm/widgets/leads/date_range_picker_sheet.dart';

void showSortBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (_) => const _SortSheet(),
  );
}

class _SortSheet extends StatefulWidget {
  const _SortSheet();

  @override
  State<_SortSheet> createState() => _SortSheetState();
}

class _SortSheetState extends State<_SortSheet> {
  String _selected = 'Recently added';
  DateTime? _startDate;
  DateTime? _endDate;

  static const _options = [
    'Recently added',
    'Yesterday',
    'Last 7 Days',
    'Last 30 Days',
    'Custom',
  ];

  static const _months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  String _formatDate(DateTime d) =>
      '${_months[d.month - 1].substring(0, 3)} ${d.day}';

  String get _dateRangeLabel {
    if (_startDate == null) return '';
    if (_endDate == null) return ' (${_formatDate(_startDate!)})';
    return ' (${_formatDate(_startDate!)} - ${_formatDate(_endDate!)})';
  }

  Future<void> _openDateRangePicker() async {
    final result = await showDateRangePickerSheet(
      context,
      initialStart: _startDate,
      initialEnd: _endDate,
    );
    if (result != null && mounted) {
      setState(() {
        _startDate = result.start;
        _endDate = result.end;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    RS.init(context);
    return Container(
      decoration: const BoxDecoration(
        color: CommonColors.bottomSheetBgColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: CommonColors.borderDefault),
              ),
              boxShadow: [
                BoxShadow(
                  color: CommonColors.blackColor.withValues(alpha: 0.08),
                  offset: Offset(0, 2),
                  blurRadius: 2,
                  blurStyle: BlurStyle.outer,
                ),
              ],
            ),
            child: Column(
              children: [
                _buildHandle(context),
                _buildHeader(context),
              ],
            ),
          ),
          AppDivider(indent: 20, endIndent: 20),
          ...List.generate(
            _options.length,
            (i) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildOption(context, _options[i]),
                if (i < _options.length - 1)
                  AppDivider(indent: 20, endIndent: 20),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(RS.HS(16)),
            child: SizedBox(
              width: double.infinity,
              height: RS.VS(50),
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: CommonColors.primaryColor,
                  foregroundColor: CommonColors.whiteColor,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Apply',
                  style: TextStyle(
                    fontSize: RS.FS(16),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHandle(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: RS.VS(12), bottom: RS.VS(4)),
      child: Container(
        width: RS.HS(40),
        height: RS.VS(4),
        decoration: BoxDecoration(
          color: CommonColors.blackColor.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: RS.HS(16),
        vertical: RS.VS(14),
      ),
      child: Row(
        children: [
          Text(
            'Sort by',
            style: TextStyle(
              fontSize: RS.FS(20),
              fontWeight: FontWeight.w600,
              color: CommonColors.textPrimary,
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.close,
              size: RS.HS(22),
              color: CommonColors.blackColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOption(BuildContext context, String label) {
    final isSelected = _selected == label;
    final isCustom = label == 'Custom';

    return InkWell(
      onTap: () async {
        setState(() => _selected = label);
        if (isCustom) await _openDateRangePicker();
      },
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: RS.HS(20),
          vertical: RS.VS(14),
        ),
        child: Row(
          children: [
            if (isCustom && _dateRangeLabel.isNotEmpty) ...[
              Text(
                label,
                style: TextStyle(
                  fontSize: RS.FS(15),
                  color: isSelected
                      ? CommonColors.primaryColor
                      : CommonColors.textPrimary,
                ),
              ),
              Text(
                _dateRangeLabel,
                style: TextStyle(
                  fontSize: RS.FS(13),
                  color: CommonColors.primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ] else
              Text(
                label,
                style: TextStyle(
                  fontSize: RS.FS(15),
                  color: isSelected
                      ? CommonColors.primaryColor
                      : CommonColors.textPrimary,
                ),
              ),
            const Spacer(),
            Container(
              width: RS.HS(22),
              height: RS.HS(22),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected
                    ? CommonColors.primaryColor
                    : Colors.transparent,
                border: Border.all(
                  color: isSelected
                      ? CommonColors.primaryColor
                      : CommonColors.grey300,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: RS.HS(8),
                        height: RS.HS(8),
                        decoration: const BoxDecoration(
                          color: CommonColors.whiteColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
