import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mirai_crm/utils/responsive.dart';
import 'package:mirai_crm/utils/common_app_bar.dart';
import 'package:mirai_crm/utils/common_colors.dart';
import 'package:mirai_crm/utils/common_img.dart';
import 'package:mirai_crm/widgets/app_divider.dart';
import 'package:mirai_crm/widgets/lead_detail/add_follow_up_sheet.dart';
import 'package:mirai_crm/widgets/lead_detail/add_note_sheet.dart';
import 'package:mirai_crm/widgets/lead_detail/edit_lead_sheet.dart';
import 'package:mirai_crm/widgets/lead_detail/lead_action_button.dart';
import 'package:mirai_crm/widgets/lead_detail/lead_detail_models.dart';
import 'package:mirai_crm/widgets/lead_detail/lead_file_item.dart';
import 'package:mirai_crm/widgets/lead_detail/lead_follow_up_item.dart';
import 'package:mirai_crm/widgets/lead_detail/lead_note_item.dart';
import 'package:mirai_crm/widgets/lead_detail/activity_tab.dart';
import 'package:mirai_crm/widgets/lead_detail/reassign_lead_sheet.dart';
import 'package:mirai_crm/widgets/lead_detail/upload_file_sheet.dart';
import 'package:mirai_crm/widgets/section_header.dart';

class LeadDetailScreen extends StatefulWidget {
  const LeadDetailScreen({super.key});

  @override
  State<LeadDetailScreen> createState() => _LeadDetailScreenState();
}

class _LeadDetailScreenState extends State<LeadDetailScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  final List<LeadFile> _files = [
    const LeadFile(
      name: 'Proposal-x2.pdf',
      meta: '420kb',
      type: LeadFileType.pdf,
    ),
    const LeadFile(
      name: 'Call-Yesterday.mp3',
      meta: '12min · 4.5MB',
      type: LeadFileType.audio,
    ),
    const LeadFile(
      name: 'Brochure-2024.pdf',
      meta: '15MB',
      type: LeadFileType.pdf,
    ),
  ];

  final List<LeadNote> _notes = [
    const LeadNote(
      agent: 'Agent 1',
      time: 'Today, 10:30 AM',
      text:
          'Prefers afternoon calls. Mentioned current vendor contract ends in March.',
      isPinned: true,
    ),
    const LeadNote(
      agent: 'Agent 1',
      time: 'Yesterday, 04:55 PM',
      text:
          'Prefers afternoon calls. Mentioned current vendor contract ends in March.',
    ),
  ];

  final List<LeadActivity> _activities = [
    const LeadActivity(
      toStatus: 'Connected',
      fromStatus: 'New',
      agent: 'Agent 1',
      time: 'Today, 10:30 AM',
    ),
    const LeadActivity(
      toStatus: 'New',
      agent: 'Agent 1',
      time: 'Today, 10:30 AM',
    ),
    const LeadActivity(
      toStatus: 'New',
      agent: 'Agent 1',
      time: 'Today, 10:30 AM',
    ),
  ];

  final List<LeadFollowUp> _followUps = [
    const LeadFollowUp(
      type: LeadFollowUpType.call,
      status: LeadFollowUpStatus.connected,
      time: 'Today, 10:30 AM',
      agent: 'Redpoll Michel',
      note: 'Discussed pricing, sending proposal.',
      attachment: LeadFile(
        name: 'Call-Yesterday.mp3',
        meta: '12min · 4.5MB',
        type: LeadFileType.audio,
      ),
    ),
    const LeadFollowUp(
      type: LeadFollowUpType.whatsApp,
      status: LeadFollowUpStatus.connected,
      time: 'Yesterday, 04:30 AM',
      agent: 'Agent 1',
      note: 'Shared product Video',
    ),
    const LeadFollowUp(
      type: LeadFollowUpType.meeting,
      status: LeadFollowUpStatus.pending,
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
    RS.init(context);
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
                ActivityTab(activities: _activities),
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
      padding: EdgeInsets.fromLTRB(RS.HS(16), RS.VS(16), RS.HS(16), RS.VS(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: RS.HS(62),
                height: RS.HS(62),
                decoration: BoxDecoration(
                  color: CommonColors.red50,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Center(
                  child: Text(
                    'MR',
                    style: TextStyle(
                      fontSize: RS.FS(14),
                      fontWeight: FontWeight.w600,
                      color: CommonColors.red600,
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
                      'Michael Rodriguez',
                      style: TextStyle(
                        fontSize: RS.FS(18),
                        fontWeight: FontWeight.w600,
                        color: CommonColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: RS.VS(2)),
                    Text(
                      '+1 415 555-1451',
                      style: TextStyle(
                        fontSize: RS.FS(14),
                        fontWeight: FontWeight.w500,
                        color: CommonColors.textTertiary,
                      ),
                    ),
                    Text(
                      'm.rodriguez23@gmail.com',
                      style: TextStyle(
                        fontSize: RS.FS(14),
                        fontWeight: FontWeight.w500,
                        color: CommonColors.textTertiary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: RS.VS(12)),
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
                SizedBox(width: RS.HS(10)),
                _buildTag(
                  context,
                  icon: CommonImg.crmMegaphoneOutlined,
                  label: 'Q4 Spring Sale',
                ),
                SizedBox(width: RS.HS(10)),
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
      padding: EdgeInsets.symmetric(horizontal: RS.HS(20), vertical: RS.VS(8)),
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
              width: RS.HS(6),
              height: RS.HS(6),
              margin: EdgeInsets.only(right: RS.HS(5)),
              decoration: BoxDecoration(
                color: statusColor,
                shape: BoxShape.circle,
              ),
            )
          else if (icon != null) ...[
            SvgPicture.asset(
              icon,
              width: RS.HS(12),
              height: RS.HS(12),
              colorFilter: const ColorFilter.mode(
                CommonColors.textTertiary,
                BlendMode.srcIn,
              ),
            ),
            SizedBox(width: RS.HS(5)),
          ],
          Text(
            label,
            style: TextStyle(
              fontSize: RS.FS(12),
              fontWeight: FontWeight.w500,
              color: textColor,
            ),
          ),
          SizedBox(width: RS.HS(3)),
          if (!isStatus)
            SvgPicture.asset(
              CommonImg.crmArrowRightOutlined,
              width: RS.HS(10),
              height: RS.HS(10),
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
      padding: EdgeInsets.fromLTRB(RS.HS(16), RS.VS(4), RS.HS(16), RS.VS(16)),
      child: Row(
        children: [
          Expanded(
            child: LeadActionButton(
              svgPath: CommonImg.crmPhoneOutlined,
              color: CommonColors.info500,
            ),
          ),
          SizedBox(width: RS.HS(12)),
          Expanded(
            child: LeadActionButton(
              svgPath: CommonImg.crmWhatsappOutlined,
              color: CommonColors.green500,
            ),
          ),
          SizedBox(width: RS.HS(12)),
          Expanded(
            child: LeadActionButton(
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
      labelStyle: TextStyle(fontSize: RS.FS(13), fontWeight: FontWeight.w600),
      unselectedLabelStyle: TextStyle(
        fontSize: RS.FS(13),
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
        padding: EdgeInsets.all(RS.HS(16)),
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
            SizedBox(height: RS.VS(16)),
            _buildInfoCard(
              context,
              title: 'Lead Information',
              trailing: Text(
                'Edit',
                style: TextStyle(
                  fontSize: RS.FS(13),
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
            SizedBox(height: RS.VS(16)),
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
              RS.HS(18),
              RS.VS(16),
              RS.HS(18),
              RS.VS(11),
            ),
            child: SectionHeader(title: title, trailing: trailing),
          ),
          ...rows.indexed.map(
            (entry) => Column(
              children: [
                _buildInfoRow(context, entry.$2.$1, entry.$2.$2),
                if (entry.$1 < rows.length - 1)
                  AppDivider(indent: RS.HS(16), endIndent: RS.HS(16)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(BuildContext context, String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: RS.HS(18), vertical: RS.VS(16)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: RS.FS(14),
              fontWeight: FontWeight.w500,
              color: CommonColors.textTertiary,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: RS.FS(14),
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
        padding: EdgeInsets.all(RS.HS(16)),
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
                padding: EdgeInsets.all(RS.HS(16)),
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
                    LeadNoteItem(note: entry.$2),
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

  void _showAddNoteSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => AddNoteSheet(
        onSave: (text, isPinned) {
          setState(() {
            final note = LeadNote(
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
        padding: EdgeInsets.all(RS.HS(16)),
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
                padding: EdgeInsets.all(RS.HS(16)),
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
                    LeadFileItem(
                      file: entry.$2,
                      index: entry.$1,
                      onDelete: (i) => setState(() => _files.removeAt(i)),
                    ),
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

  void _showUploadSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => UploadFileSheet(
        onUpload: (fileName, fileMeta, fileType) {
          setState(() {
            _files.add(
              LeadFile(name: fileName, meta: fileMeta, type: fileType),
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
      builder: (_) => AddFollowUpSheet(
        onSave: (item) => setState(() => _followUps.insert(0, item)),
      ),
    );
  }

  Widget _buildFollowUpsTab() {
    return Builder(
      builder: (context) => SingleChildScrollView(
        padding: EdgeInsets.all(RS.HS(16)),
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
                  RS.HS(16),
                  RS.VS(14),
                  RS.HS(16),
                  RS.VS(14),
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
                    LeadFollowUpItem(item: item),
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

  void _showEditLeadSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const EditLeadSheet(),
    );
  }

  void _showReassignSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const ReassignLeadSheet(),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return Container(
      color: CommonColors.whiteColor,
      padding: EdgeInsets.fromLTRB(
        RS.HS(16),
        RS.VS(12),
        RS.HS(16),
        RS.VS(16) + MediaQuery.of(context).padding.bottom,
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: () => _showEditLeadSheet(context),
              icon: const Icon(Icons.edit_outlined),
              label: const Text('Edit Lead'),
              style: OutlinedButton.styleFrom(
                foregroundColor: CommonColors.textPrimary,
                iconSize: RS.HS(16),
                textStyle: TextStyle(
                  fontSize: RS.FS(14),
                  fontWeight: FontWeight.w600,
                ),
                side: const BorderSide(color: CommonColors.borderDefault),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.symmetric(vertical: RS.VS(14)),
              ),
            ),
          ),
          SizedBox(width: RS.HS(12)),
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () => _showReassignSheet(context),
              icon: SvgPicture.asset(
                CommonImg.crmPersonAddOutlined,
                width: RS.HS(18),
                height: RS.HS(18),
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
                  fontSize: RS.FS(14),
                  fontWeight: FontWeight.w600,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.symmetric(vertical: RS.VS(14)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
