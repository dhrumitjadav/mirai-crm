import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mirai_crm/utils/responsive.dart';
import 'package:mirai_crm/utils/common_colors.dart';
import 'package:mirai_crm/utils/common_delete_dialog.dart';
import 'package:mirai_crm/utils/common_img.dart';
import 'package:mirai_crm/widgets/lead_detail/lead_detail_models.dart';

class LeadFileItem extends StatelessWidget {
  final LeadFile file;
  final int index;
  final void Function(int index) onDelete;

  const LeadFileItem({
    super.key,
    required this.file,
    required this.index,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    RS.init(context);
    final isAudio = file.type == LeadFileType.audio;
    final (Color iconBg, String iconPath) = switch (file.type) {
      LeadFileType.audio => (CommonColors.red600, CommonImg.crmMicOutlined),
      LeadFileType.image => (
        CommonColors.primaryGradientEnd,
        CommonImg.crmImageOutlined,
      ),
      _ => (CommonColors.warning600, CommonImg.crmDocumentOutlined),
    };

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: RS.HS(16), vertical: RS.VS(12)),
      child: Row(
        children: [
          Container(
            width: RS.HS(40),
            height: RS.HS(40),
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: SvgPicture.asset(
                iconPath,
                width: RS.HS(20),
                height: RS.HS(20),
                colorFilter: const ColorFilter.mode(
                  CommonColors.whiteColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          SizedBox(width: RS.HS(12)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  file.name,
                  style: TextStyle(
                    fontSize: RS.FS(15),
                    fontWeight: FontWeight.w600,
                    color: CommonColors.textPrimary,
                  ),
                ),
                SizedBox(height: RS.VS(2)),
                Text(
                  file.meta,
                  style: TextStyle(
                    fontSize: RS.FS(13),
                    color: CommonColors.textTertiary,
                  ),
                ),
              ],
            ),
          ),
          if (isAudio) ...[
            Container(
              width: RS.HS(30),
              height: RS.HS(30),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: CommonColors.info50)
              ),
              child: Center(
                child: SvgPicture.asset(
                  CommonImg.crmPlayFilled,
                  width: RS.HS(18),
                  height: RS.HS(18),
                  colorFilter: const ColorFilter.mode(
                    CommonColors.info500,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            SizedBox(width: RS.HS(8)),
          ],
          GestureDetector(
            onTap: () async {
              final confirmed = await showDeleteDialog(
                context,
                title: 'Delete ${file.name}?',
                description:
                    'This file will be permanently removed from this lead. This cannot be undone.',
              );
              if (confirmed) onDelete(index);
            },
            child: Container(

              padding: EdgeInsets.all(RS.HS(8)),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: CommonColors.red50,
              ),
              child: SvgPicture.asset(
                CommonImg.crmTrashOutlined,
                width: RS.HS(18),
                height: RS.HS(18),
                colorFilter: const ColorFilter.mode(
                  CommonColors.primaryColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
