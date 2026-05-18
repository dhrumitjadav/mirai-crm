import 'package:flutter/material.dart';
import 'package:mirai_crm/utils/common_colors.dart';
import 'package:mirai_crm/utils/responsive.dart';
import 'package:mirai_crm/widgets/app_divider.dart';
import 'package:mirai_crm/widgets/section_header.dart';

class AppCard extends StatelessWidget {
  final String? title;
  final String? prefixText;
  final VoidCallback? onViewAll;
  final Widget? trailing;
  final bool showDivider;
  final double radius;
  final Color? borderColor;
  final Widget child;

  const AppCard({
    super.key,
    this.title,
    this.prefixText,
    this.onViewAll,
    this.trailing,
    this.showDivider = false,
    this.radius = 14,
    this.borderColor,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    RS.init(context);
    return Container(
      decoration: BoxDecoration(
        color: CommonColors.whiteColor,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: borderColor ?? CommonColors.borderDefault),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            Padding(
              padding: EdgeInsets.fromLTRB(
                RS.HS(18),
                RS.VS(16),
                RS.HS(18),
                RS.VS(11),
              ),
              child: SectionHeader(
                title: title!,
                prefixText: prefixText,
                onViewAll: onViewAll,
                trailing: trailing,
              ),
            ),
            if (showDivider)
              AppDivider(indent: RS.HS(14), endIndent: RS.HS(14)),
          ],
          child,
        ],
      ),
    );
  }
}
