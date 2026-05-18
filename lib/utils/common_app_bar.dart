import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:mirai_crm/utils/responsive.dart';
import 'package:mirai_crm/utils/common_colors.dart';
import 'package:mirai_crm/utils/common_img.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final PreferredSizeWidget? bottom;
  final List<Widget>? actions;

  const CommonAppBar({
    super.key,
    required this.title,
    this.bottom,
    this.actions,
  });

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + (bottom?.preferredSize.height ?? 0));

  @override
  Widget build(BuildContext context) {
    RS.init(context);
    return AppBar(
      leading: GestureDetector(
        onTap: () => Get.back(),
        child: Center(
          child: Container(
            width: RS.HS(32),
            height: RS.HS(32),
            decoration: BoxDecoration(
              color: CommonColors.grey75,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: SvgPicture.asset(
                CommonImg.crmArrowLeftOutlined,
                width: RS.HS(12),
                height: RS.HS(12),
                colorFilter: const ColorFilter.mode(
                  CommonColors.textPrimary,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ),
      ),
      centerTitle: true,
      title: Text(
        title,
        style: TextStyle(
          color: CommonColors.textSecondary,
          fontWeight: FontWeight.w600,
          height: 1.0,
          fontSize: RS.FS(18),
        ),
      ),
      bottom: bottom,
      actions: actions,
    );
  }
}
