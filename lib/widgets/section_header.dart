import 'package:flutter/material.dart';
import 'package:mirai_crm/utils/responsive.dart';
import 'package:mirai_crm/utils/common_colors.dart';
import 'package:mirai_crm/widgets/app_divider.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final String? prefixText;
  final bool showDivider;

  /// Shows a red "View All" label. Ignored if [trailing] is provided.
  final VoidCallback? onViewAll;

  /// Custom trailing widget (e.g. a toggle). Takes precedence over [onViewAll].
  final Widget? trailing;

  const SectionHeader({
    super.key,
    required this.title,
    this.prefixText,
    this.showDivider = false,
    this.onViewAll,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    RS.init(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
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
                    fontSize: RS.FS(15),
                    fontWeight: FontWeight.w600,
                    height: 1,
                    color: CommonColors.red500,
                  ),
                ),
              ),
          ],
        ),
        if (showDivider) ...[
          SizedBox(height: RS.VS(11)),
          AppDivider(indent: 0, endIndent: 0),
        ],
      ],
    );
  }
}
