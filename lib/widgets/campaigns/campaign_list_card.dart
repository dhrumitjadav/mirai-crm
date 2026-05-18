import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mirai_crm/utils/common_img.dart';
import 'package:mirai_crm/utils/responsive.dart';
import 'package:mirai_crm/utils/common_colors.dart';

class CampaignItem {
  final String title;
  final String dateRange;
  final String type;
  final String status;
  final List<CampaignMember> members;
  final int extraMembers;
  final int memberCount;
  final int teamCount;
  final String progressLabel;
  final int converted;
  final int total;

  const CampaignItem({
    required this.title,
    required this.dateRange,
    required this.type,
    required this.status,
    required this.members,
    required this.extraMembers,
    required this.memberCount,
    required this.teamCount,
    required this.progressLabel,
    required this.converted,
    required this.total,
  });
}

class CampaignMember {
  final String initials;
  final Color color;

  const CampaignMember({required this.initials, required this.color});
}

({Color bg, Color text}) _statusColors(String status) => switch (status) {
  'Active' => (bg: CommonColors.success50, text: CommonColors.success700),
  'Paused' => (bg: CommonColors.warning50, text: CommonColors.warning700),
  'Scheduled' => (bg: CommonColors.info50, text: CommonColors.info600),
  'Draft' => (bg: CommonColors.grey100, text: CommonColors.textSecondary),
  'Hold' => (bg: CommonColors.red50, text: CommonColors.red700),
  _ => (bg: CommonColors.grey100, text: CommonColors.textSecondary),
};

// ── Card ──────────────────────────────────────────────────────────────────────

class CampaignListCard extends StatelessWidget {
  final CampaignItem campaign;
  final VoidCallback? onTap;

  const CampaignListCard({super.key, required this.campaign, this.onTap});

  @override
  Widget build(BuildContext context) {
    RS.init(context);
    final progress = campaign.total > 0
        ? campaign.converted / campaign.total
        : 0.0;
    return GestureDetector(
      onTap: onTap,
      child: Container(
      margin: EdgeInsets.only(bottom: RS.VS(12)),
      decoration: BoxDecoration(
        color: CommonColors.whiteColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: CommonColors.borderSubtle),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(
              RS.HS(20),
              RS.VS(20),
              RS.HS(20),
              RS.VS(14),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: RS.HS(63),
                  height: RS.HS(63),
                  decoration: BoxDecoration(
                    color: CommonColors.info50,
                    borderRadius: BorderRadius.circular(RS.HS(14)),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      CommonImg.crmMegaphoneOutlined,
                      width: RS.HS(26),
                      height: RS.HS(26),
                      colorFilter: const ColorFilter.mode(
                        CommonColors.info600,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: RS.HS(14)),
                Expanded(
                  child: Column(
                    spacing: 0,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        campaign.title,
                        style: TextStyle(
                          fontSize: RS.FS(15),
                          height: 1.0,
                          fontWeight: FontWeight.w600,
                          color: CommonColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: RS.VS(8)),
                      Text(
                        campaign.dateRange,
                        style: TextStyle(
                          fontSize: RS.FS(12),
                          height: 1.0,
                          fontWeight: FontWeight.w500,
                          color: CommonColors.textTertiary,
                        ),
                      ),
                      SizedBox(height: RS.VS(8)),
                      _TypeChip(label: campaign.type),
                    ],
                  ),
                ),
                SizedBox(width: RS.HS(8)),
                Builder(
                  builder: (_) {
                    final sc = _statusColors(campaign.status);
                    return Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: RS.HS(10),
                        vertical: RS.VS(8.5),
                      ),
                      decoration: BoxDecoration(
                        color: sc.bg,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: RS.HS(6),
                            height: RS.HS(6),
                            decoration: BoxDecoration(
                              color: sc.text,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: RS.HS(4)),
                          Text(
                            campaign.status,
                            style: TextStyle(
                              fontSize: RS.FS(11),
                              fontWeight: FontWeight.w500,
                              color: sc.text,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
              RS.HS(20),
              RS.VS(0),
              RS.HS(20),
              RS.VS(20),
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    _AvatarStack(
                      members: campaign.members,
                      extra: campaign.extraMembers,
                    ),
                    SizedBox(width: RS.HS(10)),
                    Container(
                      width: 1,
                      height: RS.VS(28),
                      color: CommonColors.borderDefault,
                    ),
                    SizedBox(width: RS.HS(10)),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${campaign.memberCount} members',
                          style: TextStyle(
                            fontSize: RS.FS(12),
                            fontWeight: FontWeight.w500,
                            color: CommonColors.textPrimary,
                          ),
                        ),
                        Text(
                          '${campaign.teamCount} Team',
                          style: TextStyle(
                            fontSize: RS.FS(11),
                            fontWeight: FontWeight.w500,
                            color: CommonColors.textTertiary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: RS.VS(10)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      campaign.progressLabel,
                      style: TextStyle(
                        fontSize: RS.FS(12),
                        color: CommonColors.textTertiary,
                      ),
                    ),
                    Text(
                      '${campaign.converted}/${campaign.total}',
                      style: TextStyle(
                        fontSize: RS.FS(13),
                        fontWeight: FontWeight.w600,
                        color: CommonColors.success600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: RS.VS(6)),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: RS.VS(6),
                    borderRadius: BorderRadius.all(Radius.circular(3)),
                    backgroundColor: CommonColors.grey200,
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      CommonColors.success600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
    );
  }
}

// ── Type chip ─────────────────────────────────────────────────────────────────

class _TypeChip extends StatelessWidget {
  final String label;

  const _TypeChip({required this.label});

  @override
  Widget build(BuildContext context) {
    RS.init(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: RS.HS(12), vertical: RS.VS(5)),
      decoration: BoxDecoration(
        border: Border.all(color: CommonColors.borderSubtle),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: RS.FS(10),
          height: 1,
          fontWeight: FontWeight.w500,
          color: CommonColors.textSecondary,
        ),
      ),
    );
  }
}

// ── Avatar stack ──────────────────────────────────────────────────────────────

class _AvatarStack extends StatelessWidget {
  final List<CampaignMember> members;
  final int extra;

  static const _avatarColors = [
    Color(0xFF60A5FA),
    Color(0xFFFB923C),
    Color(0xFF4ADE80),
  ];

  const _AvatarStack({required this.members, required this.extra});

  @override
  Widget build(BuildContext context) {
    RS.init(context);
    final double size = RS.HS(26);
    final double overlap = RS.HS(9);

    final visible = members.take(3).toList();
    final totalExtra = (members.length - visible.length) + extra;
    final showExtra = totalExtra > 0;

    final int slotCount = visible.length + (showExtra ? 1 : 0);
    final double width =
        slotCount == 0 ? 0 : size + (slotCount - 1) * (size - overlap);

    return SizedBox(
      width: width,
      height: size,
      child: Stack(
        children: [
          ...visible.asMap().entries.map(
            (e) => Positioned(
              left: e.key * (size - overlap),
              child: _circle(
                size: size,
                bg: _avatarColors[e.key % _avatarColors.length],
                text: e.value.initials,
                textColor: CommonColors.whiteColor,
              ),
            ),
          ),
          if (showExtra)
            Positioned(
              left: visible.length * (size - overlap),
              child: _circle(
                size: size,
                bg: const Color(0xFFF3F4F6),
                text: '+$totalExtra',
                textColor: CommonColors.textSecondary,
              ),
            ),
        ],
      ),
    );
  }

  Widget _circle({
    required double size,
    required Color bg,
    required String text,
    required Color textColor,
  }) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: bg,
        shape: BoxShape.circle,
        border: Border.all(color: CommonColors.whiteColor, width: 1.5),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: RS.FS(10),
            fontWeight: FontWeight.w500,
            color: CommonColors.blackColor,
          ),
        ),
      ),
    );
  }
}
