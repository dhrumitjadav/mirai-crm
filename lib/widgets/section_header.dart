import 'package:flutter/material.dart';
import 'package:mirai_crm/utils/app_size.dart';
import 'package:mirai_crm/utils/common_colors.dart';

class SectionHeader extends StatelessWidget {
  final String title;

  /// Shows a red "View All" label. Ignored if [trailing] is provided.
  final VoidCallback? onViewAll;

  /// Custom trailing widget (e.g. a toggle). Takes precedence over [onViewAll].
  final Widget? trailing;

  const SectionHeader({
    super.key,
    required this.title,
    this.onViewAll,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: context.s(16),
            fontWeight: FontWeight.w600,
            color: CommonColors.blackColor,
          ),
        ),
        if (trailing != null)
          trailing!
        else if (onViewAll != null)
          GestureDetector(
            onTap: onViewAll,
            child: Text(
              'View All',
              style: TextStyle(
                fontSize: context.s(13),
                fontWeight: FontWeight.w500,
                height: 1,
                color: CommonColors.appRedColor,
              ),
            ),
          ),
      ],
    );
  }
}
