import 'package:intl/intl.dart';

class DateFormatter {
  /// Formats [amount] as Indian currency (₹1,00,000 or ₹1,234.50).
  /// Decimals are shown only when the value is not a whole number.
  static String formatAmount(num? amount) {
    if (amount == null) return '-';
    final hasDecimal = amount != amount.truncate();
    return NumberFormat.currency(
      locale: 'en_IN',
      symbol: '₹',
      decimalDigits: hasDecimal ? 2 : 0,
    ).format(amount);
  }

  static const _months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  /// Parses [raw] ISO date string, converts to IST (+5:30), and formats as
  /// "1 Jan 2026 8:00AM". Returns [fallback] if null/empty, raw string on parse error.
  static String format(
    String? raw, {
    String fallback = '-',
    bool showTime = true,
  }) {
    if (raw == null || raw.isEmpty) return fallback;
    try {
      final d = DateTime.parse(raw).add(const Duration(hours: 5, minutes: 30));
      final hour = d.hour % 12 == 0 ? 12 : d.hour % 12;
      final minute = d.minute.toString().padLeft(2, '0');
      final period = d.hour < 12 ? 'AM' : 'PM';
      if (!showTime) {
        return '${d.day} ${_months[d.month - 1]} ${d.year}';
      }
      return '${d.day} ${_months[d.month - 1]} ${d.year}  $hour:$minute$period';
    } catch (_) {
      return raw;
    }
  }
}
