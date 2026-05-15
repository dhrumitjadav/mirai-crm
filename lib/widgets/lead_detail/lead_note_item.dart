import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mirai_crm/utils/responsive.dart';
import 'package:mirai_crm/utils/common_colors.dart';
import 'package:mirai_crm/utils/common_img.dart';
import 'package:mirai_crm/widgets/lead_detail/lead_detail_models.dart';

class LeadNoteItem extends StatelessWidget {
  final LeadNote note;

  const LeadNoteItem({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    RS.init(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: RS.HS(16), vertical: RS.VS(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (note.isPinned) ...[
                    SvgPicture.asset(
                      CommonImg.crmPushPinFilled,
                      width: RS.HS(18),
                      height: RS.HS(18),
                      colorFilter: const ColorFilter.mode(
                        CommonColors.green600,
                        BlendMode.srcIn,
                      ),
                    ),
                    SizedBox(width: RS.HS(5)),
                  ],
                  Text(
                    note.agent,
                    style: TextStyle(
                      fontSize: RS.FS(14),
                      fontWeight: FontWeight.w600,
                      color: CommonColors.textPrimary,
                    ),
                  ),
                ],
              ),
              Text(
                note.time,
                style: TextStyle(
                  fontSize: RS.FS(12),
                  color: CommonColors.textTertiary,
                ),
              ),
            ],
          ),
          SizedBox(height: RS.VS(6)),
          Text(
            note.text,
            style: TextStyle(
              fontSize: RS.FS(14),
              color: CommonColors.textSecondary,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
