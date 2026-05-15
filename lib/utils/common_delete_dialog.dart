import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mirai_crm/utils/responsive.dart';
import 'package:mirai_crm/utils/common_colors.dart';
import 'package:mirai_crm/utils/common_img.dart';

Future<bool> showDeleteDialog(
  BuildContext context, {
  required String title,
  required String description,
}) async {
  return await showDialog<bool>(
        context: context,
        barrierDismissible: true,
        builder: (_) => _DeleteDialog(title: title, description: description),
      ) ??
      false;
}

class _DeleteDialog extends StatelessWidget {
  final String title;
  final String description;

  const _DeleteDialog({required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    RS.init(context);
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: CommonColors.whiteColor,
      child: Padding(
        padding: EdgeInsets.all(RS.HS(16)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon
            Container(
              width: RS.HS(54),
              height: RS.HS(54),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: CommonColors.primaryColor, width: 1),
                color: CommonColors.primaryColor.withValues(alpha: 0.06),
              ),
              child: Center(
                child: Container(
                  width: RS.HS(44),
                  height: RS.HS(44),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: CommonColors.primaryColor,
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      CommonImg.crmTrashOutlined,
                      width: RS.HS(20),
                      height: RS.HS(20),
                      colorFilter: const ColorFilter.mode(
                        CommonColors.whiteColor,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: RS.VS(20)),
            // Title
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: RS.FS(18),
                fontWeight: FontWeight.w600,
                color: CommonColors.textPrimary,
              ),
            ),
            SizedBox(height: RS.VS(8)),
            // Description
            Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: RS.FS(13),
                color: CommonColors.textTertiary,
              ),
            ),
            SizedBox(height: RS.VS(16)),
            // Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context, false),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: CommonColors.textPrimary,
                      side: const BorderSide(color: CommonColors.borderDefault),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.symmetric(vertical: RS.VS(14)),
                    ),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        fontSize: RS.FS(14),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: RS.HS(12)),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context, true),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: CommonColors.primaryColor,
                      foregroundColor: CommonColors.whiteColor,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.symmetric(vertical: RS.VS(14)),
                    ),
                    child: Text(
                      'Yes Delete',
                      style: TextStyle(
                        fontSize: RS.FS(14),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
