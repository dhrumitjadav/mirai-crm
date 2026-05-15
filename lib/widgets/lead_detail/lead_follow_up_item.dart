import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mirai_crm/utils/responsive.dart';
import 'package:mirai_crm/utils/common_colors.dart';
import 'package:mirai_crm/utils/common_img.dart';
import 'package:mirai_crm/widgets/lead_detail/lead_detail_models.dart';

class LeadFollowUpItem extends StatelessWidget {
  final LeadFollowUp item;

  const LeadFollowUpItem({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    RS.init(context);
    final isConnected = item.status == LeadFollowUpStatus.connected;

    final String typeLabel = switch (item.type) {
      LeadFollowUpType.call => 'Call',
      LeadFollowUpType.whatsApp => 'WhatsApp',
      LeadFollowUpType.email => 'Email',
      LeadFollowUpType.sms => 'SMS',
      LeadFollowUpType.meeting => 'Meeting',
    };

    final (
      String statusLabel,
      Color statusColor,
      Color statusBgColor,
    ) = switch (item.status) {
      LeadFollowUpStatus.connected => (
        'Connected',
        CommonColors.info500,
        CommonColors.info50,
      ),
      LeadFollowUpStatus.pending => (
        'Pending',
        CommonColors.warning600,
        CommonColors.warning50,
      ),
      LeadFollowUpStatus.newStatus => (
        'New',
        CommonColors.info500,
        CommonColors.info50,
      ),
      LeadFollowUpStatus.followUp => (
        'Follow-up',
        CommonColors.warning600,
        CommonColors.warning50,
      ),
      LeadFollowUpStatus.closed => (
        'Closed',
        CommonColors.grey600,
        CommonColors.grey50,
      ),
      LeadFollowUpStatus.contacted => (
        'Contacted',
        CommonColors.green600,
        CommonColors.green50,
      ),
    };

    return IntrinsicHeight(
      child: Padding(
        padding: EdgeInsets.all(RS.VS(16)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: RS.HS(32),
              child: Column(
                children: [
                  Container(
                    width: RS.HS(32),
                    height: RS.HS(32),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isConnected
                          ? CommonColors.green50
                          : CommonColors.warning50,
                      border: isConnected
                          ? Border.all(color: CommonColors.green600, width: 1)
                          : Border.all(color: CommonColors.warning500, width: 1),
                    ),
                    child: isConnected
                        ? SvgPicture.asset(
                            CommonImg.crmCheckCircleOutlined,
                            colorFilter: const ColorFilter.mode(
                              CommonColors.green600,
                              BlendMode.srcIn,
                            ),
                          )
                        : SvgPicture.asset(
                            fit: BoxFit.scaleDown,
                            CommonImg.crmTimeAltOutlined,
                            colorFilter: const ColorFilter.mode(
                              CommonColors.warning500,
                              BlendMode.srcIn,
                            ),
                          ),
                  ),
                ],
              ),
            ),
            SizedBox(width: RS.HS(10)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                              child: Text(
                                typeLabel,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: RS.FS(14),
                                  fontWeight: FontWeight.w600,
                                  color: CommonColors.textPrimary,
                                ),
                              ),
                            ),
                            SizedBox(width: RS.HS(8)),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: RS.HS(8),
                                vertical: RS.VS(4),
                              ),
                              decoration: BoxDecoration(
                                color: statusBgColor,
                                borderRadius: BorderRadius.circular(7),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: RS.HS(5),
                                    height: RS.HS(5),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: statusColor,
                                    ),
                                  ),
                                  SizedBox(width: RS.HS(4)),
                                  Text(
                                    statusLabel,
                                    style: TextStyle(
                                      fontSize: RS.FS(9),
                                      color: statusColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: RS.HS(8)),
                      Text(
                        item.time,
                        style: TextStyle(
                          fontSize: RS.FS(11),
                          color: CommonColors.textTertiary,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: RS.VS(3)),
                  Text(
                    'By ${item.agent}',
                    style: TextStyle(
                      fontSize: RS.FS(12),
                      color: CommonColors.textTertiary,
                    ),
                  ),
                  SizedBox(height: RS.VS(6)),
                  Text(
                    item.note,
                    style: TextStyle(
                      fontSize: RS.FS(13),
                      color: CommonColors.textSecondary,
                      height: 1.4,
                    ),
                  ),
                  if (item.attachment != null) ...[
                    SizedBox(height: RS.VS(10)),
                    _FollowUpAttachment(file: item.attachment!),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FollowUpAttachment extends StatelessWidget {
  final LeadFile file;

  const _FollowUpAttachment({required this.file});

  @override
  Widget build(BuildContext context) {
    RS.init(context);
    final isAudio = file.type == LeadFileType.audio;
    final String iconPath = switch (file.type) {
      LeadFileType.audio => CommonImg.crmMicOutlined,
      LeadFileType.image => CommonImg.crmImageOutlined,
      _ => CommonImg.crmDocumentOutlined,
    };

    return Container(
      margin: EdgeInsets.symmetric(horizontal: RS.HS(5), vertical: RS.VS(4)),
      padding: EdgeInsets.symmetric(horizontal: RS.HS(5), vertical: RS.VS(4)),
      decoration: BoxDecoration(
        color: CommonColors.info50,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: CommonColors.borderSubtle),
      ),
      child: Row(
        children: [
          Container(
            width: RS.HS(32),
            height: RS.HS(32),
            decoration: BoxDecoration(
              color: CommonColors.info600,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: SvgPicture.asset(
                iconPath,
                width: RS.HS(16),
                height: RS.HS(16),
                colorFilter: const ColorFilter.mode(
                  CommonColors.whiteColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          SizedBox(width: RS.HS(10)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  file.name,
                  style: TextStyle(
                    fontSize: RS.FS(12),
                    fontWeight: FontWeight.w600,
                    color: CommonColors.textPrimary,
                  ),
                ),
                Text(
                  file.meta,
                  style: TextStyle(
                    fontSize: RS.FS(11),
                    color: CommonColors.textTertiary,
                  ),
                ),
              ],
            ),
          ),
          if (isAudio)
            Container(
              width: RS.HS(26),
              height: RS.HS(26),
              decoration: const BoxDecoration(
                color: CommonColors.info600,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: SvgPicture.asset(
                  CommonImg.crmPlayFilled,
                  width: RS.HS(13),
                  height: RS.HS(13),
                  colorFilter: const ColorFilter.mode(
                    CommonColors.whiteColor,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          Container(
            margin: EdgeInsets.only(left: RS.HS(9)),
            width: RS.HS(26),
            height: RS.VS(26),
            decoration: BoxDecoration(
              color: CommonColors.warning50,
              shape: BoxShape.circle,
              border: Border.all(color: CommonColors.warning200),
            ),
            child: Center(
              child: SvgPicture.asset(
                CommonImg.crmTrashOutlined,
                width: RS.HS(13),
                height: RS.HS(13),
                colorFilter: const ColorFilter.mode(
                  CommonColors.warning500,
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
