import 'package:flutter/material.dart';
import 'package:mirai_crm/utils/responsive.dart';
import 'package:mirai_crm/utils/common_colors.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final String? prefixText;

  /// Shows a red "View All" label. Ignored if [trailing] is provided.
  final VoidCallback? onViewAll;

  /// Custom trailing widget (e.g. a toggle). Takes precedence over [onViewAll].
  final Widget? trailing;

  const SectionHeader({
    super.key,
    required this.title,
    this.prefixText,
    this.onViewAll,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    RS.init(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: RS.FS(15),
            fontWeight: FontWeight.w600,
            color: CommonColors.textPrimary,
          ),
        ),
        if (trailing != null)
          trailing!
        else if (onViewAll != null)
          GestureDetector(
            onTap: onViewAll,
            child: Text(
              prefixText ?? 'View All',
              style: TextStyle(
                fontSize: RS.FS(14),
                fontWeight: FontWeight.w500,
                height: 1,
                color: CommonColors.red500,
              ),
            ),
          ),
      ],
    );
  }
}
