import 'package:flutter/material.dart';
import 'package:mirai_crm/utils/responsive.dart';
import 'package:mirai_crm/utils/common_colors.dart';

enum _PickerMode { day, month, year }

class DateRangePicker extends StatefulWidget {
  final DateTime? initialStart;
  final DateTime? initialEnd;
  final void Function(DateTime? start, DateTime? end) onRangeChanged;

  const DateRangePicker({
    super.key,
    this.initialStart,
    this.initialEnd,
    required this.onRangeChanged,
  });

  @override
  State<DateRangePicker> createState() => _DateRangePickerState();
}

class _DateRangePickerState extends State<DateRangePicker> {
  late DateTime _currentMonth;
  DateTime? _startDate;
  DateTime? _endDate;
  _PickerMode _mode = _PickerMode.day;
  late int _yearPageStart;

  static const _weekdays = ['Su', 'Mo', 'Tu', 'We', 'Th', 'Fr', 'Sa'];
  static const _months = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December',
  ];

  @override
  void initState() {
    super.initState();
    _startDate = widget.initialStart;
    _endDate = widget.initialEnd;
    final base = _startDate ?? DateTime.now();
    _currentMonth = DateTime(base.year, base.month);
    _yearPageStart = _currentMonth.year - 6;
  }

  void _onPrev() {
    setState(() {
      if (_mode == _PickerMode.day) {
        _currentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1);
      } else if (_mode == _PickerMode.month) {
        _currentMonth = DateTime(_currentMonth.year - 1, _currentMonth.month);
      } else {
        _yearPageStart -= 12;
      }
    });
  }

  void _onNext() {
    setState(() {
      if (_mode == _PickerMode.day) {
        _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + 1);
      } else if (_mode == _PickerMode.month) {
        _currentMonth = DateTime(_currentMonth.year + 1, _currentMonth.month);
      } else {
        _yearPageStart += 12;
      }
    });
  }

  void _onDayTap(DateTime day) {
    setState(() {
      if (_startDate == null || _endDate != null) {
        _startDate = day;
        _endDate = null;
      } else if (_isSameDay(day, _startDate!)) {
        _startDate = null;
      } else if (day.isBefore(_startDate!)) {
        _endDate = _startDate;
        _startDate = day;
      } else {
        _endDate = day;
      }
    });
    widget.onRangeChanged(_startDate, _endDate);
  }

  bool _isStart(DateTime d) => _startDate != null && _isSameDay(d, _startDate!);
  bool _isEnd(DateTime d) => _endDate != null && _isSameDay(d, _endDate!);
  bool _isInRange(DateTime d) =>
      _startDate != null &&
      _endDate != null &&
      d.isAfter(_startDate!) &&
      d.isBefore(_endDate!);
  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  @override
  Widget build(BuildContext context) {
    RS.init(context);
    return Column(
      children: [
        _buildHeader(context),
        SizedBox(height: RS.VS(16)),
        if (_mode == _PickerMode.day) ...[
          _buildWeekdaysRow(context),
          SizedBox(height: RS.VS(6)),
          _buildDaysGrid(context),
        ] else if (_mode == _PickerMode.month)
          _buildMonthPicker(context)
        else
          _buildYearPicker(context),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    final String centerLabel;
    if (_mode == _PickerMode.year) {
      centerLabel = '$_yearPageStart – ${_yearPageStart + 11}';
    } else {
      centerLabel = ''; // handled separately for day/month modes
    }

    return Row(
      children: [
        GestureDetector(
          onTap: _onPrev,
          child: Icon(
            Icons.chevron_left,
            size: RS.HS(24),
            color: CommonColors.textSecondary,
          ),
        ),
        const Spacer(),
        if (_mode == _PickerMode.year)
          Text(
            centerLabel,
            style: TextStyle(
              fontSize: RS.FS(15),
              fontWeight: FontWeight.w600,
              color: CommonColors.textPrimary,
            ),
          )
        else
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () => setState(() => _mode = _PickerMode.month),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _months[_currentMonth.month - 1].substring(0, 3),
                      style: TextStyle(
                        fontSize: RS.FS(15),
                        fontWeight: FontWeight.w600,
                        color: _mode == _PickerMode.month
                            ? CommonColors.primaryColor
                            : CommonColors.textPrimary,
                      ),
                    ),
                    Icon(
                      _mode == _PickerMode.month
                          ? Icons.keyboard_arrow_up_rounded
                          : Icons.keyboard_arrow_down_rounded,
                      size: RS.HS(18),
                      color: _mode == _PickerMode.month
                          ? CommonColors.primaryColor
                          : CommonColors.textPrimary,
                    ),
                  ],
                ),
              ),
              SizedBox(width: RS.HS(6)),
              GestureDetector(
                onTap: () => setState(() => _mode = _PickerMode.year),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${_currentMonth.year}',
                      style: TextStyle(
                        fontSize: RS.FS(15),
                        fontWeight: FontWeight.w600,
                        color: _mode == _PickerMode.year
                            ? CommonColors.primaryColor
                            : CommonColors.textPrimary,
                      ),
                    ),
                    Icon(
                      Icons.keyboard_arrow_down_rounded,
                      size: RS.HS(18),
                      color: _mode == _PickerMode.year
                          ? CommonColors.primaryColor
                          : CommonColors.textPrimary,
                    ),
                  ],
                ),
              ),
            ],
          ),
        const Spacer(),
        GestureDetector(
          onTap: _onNext,
          child: Icon(
            Icons.chevron_right,
            size: RS.HS(24),
            color: CommonColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildMonthPicker(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 2.2,
      children: List.generate(12, (i) {
        final isSelected = i + 1 == _currentMonth.month;
        return GestureDetector(
          onTap: () => setState(() {
            _currentMonth = DateTime(_currentMonth.year, i + 1);
            _mode = _PickerMode.day;
          }),
          child: Container(
            margin: EdgeInsets.all(RS.HS(4)),
            decoration: isSelected
                ? BoxDecoration(
                    color: CommonColors.primaryColor,
                    borderRadius: BorderRadius.circular(8),
                  )
                : null,
            child: Center(
              child: Text(
                _months[i].substring(0, 3),
                style: TextStyle(
                  fontSize: RS.FS(14),
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  color: isSelected
                      ? CommonColors.whiteColor
                      : CommonColors.textPrimary,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildYearPicker(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 2.2,
      children: List.generate(12, (i) {
        final year = _yearPageStart + i;
        final isSelected = year == _currentMonth.year;
        return GestureDetector(
          onTap: () => setState(() {
            _currentMonth = DateTime(year, _currentMonth.month);
            _mode = _PickerMode.day;
          }),
          child: Container(
            margin: EdgeInsets.all(RS.HS(4)),
            decoration: isSelected
                ? BoxDecoration(
                    color: CommonColors.primaryColor,
                    borderRadius: BorderRadius.circular(8),
                  )
                : null,
            child: Center(
              child: Text(
                '$year',
                style: TextStyle(
                  fontSize: RS.FS(14),
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  color: isSelected
                      ? CommonColors.whiteColor
                      : CommonColors.textPrimary,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildWeekdaysRow(BuildContext context) {
    return Row(
      children: _weekdays
          .map(
            (d) => Expanded(
              child: Center(
                child: Text(
                  d,
                  style: TextStyle(
                    fontSize: RS.FS(12),
                    fontWeight: FontWeight.w500,
                    color: CommonColors.textTertiary,
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildDaysGrid(BuildContext context) {
    final firstDay = DateTime(_currentMonth.year, _currentMonth.month, 1);
    final daysInMonth =
        DateTime(_currentMonth.year, _currentMonth.month + 1, 0).day;
    final prevMonthDays =
        DateTime(_currentMonth.year, _currentMonth.month, 0).day;
    final startWeekday = firstDay.weekday % 7;

    final List<DateTime> days = [];
    for (int i = startWeekday - 1; i >= 0; i--) {
      days.add(DateTime(
          _currentMonth.year, _currentMonth.month - 1, prevMonthDays - i));
    }
    for (int d = 1; d <= daysInMonth; d++) {
      days.add(DateTime(_currentMonth.year, _currentMonth.month, d));
    }
    int nextDay = 1;
    while (days.length % 7 != 0) {
      days.add(
          DateTime(_currentMonth.year, _currentMonth.month + 1, nextDay++));
    }

    final weeks = days.length ~/ 7;
    return Column(
      children: List.generate(weeks, (week) {
        return Row(
          children: List.generate(7, (col) {
            final day = days[week * 7 + col];
            final isCurrent = day.month == _currentMonth.month;
            return Expanded(
              child: _buildDayCell(
                context,
                day,
                isStart: _isStart(day),
                isEnd: _isEnd(day),
                isInRange: _isInRange(day),
                isCurrentMonth: isCurrent,
                hasRange: _endDate != null,
              ),
            );
          }),
        );
      }),
    );
  }

  Widget _buildDayCell(
    BuildContext context,
    DateTime day, {
    required bool isStart,
    required bool isEnd,
    required bool isInRange,
    required bool isCurrentMonth,
    required bool hasRange,
  }) {
    const rangeColor = CommonColors.red50;
    final isSelected = isStart || isEnd;

    return GestureDetector(
      onTap: isCurrentMonth ? () => _onDayTap(day) : null,
      child: SizedBox(
        height: RS.VS(40),
        child: Stack(
          children: [
            if (isInRange)
              Positioned.fill(
                top: RS.VS(4),
                bottom: RS.VS(4),
                child: Container(color: rangeColor),
              ),
            if (isStart && hasRange)
              Positioned.fill(
                top: RS.VS(4),
                bottom: RS.VS(4),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: FractionallySizedBox(
                    widthFactor: 0.5,
                    heightFactor: 1.0,
                    child: Container(color: rangeColor),
                  ),
                ),
              ),
            if (isEnd)
              Positioned.fill(
                top: RS.VS(4),
                bottom: RS.VS(4),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: FractionallySizedBox(
                    widthFactor: 0.5,
                    heightFactor: 1.0,
                    child: Container(color: rangeColor),
                  ),
                ),
              ),
            Center(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: RS.VS(2)),
                width: RS.HS(32),
                height: RS.VS(32),
                decoration: isSelected
                    ? BoxDecoration(
                        color: CommonColors.primaryColor,
                        borderRadius: isStart && hasRange
                            ? const BorderRadius.only(
                                topLeft: Radius.circular(8),
                                bottomLeft: Radius.circular(8),
                              )
                            : isEnd
                                ? const BorderRadius.only(
                                    topRight: Radius.circular(8),
                                    bottomRight: Radius.circular(8),
                                  )
                                : BorderRadius.circular(10),
                      )
                    : null,
                child: Center(
                  child: Text(
                    '${day.day}',
                    style: TextStyle(
                      fontSize: RS.FS(13),
                      fontWeight:
                          isSelected ? FontWeight.w700 : FontWeight.w400,
                      color: isSelected
                          ? CommonColors.whiteColor
                          : !isCurrentMonth
                              ? CommonColors.grey300
                              : isInRange
                                  ? CommonColors.primaryColor
                                  : CommonColors.textPrimary,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
