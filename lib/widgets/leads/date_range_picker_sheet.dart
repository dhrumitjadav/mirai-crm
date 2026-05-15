import 'package:flutter/material.dart';
import 'package:mirai_crm/utils/responsive.dart';
import 'package:mirai_crm/utils/common_colors.dart';
import 'package:mirai_crm/utils/date_range_picker.dart';

Future<({DateTime start, DateTime end})?> showDateRangePickerSheet(
  BuildContext context, {
  DateTime? initialStart,
  DateTime? initialEnd,
}) {
  return showModalBottomSheet<({DateTime start, DateTime end})>(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (_) => _DateRangeSheet(
      initialStart: initialStart,
      initialEnd: initialEnd,
    ),
  );
}

class _DateRangeSheet extends StatefulWidget {
  final DateTime? initialStart;
  final DateTime? initialEnd;

  const _DateRangeSheet({this.initialStart, this.initialEnd});

  @override
  State<_DateRangeSheet> createState() => _DateRangeSheetState();
}

class _DateRangeSheetState extends State<_DateRangeSheet> {
  DateTime? _startDate;
  DateTime? _endDate;

  @override
  void initState() {
    super.initState();
    _startDate = widget.initialStart;
    _endDate = widget.initialEnd;
  }

  @override
  Widget build(BuildContext context) {
    RS.init(context);
    final canApply = _startDate != null && _endDate != null;

    return Container(
      decoration: const BoxDecoration(
        color: CommonColors.bottomSheetBgColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
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
          _buildCustomRow(context),
          _buildCalendarCard(context),
          _buildActions(context, canApply),
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
            'Select Date Range',
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

  Widget _buildCalendarCard(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: RS.HS(16),
        vertical: RS.VS(4),
      ),
      decoration: BoxDecoration(
        color: CommonColors.whiteColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(RS.HS(16)),
              child: DateRangePicker(
                initialStart: _startDate,
                initialEnd: _endDate,
                onRangeChanged: (start, end) => setState(() {
                  _startDate = start;
                  _endDate = end;
                }),
              ),
            ),
          ],
      ),
    );
  }

  Widget _buildCustomRow(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: RS.HS(16),
        vertical: RS.VS(14),
      ),
      child: Row(
        children: [
          Text(
            'Custom',
            style: TextStyle(
              fontSize: RS.FS(15),
              color: CommonColors.primaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Spacer(),
          Container(
            width: RS.HS(22),
            height: RS.HS(22),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: CommonColors.primaryColor,
            ),
            child: Center(
              child: Container(
                width: RS.HS(8),
                height: RS.HS(8),
                decoration: const BoxDecoration(
                  color: CommonColors.whiteColor,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActions(BuildContext context, bool canApply) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        RS.HS(16),
        RS.VS(8),
        RS.HS(16),
        RS.VS(16),
      ),
      child: SizedBox(
        width: double.infinity,
        height: RS.VS(50),
        child: ElevatedButton(
          onPressed: canApply
              ? () => Navigator.pop(
                    context,
                    (start: _startDate!, end: _endDate!),
                  )
              : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: CommonColors.primaryColor,
            foregroundColor: CommonColors.whiteColor,
            disabledBackgroundColor: CommonColors.grey200,
            disabledForegroundColor: CommonColors.greyAEAEAE,
            elevation: 0,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)),
          ),
          child: Text(
            'Apply',
            style: TextStyle(
              fontSize: RS.FS(15),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
