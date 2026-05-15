import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mirai_crm/utils/responsive.dart';
import 'package:mirai_crm/utils/common_colors.dart';
import 'package:mirai_crm/utils/common_dropdown.dart';
import 'package:mirai_crm/utils/common_img.dart';
import 'package:mirai_crm/widgets/lead_detail/lead_detail_models.dart';

class AddFollowUpSheet extends StatefulWidget {
  final void Function(LeadFollowUp item) onSave;

  const AddFollowUpSheet({super.key, required this.onSave});

  @override
  State<AddFollowUpSheet> createState() => _AddFollowUpSheetState();
}

class _AddFollowUpSheetState extends State<AddFollowUpSheet> {
  LeadFollowUpType _type = LeadFollowUpType.call;
  LeadFollowUpStatus _status = LeadFollowUpStatus.pending;
  String? _duration;
  String? _time;
  final _noteCtrl = TextEditingController();
  bool _hasRecording = false;

  static const _durations = ['15 min', '30 min', '45 min', '1 hour', '2 hours'];
  static const _times = [
    '9:00 AM',
    '10:00 AM',
    '11:00 AM',
    '12:00 PM',
    '1:00 PM',
    '2:00 PM',
    '3:00 PM',
    '4:00 PM',
    '5:00 PM',
  ];
  static const _sheetStatuses = [
    LeadFollowUpStatus.pending,
    LeadFollowUpStatus.newStatus,
    LeadFollowUpStatus.followUp,
    LeadFollowUpStatus.closed,
    LeadFollowUpStatus.contacted,
  ];

  @override
  void dispose() {
    _noteCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    RS.init(context);
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        decoration: const BoxDecoration(
          color: CommonColors.whiteColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: CommonColors.borderDefault),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: CommonColors.blackColor.withValues(alpha: 0.08),
                      offset: Offset(0, 2),
                      blurRadius: 2,
                      blurStyle: BlurStyle.outer,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Center(
                      child: Container(
                        margin: EdgeInsets.only(top: RS.VS(10)),
                        width: RS.HS(36),
                        height: RS.VS(4),
                        decoration: BoxDecoration(
                          color: CommonColors.grey300,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                        RS.HS(16),
                        RS.VS(16),
                        RS.HS(16),
                        RS.VS(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Follow-ups',
                            style: TextStyle(
                              fontSize: RS.FS(16),
                              fontWeight: FontWeight.w700,
                              color: CommonColors.textPrimary,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              width: RS.HS(28),
                              height: RS.HS(28),
                              decoration: BoxDecoration(
                                color: CommonColors.grey100,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                Icons.close,
                                size: RS.HS(16),
                                color: CommonColors.textSecondary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: RS.HS(16),
                  vertical: RS.VS(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _sheetLabel('Activity Type'),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children:
                            [
                              LeadFollowUpType.call,
                              LeadFollowUpType.whatsApp,
                              LeadFollowUpType.email,
                              LeadFollowUpType.sms,
                            ].map((type) {
                              final label = _typeName(type);
                              final selected = _type == type;
                              return GestureDetector(
                                onTap: () => setState(() => _type = type),
                                child: Container(
                                  margin: EdgeInsets.only(right: RS.HS(8)),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: RS.HS(20),
                                    vertical: RS.VS(8),
                                  ),
                                  decoration: BoxDecoration(
                                    color: selected
                                        ? CommonColors.info50
                                        : CommonColors.whiteColor,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: selected
                                          ? CommonColors.info600
                                          : CommonColors.borderStrong,
                                    ),
                                  ),
                                  child: Text(
                                    label,
                                    style: TextStyle(
                                      fontSize: RS.FS(13),
                                      fontWeight: selected
                                          ? FontWeight.w600
                                          : FontWeight.w500,
                                      color: selected
                                          ? CommonColors.info600
                                          : CommonColors.textSecondary,
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                      ),
                    ),
                    SizedBox(height: RS.VS(16)),
                    _sheetLabel('When'),
                    Row(
                      children: [
                        Expanded(
                          child: CommonDropdown(
                            hint: 'Duration',
                            value: _duration,
                            items: _durations,
                            onChanged: (v) => setState(() => _duration = v),
                          ),
                        ),
                        SizedBox(width: RS.HS(12)),
                        Expanded(
                          child: CommonDropdown(
                            hint: 'Time',
                            value: _time,
                            items: _times,
                            onChanged: (v) => setState(() => _time = v),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: RS.VS(16)),
                    _sheetLabel('Status'),
                    Wrap(
                      spacing: RS.HS(8),
                      runSpacing: RS.VS(8),
                      children: _sheetStatuses.map((status) {
                        final label = _statusName(status);
                        final selected = _status == status;
                        return GestureDetector(
                          onTap: () => setState(() => _status = status),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: RS.HS(12),
                              vertical: RS.VS(6),
                            ),
                            decoration: BoxDecoration(
                              color: selected
                                  ? CommonColors.red50
                                  : CommonColors.whiteColor,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: selected
                                    ? CommonColors.red300
                                    : CommonColors.borderStrong,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: RS.HS(6),
                                  height: RS.HS(6),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: selected
                                        ? CommonColors.red500
                                        : CommonColors.grey550,
                                  ),
                                ),
                                SizedBox(width: RS.HS(5)),
                                Text(
                                  label,
                                  style: TextStyle(
                                    fontSize: RS.FS(13),
                                    color: selected
                                        ? CommonColors.red500
                                        : CommonColors.textTertiary,
                                    fontWeight: selected
                                        ? FontWeight.w600
                                        : FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: RS.VS(16)),
                    _sheetLabel('Notes (optional)'),
                    TextField(
                      controller: _noteCtrl,
                      maxLines: 4,
                      style: TextStyle(
                        fontSize: RS.FS(14),
                        color: CommonColors.textPrimary,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Write a Note about this Lead...',
                        hintStyle: TextStyle(
                          fontSize: RS.FS(14),
                          color: CommonColors.textPlaceholder,
                        ),
                        filled: true,
                        fillColor: CommonColors.whiteColor,
                        contentPadding: EdgeInsets.all(RS.HS(12)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: CommonColors.borderDefault,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: CommonColors.borderDefault,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                            color: CommonColors.borderFocus,
                            width: 1.5,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: RS.VS(16)),
                    _sheetLabel('Attachment'),
                    Row(
                      children: [
                        Expanded(
                          child: _buildAttachmentTile(
                            icon: CommonImg.crmMicOutlined,
                            color: CommonColors.info600,
                            label: 'Attach Recording',
                            bgColor: CommonColors.info50,
                            sublabel: 'MP3, MP4, Wav · Max 50 MB',
                            onTap: () =>
                                setState(() => _hasRecording = !_hasRecording),
                          ),
                        ),
                        SizedBox(width: RS.HS(12)),
                        Expanded(
                          child: _buildAttachmentTile(
                            icon: CommonImg.crmDocumentOutlined,
                            color: CommonColors.warning600,
                            bgColor: CommonColors.warning50,
                            label: 'Attach File',
                            sublabel: 'PDF, Max 50 MB',
                            onTap: () {},
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: RS.VS(20)),
                    SizedBox(
                      width: double.infinity,
                      height: RS.VS(52),
                      child: ElevatedButton(
                        onPressed: () {
                          final parts = [
                            _duration,
                            _time,
                          ].whereType<String>().join(', ');
                          widget.onSave(
                            LeadFollowUp(
                              type: _type,
                              status: _status,
                              time: parts.isEmpty ? 'Just now' : parts,
                              agent: 'Agent 1',
                              note: _noteCtrl.text.trim().isEmpty
                                  ? 'No notes.'
                                  : _noteCtrl.text.trim(),
                              attachment: _hasRecording
                                  ? const LeadFile(
                                      name: 'Recording.mp3',
                                      meta: '—',
                                      type: LeadFileType.audio,
                                    )
                                  : null,
                            ),
                          );
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: CommonColors.primaryColor,
                          foregroundColor: CommonColors.whiteColor,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Save Follow-up',
                          style: TextStyle(
                            fontSize: RS.FS(16),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: RS.VS(24) + MediaQuery.of(context).padding.bottom,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sheetLabel(String text) {
    return Column(
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: RS.FS(14),
            fontWeight: FontWeight.w600,
            color: CommonColors.textPrimary,
          ),
        ),
        SizedBox(height: RS.VS(8)),
      ],
    );
  }

  Widget _buildAttachmentTile({
    required String icon,
    required Color color,
    required Color bgColor,
    required String label,
    required String sublabel,
    // required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: CustomPaint(
        foregroundPainter: _DashedBorderPainter(color: color),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: RS.HS(8),
            vertical: RS.VS(16),
          ),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Container(
                width: RS.HS(44),
                height: RS.HS(44),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    icon,
                    width: RS.HS(24),
                    height: RS.HS(24),
                    colorFilter: ColorFilter.mode(
                      CommonColors.whiteColor,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
              SizedBox(height: RS.VS(8)),
              Text(
                label,
                style: TextStyle(
                  fontSize: RS.FS(13),
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
              SizedBox(height: RS.VS(2)),
              Text(
                sublabel,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: RS.FS(10),
                  color: CommonColors.textTertiary,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _typeName(LeadFollowUpType t) => switch (t) {
    LeadFollowUpType.call => 'Call',
    LeadFollowUpType.whatsApp => 'WhatsApp',
    LeadFollowUpType.email => 'Email',
    LeadFollowUpType.sms => 'SMS',
    LeadFollowUpType.meeting => 'Meeting',
  };

  String _statusName(LeadFollowUpStatus s) => switch (s) {
    LeadFollowUpStatus.connected => 'Connected',
    LeadFollowUpStatus.pending => 'Pending',
    LeadFollowUpStatus.newStatus => 'New',
    LeadFollowUpStatus.followUp => 'Follow-up',
    LeadFollowUpStatus.closed => 'Closed',
    LeadFollowUpStatus.contacted => 'Contacted',
  };

  // Color _statusChipColor(LeadFollowUpStatus s) => switch (s) {
  //   LeadFollowUpStatus.connected => CommonColors.appGreenColor,
  //   LeadFollowUpStatus.pending => CommonColors.orangeColor,
  //   LeadFollowUpStatus.newStatus => CommonColors.info500,
  //   LeadFollowUpStatus.followUp => CommonColors.warning600,
  //   LeadFollowUpStatus.closed => CommonColors.textTertiary,
  //   LeadFollowUpStatus.contacted => CommonColors.info500,
  // };
}

class _DashedBorderPainter extends CustomPainter {
  final Color color;

  const _DashedBorderPainter({required this.color});

  static const double _radius = 12;
  static const double _dashWidth = 5;
  static const double _gapWidth = 4;
  static const double _strokeWidth = 1.5;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = _strokeWidth
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(
            _strokeWidth / 2,
            _strokeWidth / 2,
            size.width - _strokeWidth,
            size.height - _strokeWidth,
          ),
          const Radius.circular(_radius),
        ),
      );

    for (final metric in path.computeMetrics()) {
      double offset = 0;
      while (offset < metric.length) {
        canvas.drawPath(metric.extractPath(offset, offset + _dashWidth), paint);
        offset += _dashWidth + _gapWidth;
      }
    }
  }

  @override
  bool shouldRepaint(_DashedBorderPainter o) => o.color != color;
}
