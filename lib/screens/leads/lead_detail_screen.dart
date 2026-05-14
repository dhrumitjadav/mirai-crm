import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mirai_crm/utils/app_size.dart';
import 'package:mirai_crm/utils/common_app_bar.dart';
import 'package:mirai_crm/utils/common_colors.dart';
import 'package:mirai_crm/utils/common_delete_dialog.dart';
import 'package:mirai_crm/utils/common_img.dart';
import 'package:mirai_crm/widgets/app_divider.dart';
import 'package:mirai_crm/widgets/section_header.dart';

class LeadDetailScreen extends StatefulWidget {
  const LeadDetailScreen({super.key});

  @override
  State<LeadDetailScreen> createState() => _LeadDetailScreenState();
}

enum _FileType { pdf, audio, image, other }

class _FileItem {
  final String name;
  final String meta;
  final _FileType type;

  const _FileItem({required this.name, required this.meta, required this.type});
}

class _NoteItem {
  final String agent;
  final String time;
  final String text;
  final bool isPinned;

  const _NoteItem({
    required this.agent,
    required this.time,
    required this.text,
    this.isPinned = false,
  });
}

enum _FollowUpType { call, whatsApp, email, sms, meeting }

enum _FollowUpStatus {
  connected,
  pending,
  newStatus,
  followUp,
  closed,
  contacted,
}

class _FollowUpItem {
  final _FollowUpType type;
  final _FollowUpStatus status;
  final String time;
  final String agent;
  final String note;
  final _FileItem? attachment;

  const _FollowUpItem({
    required this.type,
    required this.status,
    required this.time,
    required this.agent,
    required this.note,
    this.attachment,
  });
}

class _LeadDetailScreenState extends State<LeadDetailScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  final List<_FileItem> _files = [
    const _FileItem(
      name: 'Proposal-x2.pdf',
      meta: '420kb',
      type: _FileType.pdf,
    ),
    const _FileItem(
      name: 'Call-Yesterday.mp3',
      meta: '12min · 4.5MB',
      type: _FileType.audio,
    ),
    const _FileItem(
      name: 'Brochure-2024.pdf',
      meta: '15MB',
      type: _FileType.pdf,
    ),
  ];

  final List<_NoteItem> _notes = [
    const _NoteItem(
      agent: 'Agent 1',
      time: 'Today, 10:30 AM',
      text:
          'Prefers afternoon calls. Mentioned current vendor contract ends in March.',
      isPinned: true,
    ),
    const _NoteItem(
      agent: 'Agent 1',
      time: 'Yesterday, 04:55 PM',
      text:
          'Prefers afternoon calls. Mentioned current vendor contract ends in March.',
    ),
  ];

  final List<_FollowUpItem> _followUps = [
    const _FollowUpItem(
      type: _FollowUpType.call,
      status: _FollowUpStatus.connected,
      time: 'Today, 10:30 AM',
      agent: 'Redpoll Michel',
      note: 'Discussed pricing, sending proposal.',
      attachment: _FileItem(
        name: 'Call-Yesterday.mp3',
        meta: '12min · 4.5MB',
        type: _FileType.audio,
      ),
    ),
    const _FollowUpItem(
      type: _FollowUpType.whatsApp,
      status: _FollowUpStatus.connected,
      time: 'Yesterday, 04:30 AM',
      agent: 'Agent 1',
      note: 'Shared product Video',
    ),
    const _FollowUpItem(
      type: _FollowUpType.meeting,
      status: _FollowUpStatus.pending,
      time: 'Tomorrow, 11:30 AM',
      agent: 'Agent 1',
      note: 'Discussed pricing, sending proposal.',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CommonColors.scaffoldBgColor,
      appBar: CommonAppBar(title: 'Lead Details'),
      body: Column(
        children: [
          Container(
            color: CommonColors.whiteColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildProfile(context),
                _buildActionButtons(context),
                _buildTabBar(context),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildDetailsTab(),
                _buildNotesTab(),
                _buildFilesTab(),
                _buildFollowUpsTab(),
                _buildPlaceholderTab('Activity'),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomBar(context),
    );
  }

  Widget _buildProfile(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        context.w(16),
        context.h(16),
        context.w(16),
        context.h(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: context.w(62),
                height: context.w(62),
                decoration: BoxDecoration(
                  color: CommonColors.red50,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Center(
                  child: Text(
                    'MR',
                    style: TextStyle(
                      fontSize: context.s(14),
                      fontWeight: FontWeight.w600,
                      color: CommonColors.red600,
                    ),
                  ),
                ),
              ),
              SizedBox(width: context.w(12)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Michael Rodriguez',
                      style: TextStyle(
                        fontSize: context.s(18),
                        fontWeight: FontWeight.w600,
                        color: CommonColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: context.h(2)),
                    Text(
                      '+1 415 555-1451',
                      style: TextStyle(
                        fontSize: context.s(14),
                        fontWeight: FontWeight.w500,
                        color: CommonColors.textTertiary,
                      ),
                    ),
                    Text(
                      'm.rodriguez23@gmail.com',
                      style: TextStyle(
                        fontSize: context.s(14),
                        fontWeight: FontWeight.w500,
                        color: CommonColors.textTertiary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: context.h(12)),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildTag(
                  context,
                  label: 'Contacted',
                  isStatus: true,
                  statusColor: CommonColors.info500,
                ),
                SizedBox(width: context.w(10)),
                _buildTag(
                  context,
                  icon: CommonImg.crmMegaphoneOutlined,
                  label: 'Q4 Spring Sale',
                ),
                SizedBox(width: context.w(10)),
                _buildTag(
                  context,
                  icon: CommonImg.crmPersonOutlined,
                  label: 'Agent 1',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTag(
    BuildContext context, {
    String? icon,
    required String label,
    bool isStatus = false,
    Color statusColor = CommonColors.textSecondary,
  }) {
    final textColor = isStatus ? statusColor : CommonColors.textSecondary;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.w(20),
        vertical: context.h(8),
      ),
      decoration: BoxDecoration(
        color: isStatus ? CommonColors.info50 : CommonColors.grey75,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isStatus ? CommonColors.info500 : Colors.transparent,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isStatus)
            Container(
              width: context.w(6),
              height: context.w(6),
              margin: EdgeInsets.only(right: context.w(5)),
              decoration: BoxDecoration(
                color: statusColor,
                shape: BoxShape.circle,
              ),
            )
          else if (icon != null) ...[
            SvgPicture.asset(
              icon,
              width: context.w(12),
              height: context.w(12),
              colorFilter: const ColorFilter.mode(
                CommonColors.textTertiary,
                BlendMode.srcIn,
              ),
            ),
            SizedBox(width: context.w(5)),
          ],
          Text(
            label,
            style: TextStyle(
              fontSize: context.s(12),
              fontWeight: FontWeight.w500,
              color: textColor,
            ),
          ),
          SizedBox(width: context.w(3)),
          if (!isStatus)
            SvgPicture.asset(
              CommonImg.crmArrowRightOutlined,
              width: context.w(10),
              height: context.w(10),
              colorFilter: ColorFilter.mode(
                isStatus ? statusColor : CommonColors.textTertiary,
                BlendMode.srcIn,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        context.w(16),
        context.h(4),
        context.w(16),
        context.h(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: _ActionButton(
              svgPath: CommonImg.crmPhoneOutlined,
              color: CommonColors.info500,
            ),
          ),
          SizedBox(width: context.w(12)),
          Expanded(
            child: _ActionButton(
              svgPath: CommonImg.crmWhatsappOutlined,
              color: CommonColors.green500,
            ),
          ),
          SizedBox(width: context.w(12)),
          Expanded(
            child: _ActionButton(
              svgPath: CommonImg.crmMailOutlined,
              color: CommonColors.warning600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar(BuildContext context) {
    return TabBar(
      controller: _tabController,
      isScrollable: true,
      tabAlignment: TabAlignment.start,
      indicatorColor: CommonColors.primaryColor,
      indicatorSize: TabBarIndicatorSize.tab,
      indicatorWeight: 2,
      labelColor: CommonColors.primaryColor,
      unselectedLabelColor: CommonColors.textTertiary,
      labelStyle: TextStyle(
        fontSize: context.s(13),
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: context.s(13),
        fontWeight: FontWeight.w400,
      ),
      dividerColor: CommonColors.borderSubtle,
      tabs: const [
        Tab(text: 'Details'),
        Tab(text: 'Notes'),
        Tab(text: 'Files'),
        Tab(text: 'Follow-ups'),
        Tab(text: 'Activity'),
      ],
    );
  }

  Widget _buildDetailsTab() {
    return Builder(
      builder: (context) => SingleChildScrollView(
        padding: EdgeInsets.all(context.w(16)),
        child: Column(
          children: [
            _buildInfoCard(
              context,
              title: 'Custom Information',
              rows: const [
                ('Info 1', 'Detail 1'),
                ('Info 2', 'Detail 2'),
                ('Info 3', 'Detail 3'),
              ],
            ),
            SizedBox(height: context.h(16)),
            _buildInfoCard(
              context,
              title: 'Lead Information',
              trailing: Text(
                'Edit',
                style: TextStyle(
                  fontSize: context.s(13),
                  fontWeight: FontWeight.w500,
                  color: CommonColors.primaryColor,
                ),
              ),
              rows: const [
                ('Budget', '\$5,000–\$10,000'),
                ('Location', 'San Francisco, CA'),
                ('Source', 'Facebook Ad'),
                ('Priority', 'High'),
                ('Created', 'Yesterday, 04:10 PM'),
              ],
            ),
            SizedBox(height: context.h(16)),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(
    BuildContext context, {
    required String title,
    Widget? trailing,
    required List<(String, String)> rows,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: CommonColors.whiteColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: CommonColors.borderSubtle),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(
              context.w(18),
              context.h(16),
              context.w(18),
              context.h(11),
            ),
            child: SectionHeader(title: title, trailing: trailing),
          ),
          ...rows.indexed.map(
            (entry) => Column(
              children: [
                _buildInfoRow(context, entry.$2.$1, entry.$2.$2),
                if (entry.$1 < rows.length - 1)
                  AppDivider(indent: context.w(16), endIndent: context.w(16)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.w(18),
        vertical: context.h(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: context.s(14),
              fontWeight: FontWeight.w500,
              color: CommonColors.textTertiary,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: context.s(14),
              fontWeight: FontWeight.w500,
              color: CommonColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNotesTab() {
    return Builder(
      builder: (context) => SingleChildScrollView(
        padding: EdgeInsets.all(context.w(16)),
        child: Container(
          decoration: BoxDecoration(
            color: CommonColors.whiteColor,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: CommonColors.borderSubtle),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(context.w(16)),
                child: SectionHeader(
                  title: 'Notes (${_notes.length})',
                  prefixText: '+ Add new',
                  onViewAll: () => _showAddNoteSheet(context),
                ),
              ),
              AppDivider(indent: 18, endIndent: 18),
              ..._notes.indexed.map(
                (entry) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildNoteItem(context, entry.$2),
                    if (entry.$1 < _notes.length - 1)
                      AppDivider(indent: 18, endIndent: 18),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNoteItem(BuildContext context, _NoteItem note) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.w(16),
        vertical: context.h(12),
      ),
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
                      width: context.w(18),
                      height: context.w(18),
                      colorFilter: const ColorFilter.mode(
                        CommonColors.green600,
                        BlendMode.srcIn,
                      ),
                    ),
                    SizedBox(width: context.w(5)),
                  ],
                  Text(
                    note.agent,
                    style: TextStyle(
                      fontSize: context.s(14),
                      fontWeight: FontWeight.w600,
                      color: CommonColors.textPrimary,
                    ),
                  ),
                ],
              ),
              Text(
                note.time,
                style: TextStyle(
                  fontSize: context.s(12),
                  color: CommonColors.textTertiary,
                ),
              ),
            ],
          ),
          SizedBox(height: context.h(6)),
          Text(
            note.text,
            style: TextStyle(
              fontSize: context.s(14),
              color: CommonColors.textSecondary,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  void _showAddNoteSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _AddNoteSheet(
        onSave: (text, isPinned) {
          setState(() {
            final note = _NoteItem(
              agent: 'Agent 1',
              time: 'Just now',
              text: text,
              isPinned: isPinned,
            );
            if (isPinned) {
              _notes.insert(0, note);
            } else {
              _notes.add(note);
            }
          });
        },
      ),
    );
  }

  Widget _buildFilesTab() {
    return Builder(
      builder: (context) => SingleChildScrollView(
        padding: EdgeInsets.all(context.w(16)),
        child: Container(
          decoration: BoxDecoration(
            color: CommonColors.whiteColor,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: CommonColors.borderSubtle),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(context.w(16)),
                child: SectionHeader(
                  title: 'Files (${_files.length})',
                  prefixText: '+ Upload',
                  onViewAll: () => _showUploadSheet(context),
                ),
              ),
              AppDivider(indent: 18, endIndent: 18),
              ..._files.indexed.map(
                (entry) => Column(
                  children: [
                    _buildFileItem(context, entry.$2, entry.$1),
                    if (entry.$1 < _files.length - 1)
                      AppDivider(indent: 18, endIndent: 18),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFileItem(BuildContext context, _FileItem file, int index) {
    final isAudio = file.type == _FileType.audio;
    final (Color iconBg, String iconPath) = switch (file.type) {
      _FileType.audio => (CommonColors.red600, CommonImg.crmMicOutlined),
      _FileType.image => (
        CommonColors.primaryGradientEnd,
        CommonImg.crmImageOutlined,
      ),
      _ => (CommonColors.warning600, CommonImg.crmDocumentOutlined),
    };

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.w(16),
        vertical: context.h(12),
      ),
      child: Row(
        children: [
          Container(
            width: context.w(40),
            height: context.w(40),
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: SvgPicture.asset(
                iconPath,
                width: context.w(20),
                height: context.w(20),
                colorFilter: const ColorFilter.mode(
                  CommonColors.whiteColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          SizedBox(width: context.w(12)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  file.name,
                  style: TextStyle(
                    fontSize: context.s(15),
                    fontWeight: FontWeight.w600,
                    color: CommonColors.textPrimary,
                  ),
                ),
                SizedBox(height: context.h(2)),
                Text(
                  file.meta,
                  style: TextStyle(
                    fontSize: context.s(13),
                    color: CommonColors.textTertiary,
                  ),
                ),
              ],
            ),
          ),
          if (isAudio) ...[
            Container(
              width: context.w(28),
              height: context.w(28),
              decoration: BoxDecoration(
                color: CommonColors.info500.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: SvgPicture.asset(
                  CommonImg.crmPlayOutlined,
                  width: context.w(12),
                  height: context.w(12),
                  colorFilter: const ColorFilter.mode(
                    CommonColors.info500,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            SizedBox(width: context.w(8)),
          ],
          GestureDetector(
            onTap: () async {
              final confirmed = await showDeleteDialog(
                context,
                title: 'Delete ${file.name}?',
                description:
                    'This file will be permanently removed from this lead. This cannot be undone.',
              );
              if (confirmed) setState(() => _files.removeAt(index));
            },
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: CommonColors.red50,
              ),
              child: SvgPicture.asset(
                CommonImg.crmTrashOutlined,
                width: context.w(18),
                height: context.w(18),
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

  void _showUploadSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _UploadFileSheet(
        onUpload: (fileName, fileMeta, fileType) {
          setState(() {
            _files.add(
              _FileItem(name: fileName, meta: fileMeta, type: fileType),
            );
          });
        },
      ),
    );
  }

  void _showAddFollowUpSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _AddFollowUpSheet(
        onSave: (item) => setState(() => _followUps.insert(0, item)),
      ),
    );
  }

  Widget _buildFollowUpsTab() {
    return Builder(
      builder: (context) => SingleChildScrollView(
        padding: EdgeInsets.all(context.w(16)),
        child: Container(
          decoration: BoxDecoration(
            color: CommonColors.whiteColor,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: CommonColors.borderSubtle),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(
                  context.w(16),
                  context.h(14),
                  context.w(16),
                  context.h(14),
                ),
                child: SectionHeader(
                  title: 'Timeline (${_followUps.length})',
                  prefixText: '+ Add Follow up',
                  onViewAll: () => _showAddFollowUpSheet(context),
                ),
              ),
              AppDivider(indent: 18, endIndent: 18),
              Column(
                children: [
                  for (final (i, item) in _followUps.indexed) ...[
                    _buildFollowUpItem(context, item, i),
                    if (i < _followUps.length - 1)
                      AppDivider(indent: 18, endIndent: 18),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFollowUpItem(
    BuildContext context,
    _FollowUpItem item,
    int index,
  ) {
    final isLast = index == _followUps.length - 1;
    final isConnected = item.status == _FollowUpStatus.connected;

    final String typeLabel = switch (item.type) {
      _FollowUpType.call => 'Call',
      _FollowUpType.whatsApp => 'WhatsApp',
      _FollowUpType.email => 'Email',
      _FollowUpType.sms => 'SMS',
      _FollowUpType.meeting => 'Meeting',
    };

    final (String statusLabel, Color statusColor) = switch (item.status) {
      _FollowUpStatus.connected => ('Connected', CommonColors.info500),
      _FollowUpStatus.pending => ('Pending', CommonColors.orangeColor),
      _FollowUpStatus.newStatus => ('New', CommonColors.info500),
      _FollowUpStatus.followUp => ('Follow-up', CommonColors.warning600),
      _FollowUpStatus.closed => ('Closed', CommonColors.textTertiary),
      _FollowUpStatus.contacted => ('Contacted', CommonColors.appGreenColor),
    };

    return IntrinsicHeight(
      child: Padding(
        padding: EdgeInsets.all(context.h(16)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: context.w(32),
              child: Column(
                children: [
                  Container(
                    width: context.w(32),
                    height: context.w(32),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isConnected
                          ? CommonColors.green50
                          : CommonColors.warning50,
                      border: isConnected
                          ? Border.all(color: CommonColors.green600, width: 1)
                          : Border.all(
                              color: CommonColors.warning500,
                              width: 1,
                            ),
                    ),
                    child: isConnected
                        ? SvgPicture.asset(
                            CommonImg.crmCheckCircleOutlined,
                            colorFilter: ColorFilter.mode(
                              CommonColors.green600,
                              BlendMode.srcIn,
                            ),
                          )
                        : SvgPicture.asset(
                            fit: BoxFit.scaleDown,
                            CommonImg.crmTimeAltOutlined,
                            colorFilter: ColorFilter.mode(
                              CommonColors.warning500,
                              BlendMode.srcIn,
                            ),
                          ),
                  ),
                ],
              ),
            ),
            SizedBox(width: context.w(10)),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: isLast ? context.h(8) : context.h(20),
                ),
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
                                    fontSize: context.s(14),
                                    fontWeight: FontWeight.w600,
                                    color: CommonColors.textPrimary,
                                  ),
                                ),
                              ),
                              SizedBox(width: context.w(6)),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: context.w(8),
                                  vertical: context.h(4),
                                ),
                                decoration: BoxDecoration(
                                  color: statusColor.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: context.w(5),
                                      height: context.w(5),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: statusColor,
                                      ),
                                    ),
                                    SizedBox(width: context.w(4)),
                                    Text(
                                      statusLabel,
                                      style: TextStyle(
                                        fontSize: context.s(9),
                                        color: statusColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: context.w(8)),
                        Text(
                          item.time,
                          style: TextStyle(
                            fontSize: context.s(11),
                            color: CommonColors.textTertiary,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: context.h(3)),
                    Text(
                      'By ${item.agent}',
                      style: TextStyle(
                        fontSize: context.s(12),
                        color: CommonColors.textTertiary,
                      ),
                    ),
                    SizedBox(height: context.h(6)),
                    Text(
                      item.note,
                      style: TextStyle(
                        fontSize: context.s(13),
                        color: CommonColors.textSecondary,
                        height: 1.4,
                      ),
                    ),
                    if (item.attachment != null) ...[
                      SizedBox(height: context.h(10)),
                      _buildFollowUpAttachment(context, item.attachment!),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFollowUpAttachment(BuildContext context, _FileItem file) {
    final isAudio = file.type == _FileType.audio;
    final (String iconPath) = switch (file.type) {
      _FileType.audio => CommonImg.crmMicOutlined,
      _FileType.image => CommonImg.crmImageOutlined,
      _ => CommonImg.crmDocumentOutlined,
    };

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: context.w(5),
        vertical: context.h(4),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: context.w(5),
        vertical: context.h(4),
      ),
      decoration: BoxDecoration(
        color: CommonColors.grey75,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: CommonColors.borderSubtle),
      ),
      child: Row(
        children: [
          Container(
            width: context.w(32),
            height: context.w(32),
            decoration: BoxDecoration(
              color: CommonColors.info50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: SvgPicture.asset(
                iconPath,
                width: context.w(16),
                height: context.w(16),
                colorFilter: const ColorFilter.mode(
                  CommonColors.whiteColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          SizedBox(width: context.w(10)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  file.name,
                  style: TextStyle(
                    fontSize: context.s(12),
                    fontWeight: FontWeight.w600,
                    color: CommonColors.textPrimary,
                  ),
                ),
                Text(
                  file.meta,
                  style: TextStyle(
                    fontSize: context.s(11),
                    color: CommonColors.textTertiary,
                  ),
                ),
              ],
            ),
          ),
          if (isAudio)
            Container(
              width: context.w(26),
              height: context.w(26),
              decoration: BoxDecoration(
                color: CommonColors.info500.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: SvgPicture.asset(
                  CommonImg.crmPlayOutlined,
                  width: context.w(10),
                  height: context.w(10),
                  colorFilter: const ColorFilter.mode(
                    CommonColors.info500,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPlaceholderTab(String label) {
    return Builder(
      builder: (context) => Center(
        child: Text(
          label,
          style: TextStyle(
            fontSize: context.s(14),
            color: CommonColors.textTertiary,
          ),
        ),
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return Container(
      color: CommonColors.whiteColor,
      padding: EdgeInsets.fromLTRB(
        context.w(16),
        context.h(12),
        context.w(16),
        context.h(16) + MediaQuery.of(context).padding.bottom,
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.edit_outlined),
              label: const Text('Edit Lead'),
              style: OutlinedButton.styleFrom(
                foregroundColor: CommonColors.textPrimary,
                iconSize: context.w(16),
                textStyle: TextStyle(
                  fontSize: context.s(14),
                  fontWeight: FontWeight.w600,
                ),
                side: const BorderSide(color: CommonColors.borderDefault),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.symmetric(vertical: context.h(14)),
              ),
            ),
          ),
          SizedBox(width: context.w(12)),
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {},
              icon: SvgPicture.asset(
                CommonImg.crmPersonAddOutlined,
                width: context.w(18),
                height: context.w(18),
                colorFilter: const ColorFilter.mode(
                  CommonColors.whiteColor,
                  BlendMode.srcIn,
                ),
              ),
              label: const Text('Reassign'),
              style: ElevatedButton.styleFrom(
                backgroundColor: CommonColors.primaryColor,
                foregroundColor: CommonColors.whiteColor,
                elevation: 0,
                textStyle: TextStyle(
                  fontSize: context.s(14),
                  fontWeight: FontWeight.w600,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.symmetric(vertical: context.h(14)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _UploadFileSheet extends StatefulWidget {
  final void Function(String name, String meta, _FileType type) onUpload;

  const _UploadFileSheet({required this.onUpload});

  @override
  State<_UploadFileSheet> createState() => _UploadFileSheetState();
}

class _UploadFileSheetState extends State<_UploadFileSheet> {
  ({String name, String meta, _FileType type, String icon, Color color})?
  _selected;

  void _simulatePick(
    String name,
    String meta,
    _FileType type, {
    required String icon,
    required Color color,
  }) {
    setState(
      () => _selected = (
        name: name,
        meta: meta,
        type: type,
        icon: icon,
        color: color,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: CommonColors.whiteColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.only(top: context.h(10)),
              width: context.w(36),
              height: context.h(4),
              decoration: BoxDecoration(
                color: CommonColors.grey300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(
              context.w(16),
              context.h(16),
              context.w(16),
              context.h(4),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Upload File',
                  style: TextStyle(
                    fontSize: context.s(16),
                    fontWeight: FontWeight.w700,
                    color: CommonColors.textPrimary,
                  ),
                ),
                GestureDetector(
                  onTap: () => Get.back,
                  child: Container(
                    width: context.w(32),
                    height: context.w(32),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: CommonColors.grey75,
                    ),
                    child: Container(
                      width: context.w(32),
                      height: context.w(32),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: CommonColors.grey75,
                      ),
                      child: Icon(
                        Icons.close,
                        size: context.w(18),
                        color: CommonColors.blackColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.w(16),
              vertical: context.h(12),
            ),
            child: GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: context.w(12),
              mainAxisSpacing: context.h(12),
              childAspectRatio: 1.3,
              children: [
                _buildUploadOption(
                  context,
                  icon: CommonImg.crmCameraOutlined,
                  label: 'Take Photo',
                  color: CommonColors.primaryGradientEnd,
                  onTap: () => _simulatePick(
                    'IMG_1526.jpg',
                    '420kb',
                    _FileType.image,
                    icon: CommonImg.crmCameraOutlined,
                    color: CommonColors.primaryGradientEnd,
                  ),
                ),
                _buildUploadOption(
                  context,
                  icon: CommonImg.crmImageOutlined,
                  label: 'Photo Library',
                  color: CommonColors.appGreenColor,
                  onTap: () => _simulatePick(
                    'IMG_1527.jpg',
                    '318kb',
                    _FileType.image,
                    icon: CommonImg.crmImageOutlined,
                    color: CommonColors.appGreenColor,
                  ),
                ),
                _buildUploadOption(
                  context,
                  icon: CommonImg.crmDocumentOutlined,
                  label: 'Browse Files',
                  color: CommonColors.orangeColor,
                  onTap: () => _simulatePick(
                    'Document.pdf',
                    '1.2MB',
                    _FileType.pdf,
                    icon: CommonImg.crmDocumentOutlined,
                    color: CommonColors.orangeColor,
                  ),
                ),
                _buildUploadOption(
                  context,
                  icon: CommonImg.crmMicOutlined,
                  label: 'Record Audio',
                  color: CommonColors.error500,
                  onTap: () => _simulatePick(
                    'Recording.mp3',
                    '2min · 3.1MB',
                    _FileType.audio,
                    icon: CommonImg.crmMicOutlined,
                    color: CommonColors.error500,
                  ),
                ),
              ],
            ),
          ),
          if (_selected != null) ...[
            Padding(
              padding: EdgeInsets.fromLTRB(
                context.w(16),
                context.h(4),
                context.w(16),
                context.h(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ready To Upload',
                    style: TextStyle(
                      fontSize: context.s(13),
                      fontWeight: FontWeight.w600,
                      color: CommonColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: context.h(10)),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.w(12),
                      vertical: context.h(10),
                    ),
                    decoration: BoxDecoration(
                      color: CommonColors.whiteColor,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: CommonColors.borderSubtle),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: context.w(36),
                          height: context.w(36),
                          decoration: BoxDecoration(
                            color: _selected!.color,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                              _selected!.icon,
                              width: context.w(18),
                              height: context.w(18),
                              colorFilter: const ColorFilter.mode(
                                CommonColors.whiteColor,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: context.w(10)),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _selected!.name,
                                style: TextStyle(
                                  fontSize: context.s(13),
                                  fontWeight: FontWeight.w600,
                                  color: CommonColors.textPrimary,
                                ),
                              ),
                              Text(
                                _selected!.meta,
                                style: TextStyle(
                                  fontSize: context.s(11),
                                  color: CommonColors.textTertiary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () => setState(() => _selected = null),
                          child: Container(
                            width: context.w(32),
                            height: context.w(32),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: CommonColors.grey75,
                            ),
                            child: Icon(
                              Icons.close,
                              size: context.w(16),
                              color: CommonColors.textTertiary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
          Padding(
            padding: EdgeInsets.fromLTRB(
              context.w(16),
              context.h(4),
              context.w(16),
              context.h(24) + MediaQuery.of(context).padding.bottom,
            ),
            child: SizedBox(
              width: double.infinity,
              height: context.h(52),
              child: ElevatedButton(
                onPressed: _selected == null
                    ? null
                    : () {
                        widget.onUpload(
                          _selected!.name,
                          _selected!.meta,
                          _selected!.type,
                        );
                        Navigator.pop(context);
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: CommonColors.primaryColor,
                  disabledBackgroundColor: CommonColors.primaryColor.withValues(
                    alpha: 0.4,
                  ),
                  foregroundColor: CommonColors.whiteColor,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Upload File',
                  style: TextStyle(
                    fontSize: context.s(16),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUploadOption(
    BuildContext context, {
    required String icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: CommonColors.whiteColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: CommonColors.borderSubtle),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: context.w(48),
              height: context.w(48),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Center(
                child: SvgPicture.asset(
                  icon,
                  width: context.w(24),
                  height: context.w(24),
                  colorFilter: const ColorFilter.mode(
                    CommonColors.whiteColor,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            SizedBox(height: context.h(8)),
            Text(
              label,
              style: TextStyle(
                fontSize: context.s(13),
                fontWeight: FontWeight.w500,
                color: CommonColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AddNoteSheet extends StatefulWidget {
  final void Function(String text, bool isPinned) onSave;

  const _AddNoteSheet({required this.onSave});

  @override
  State<_AddNoteSheet> createState() => _AddNoteSheetState();
}

class _AddNoteSheetState extends State<_AddNoteSheet> {
  final _noteCtrl = TextEditingController();
  bool _isPinned = false;

  @override
  void dispose() {
    _noteCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        decoration: const BoxDecoration(
          color: CommonColors.whiteColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                margin: EdgeInsets.only(top: context.h(10)),
                width: context.w(36),
                height: context.h(4),
                decoration: BoxDecoration(
                  color: CommonColors.grey300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                context.w(16),
                context.h(16),
                context.w(16),
                context.h(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Add Note',
                    style: TextStyle(
                      fontSize: context.s(16),
                      fontWeight: FontWeight.w700,
                      color: CommonColors.textPrimary,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: context.w(32),
                      height: context.w(32),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: CommonColors.grey75,
                      ),
                      child: Icon(
                        Icons.close,
                        size: context.w(16),
                        color: CommonColors.textSecondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.w(16)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Note',
                        style: TextStyle(
                          fontSize: context.s(14),
                          color: CommonColors.textPrimary,
                        ),
                      ),
                      Text(
                        ' *',
                        style: TextStyle(
                          fontSize: context.s(12),
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: context.h(8)),
                  TextField(
                    controller: _noteCtrl,
                    maxLines: 5,
                    textInputAction: TextInputAction.newline,
                    style: TextStyle(
                      fontSize: context.s(14),
                      color: CommonColors.textPrimary,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Write a Note about this Lead...',
                      hintStyle: TextStyle(
                        fontSize: context.s(14),
                        color: CommonColors.textPlaceholder,
                      ),
                      filled: true,
                      fillColor: CommonColors.whiteColor,
                      contentPadding: EdgeInsets.all(context.w(12)),
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
                  SizedBox(height: context.h(12)),
                  GestureDetector(
                    onTap: () => setState(() => _isPinned = !_isPinned),
                    child: Row(
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 150),
                          width: context.w(18),
                          height: context.w(18),
                          decoration: BoxDecoration(
                            color: _isPinned
                                ? CommonColors.primaryColor
                                : CommonColors.whiteColor,
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              color: _isPinned
                                  ? CommonColors.primaryColor
                                  : CommonColors.borderDefault,
                            ),
                          ),
                          child: _isPinned
                              ? Icon(
                                  Icons.check,
                                  size: context.w(12),
                                  color: CommonColors.whiteColor,
                                )
                              : null,
                        ),
                        SizedBox(width: context.w(10)),
                        Text(
                          'Pin to top of Notes',
                          style: TextStyle(
                            fontSize: context.s(14),
                            color: CommonColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: context.h(20)),
                  SizedBox(
                    width: double.infinity,
                    height: context.h(52),
                    child: ElevatedButton(
                      onPressed: () {
                        final text = _noteCtrl.text.trim();
                        if (text.isEmpty) return;
                        widget.onSave(text, _isPinned);
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
                        'Save Note',
                        style: TextStyle(
                          fontSize: context.s(16),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: context.h(24)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AddFollowUpSheet extends StatefulWidget {
  final void Function(_FollowUpItem item) onSave;

  const _AddFollowUpSheet({required this.onSave});

  @override
  State<_AddFollowUpSheet> createState() => _AddFollowUpSheetState();
}

class _AddFollowUpSheetState extends State<_AddFollowUpSheet> {
  _FollowUpType _type = _FollowUpType.call;
  _FollowUpStatus _status = _FollowUpStatus.pending;
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
    _FollowUpStatus.pending,
    _FollowUpStatus.newStatus,
    _FollowUpStatus.followUp,
    _FollowUpStatus.closed,
    _FollowUpStatus.contacted,
  ];

  @override
  void dispose() {
    _noteCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: context.h(10)),
                  width: context.w(36),
                  height: context.h(4),
                  decoration: BoxDecoration(
                    color: CommonColors.grey300,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                  context.w(16),
                  context.h(16),
                  context.w(16),
                  context.h(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Follow-ups',
                      style: TextStyle(
                        fontSize: context.s(16),
                        fontWeight: FontWeight.w700,
                        color: CommonColors.textPrimary,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: context.w(28),
                        height: context.w(28),
                        decoration: BoxDecoration(
                          color: CommonColors.grey100,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.close,
                          size: context.w(16),
                          color: CommonColors.textSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: context.w(16)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _sheetLabel(context, 'Activity Type'),
                    SizedBox(height: context.h(10)),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children:
                            [
                              _FollowUpType.call,
                              _FollowUpType.whatsApp,
                              _FollowUpType.email,
                              _FollowUpType.sms,
                            ].map((type) {
                              final label = _typeName(type);
                              final selected = _type == type;
                              return GestureDetector(
                                onTap: () => setState(() => _type = type),
                                child: Container(
                                  margin: EdgeInsets.only(right: context.w(8)),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: context.w(20),
                                    vertical: context.h(8),
                                  ),
                                  decoration: BoxDecoration(
                                    color: selected
                                        ? CommonColors.primaryColor
                                        : CommonColors.whiteColor,
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: selected
                                          ? CommonColors.primaryColor
                                          : CommonColors.borderDefault,
                                    ),
                                  ),
                                  child: Text(
                                    label,
                                    style: TextStyle(
                                      fontSize: context.s(13),
                                      fontWeight: selected
                                          ? FontWeight.w600
                                          : FontWeight.w500,
                                      color: selected
                                          ? CommonColors.whiteColor
                                          : CommonColors.textSecondary,
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                      ),
                    ),
                    SizedBox(height: context.h(16)),
                    _sheetLabel(context, 'When'),
                    SizedBox(height: context.h(10)),
                    Row(
                      children: [
                        Expanded(
                          child: _buildDropdown(
                            context,
                            hint: 'Duration',
                            value: _duration,
                            items: _durations,
                            onChanged: (v) => setState(() => _duration = v),
                          ),
                        ),
                        SizedBox(width: context.w(12)),
                        Expanded(
                          child: _buildDropdown(
                            context,
                            hint: 'Time',
                            value: _time,
                            items: _times,
                            onChanged: (v) => setState(() => _time = v),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: context.h(16)),
                    _sheetLabel(context, 'Status'),
                    SizedBox(height: context.h(10)),
                    Wrap(
                      spacing: context.w(8),
                      runSpacing: context.h(8),
                      children: _sheetStatuses.map((status) {
                        final label = _statusName(status);
                        final color = _statusChipColor(status);
                        final selected = _status == status;
                        return GestureDetector(
                          onTap: () => setState(() => _status = status),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: context.w(12),
                              vertical: context.h(6),
                            ),
                            decoration: BoxDecoration(
                              color: selected
                                  ? CommonColors.primaryColor
                                  : CommonColors.whiteColor,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: selected
                                    ? CommonColors.primaryColor
                                    : CommonColors.borderDefault,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: context.w(6),
                                  height: context.w(6),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: selected
                                        ? CommonColors.whiteColor
                                        : color,
                                  ),
                                ),
                                SizedBox(width: context.w(5)),
                                Text(
                                  label,
                                  style: TextStyle(
                                    fontSize: context.s(13),
                                    color: selected
                                        ? CommonColors.whiteColor
                                        : CommonColors.textSecondary,
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
                    SizedBox(height: context.h(16)),
                    _sheetLabel(context, 'Notes (optional)'),
                    SizedBox(height: context.h(10)),
                    TextField(
                      controller: _noteCtrl,
                      maxLines: 4,
                      style: TextStyle(
                        fontSize: context.s(14),
                        color: CommonColors.textPrimary,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Write a Note about this Lead...',
                        hintStyle: TextStyle(
                          fontSize: context.s(14),
                          color: CommonColors.textPlaceholder,
                        ),
                        filled: true,
                        fillColor: CommonColors.whiteColor,
                        contentPadding: EdgeInsets.all(context.w(12)),
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
                    SizedBox(height: context.h(16)),
                    _sheetLabel(context, 'Attachment'),
                    SizedBox(height: context.h(10)),
                    Row(
                      children: [
                        Expanded(
                          child: _buildAttachmentTile(
                            context,
                            icon: CommonImg.crmMicOutlined,
                            color: CommonColors.primaryGradientEnd,
                            label: 'Attach Recording',
                            sublabel: 'MP3, MP4, Wav · Max 50 MB',
                            isSelected: _hasRecording,
                            onTap: () =>
                                setState(() => _hasRecording = !_hasRecording),
                          ),
                        ),
                        SizedBox(width: context.w(12)),
                        Expanded(
                          child: _buildAttachmentTile(
                            context,
                            icon: CommonImg.crmDocumentOutlined,
                            color: CommonColors.orangeColor,
                            label: 'Attach File',
                            sublabel: 'PDF, Max 50 MB',
                            isSelected: false,
                            onTap: () {},
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: context.h(20)),
                    SizedBox(
                      width: double.infinity,
                      height: context.h(52),
                      child: ElevatedButton(
                        onPressed: () {
                          final parts = [
                            _duration,
                            _time,
                          ].whereType<String>().join(', ');
                          widget.onSave(
                            _FollowUpItem(
                              type: _type,
                              status: _status,
                              time: parts.isEmpty ? 'Just now' : parts,
                              agent: 'Agent 1',
                              note: _noteCtrl.text.trim().isEmpty
                                  ? 'No notes.'
                                  : _noteCtrl.text.trim(),
                              attachment: _hasRecording
                                  ? const _FileItem(
                                      name: 'Recording.mp3',
                                      meta: '—',
                                      type: _FileType.audio,
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
                            fontSize: context.s(16),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height:
                          context.h(24) + MediaQuery.of(context).padding.bottom,
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

  Widget _sheetLabel(BuildContext context, String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: context.s(14),
        fontWeight: FontWeight.w600,
        color: CommonColors.textPrimary,
      ),
    );
  }

  Widget _buildDropdown(
    BuildContext context, {
    required String hint,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      hint: Text(
        hint,
        style: TextStyle(
          fontSize: context.s(14),
          color: CommonColors.textTertiary,
        ),
      ),
      onChanged: onChanged,
      isExpanded: true,
      dropdownColor: CommonColors.whiteColor,
      icon: Icon(
        Icons.keyboard_arrow_down_rounded,
        color: CommonColors.textTertiary,
      ),
      style: TextStyle(
        fontSize: context.s(14),
        color: CommonColors.textPrimary,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: CommonColors.whiteColor,
        contentPadding: EdgeInsets.symmetric(
          horizontal: context.w(14),
          vertical: context.h(12),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: CommonColors.borderDefault),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: CommonColors.borderDefault),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: CommonColors.borderFocus, width: 1.5),
        ),
      ),
      items: items
          .map((e) => DropdownMenuItem<String>(value: e, child: Text(e)))
          .toList(),
    );
  }

  Widget _buildAttachmentTile(
    BuildContext context, {
    required String icon,
    required Color color,
    required String label,
    required String sublabel,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: CustomPaint(
        foregroundPainter: _DashedBorderPainter(
          color: isSelected ? color : CommonColors.borderSubtle,
        ),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: context.w(8),
            vertical: context.h(16),
          ),
          decoration: BoxDecoration(
            color: isSelected
                ? color.withValues(alpha: 0.05)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Container(
                width: context.w(48),
                height: context.w(48),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    icon,
                    width: context.w(24),
                    height: context.w(24),
                    colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
                  ),
                ),
              ),
              SizedBox(height: context.h(8)),
              Text(
                label,
                style: TextStyle(
                  fontSize: context.s(13),
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
              SizedBox(height: context.h(2)),
              Text(
                sublabel,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: context.s(10),
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

  String _typeName(_FollowUpType t) => switch (t) {
    _FollowUpType.call => 'Call',
    _FollowUpType.whatsApp => 'WhatsApp',
    _FollowUpType.email => 'Email',
    _FollowUpType.sms => 'SMS',
    _FollowUpType.meeting => 'Meeting',
  };

  String _statusName(_FollowUpStatus s) => switch (s) {
    _FollowUpStatus.connected => 'Connected',
    _FollowUpStatus.pending => 'Pending',
    _FollowUpStatus.newStatus => 'New',
    _FollowUpStatus.followUp => 'Follow-up',
    _FollowUpStatus.closed => 'Closed',
    _FollowUpStatus.contacted => 'Contacted',
  };

  Color _statusChipColor(_FollowUpStatus s) => switch (s) {
    _FollowUpStatus.connected => CommonColors.appGreenColor,
    _FollowUpStatus.pending => CommonColors.orangeColor,
    _FollowUpStatus.newStatus => CommonColors.info500,
    _FollowUpStatus.followUp => CommonColors.warning600,
    _FollowUpStatus.closed => CommonColors.textTertiary,
    _FollowUpStatus.contacted => CommonColors.info500,
  };
}

class _DashedBorderPainter extends CustomPainter {
  final Color color;
  final double radius;
  final double dashWidth;
  final double gapWidth;
  final double strokeWidth;

  const _DashedBorderPainter({
    required this.color,
    this.radius = 12,
    this.dashWidth = 5,
    this.gapWidth = 4,
    this.strokeWidth = 1.5,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(
            strokeWidth / 2,
            strokeWidth / 2,
            size.width - strokeWidth,
            size.height - strokeWidth,
          ),
          Radius.circular(radius),
        ),
      );

    for (final metric in path.computeMetrics()) {
      double offset = 0;
      while (offset < metric.length) {
        canvas.drawPath(metric.extractPath(offset, offset + dashWidth), paint);
        offset += dashWidth + gapWidth;
      }
    }
  }

  @override
  bool shouldRepaint(_DashedBorderPainter o) => o.color != color;
}

class _ActionButton extends StatelessWidget {
  final String svgPath;
  final Color color;

  const _ActionButton({required this.svgPath, required this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: context.h(52),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: SvgPicture.asset(
            svgPath,
            width: context.w(24),
            height: context.w(24),
            colorFilter: const ColorFilter.mode(
              CommonColors.whiteColor,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }
}
