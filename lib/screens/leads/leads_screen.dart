import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mirai_crm/utils/responsive.dart';
import 'package:mirai_crm/utils/common_colors.dart';
import 'package:mirai_crm/utils/common_delete_dialog.dart';
import 'package:mirai_crm/utils/common_img.dart';
import 'package:mirai_crm/widgets/leads/lead_list_card.dart';
import 'package:mirai_crm/widgets/leads/filter_sheet.dart';
import 'package:mirai_crm/widgets/lead_detail/reassign_lead_sheet.dart';
import 'package:mirai_crm/widgets/leads/sort_bottom_sheet.dart';
import 'package:mirai_crm/screens/leads/lead_detail_screen.dart';

class LeadsScreen extends StatefulWidget {
  const LeadsScreen({super.key});

  @override
  State<LeadsScreen> createState() => _LeadsScreenState();
}

class _LeadsScreenState extends State<LeadsScreen> {
  static const _tabs = [
    'All',
    'New',
    'Contacted',
    'Un-read',
    'Follow-up',
    'Hold',
  ];

  final List<LeadListItem> _leads = [
    const LeadListItem(
      initials: 'MR',
      name: 'Michael Rodriguez',
      time: 'Yesterday, 04:10 PM',
      assignedTo: 'Nour',
      source: 'Facebook Ad',
      priority: 'High',
      status: 'New',
      isRecentlyAdded: true,
    ),
    const LeadListItem(
      initials: 'MR',
      name: 'Michael Rodriguez',
      time: 'Yesterday, 04:10 PM',
      assignedTo: 'Nour',
      source: 'Facebook Ad',
      priority: 'Medium',
      status: 'New',
    ),
    const LeadListItem(
      initials: 'EC',
      name: 'Emily Chen',
      time: '2 days ago, 11:30 AM',
      assignedTo: 'Alex',
      source: 'Google Ad',
      priority: 'High',
      status: 'Contacted',
    ),
    const LeadListItem(
      initials: 'RP',
      name: 'Robert Pattinson',
      time: '3 days ago, 09:00 AM',
      assignedTo: 'Sara',
      source: 'Referral',
      priority: 'Low',
      status: 'Converted',
    ),
    const LeadListItem(
      initials: 'AK',
      name: 'Ananya Krishnan',
      time: '4 days ago, 02:15 PM',
      assignedTo: 'Alex',
      source: 'Website',
      priority: 'Medium',
      status: 'Pending',
    ),
  ];

  bool _isSelectMode = false;
  final Set<int> _selectedIndices = {};
  late final TapGestureRecognizer _filterTapRecognizer;

  @override
  void initState() {
    super.initState();
    _filterTapRecognizer = TapGestureRecognizer()
      ..onTap = () => showFilterSheet(context);
  }

  @override
  void dispose() {
    _filterTapRecognizer.dispose();
    super.dispose();
  }

  void _enterSelectMode(int index) {
    setState(() {
      _isSelectMode = true;
      _selectedIndices.add(index);
    });
  }

  void _exitSelectMode() {
    setState(() {
      _isSelectMode = false;
      _selectedIndices.clear();
    });
  }

  void _toggleSelection(int index) {
    setState(() {
      if (_selectedIndices.contains(index)) {
        _selectedIndices.remove(index);
      } else {
        _selectedIndices.add(index);
      }
    });
  }

  void _selectAll() {
    setState(() {
      _selectedIndices.addAll(List.generate(_leads.length, (i) => i));
    });
  }

  Future<void> _onDeleteTap() async {
    final count = _selectedIndices.length;
    final confirmed = await showDeleteDialog(
      context,
      title: 'Delete $count lead${count > 1 ? 's' : ''}?',
      description:
          'All selected leads – and every note, follow-up, recording and file attached to them – will be permanently removed. This cannot be undone.',
    );
    if (confirmed && mounted) {
      setState(() {
        final sorted = _selectedIndices.toList()
          ..sort((a, b) => b.compareTo(a));
        for (final i in sorted) {
          _leads.removeAt(i);
        }
        _exitSelectMode();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    RS.init(context);
    return DefaultTabController(
      length: _tabs.length,
      child: Column(
        children: [
          _buildTabBar(context),
          Expanded(
            child: TabBarView(
              children: [
                _buildLeadsList(context),
                ...(List.generate(_tabs.length - 1, (_) => _buildEmptyTab())),
              ],
            ),
          ),
          if (_isSelectMode) _buildSelectionBottomBar(context),
        ],
      ),
    );
  }

  Widget _buildTabBar(BuildContext context) {
    return Container(
      color: CommonColors.whiteColor,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: RS.HS(16)),
        child: TabBar(
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          labelColor: CommonColors.primaryColor,
          unselectedLabelColor: CommonColors.textTertiary,
          labelStyle: TextStyle(
            fontSize: RS.FS(14),
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: RS.FS(14),
            fontWeight: FontWeight.w500,
          ),
          indicatorColor: CommonColors.primaryColor,
          indicatorWeight: 2,
          indicatorSize: TabBarIndicatorSize.tab,
          dividerColor: CommonColors.borderDefault,
          tabs: _tabs.map((t) => Tab(text: t)).toList(),
        ),
      ),
    );
  }

  Widget _buildListHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(RS.HS(16), RS.VS(10), RS.HS(16), RS.VS(5)),
      child: Row(
        children: [
          Text(
            'All Leads (${_leads.length})',
            style: TextStyle(
              fontSize: RS.FS(15),
              fontWeight: FontWeight.w600,
              color: CommonColors.textPrimary,
            ),
          ),
          const Spacer(),
          _HeaderAction(
            icon: Icons.tune_rounded,
            label: 'Filter',
            onTap: () => showFilterSheet(context),
          ),
          SizedBox(width: RS.HS(8)),
          _HeaderAction(
            icon: Icons.swap_vert_rounded,
            label: 'Sort',
            onTap: () => showSortBottomSheet(context),
          ),
          SizedBox(width: RS.HS(8)),
          _HeaderAction(
            icon: null,
            label: 'Select',
            onTap: () => setState(() => _isSelectMode = true),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectionBanner(BuildContext context) {
    final allSelected = _selectedIndices.length == _leads.length;
    return Container(
      decoration: BoxDecoration(
        color: CommonColors.red50,
        border: Border(bottom: BorderSide(color: CommonColors.red200)),
      ),
      padding: EdgeInsets.symmetric(horizontal: RS.HS(16), vertical: RS.VS(18)),
      child: Row(
        children: [
          GestureDetector(
            onTap: _exitSelectMode,
            child: Container(
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: CommonColors.whiteColor,
                shape: BoxShape.circle,
                border: Border.all(color: CommonColors.red200),
              ),
              height: RS.VS(20),
              width: RS.HS(20),
              child: Center(
                child: SvgPicture.asset(
                  CommonImg.crmCrossCircleOutlined,
                  colorFilter: ColorFilter.mode(
                    CommonColors.red500,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: RS.HS(10)),
          Text(
            '${_selectedIndices.length} Selected',
            style: TextStyle(
              fontSize: RS.FS(15),
              fontWeight: FontWeight.w500,
              color: CommonColors.red600,
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: allSelected
                ? () {
                    _selectedIndices.clear();
                    setState(() {});
                  }
                : _selectAll,
            child: Text(
              allSelected ? 'Deselect All' : 'Select All',
              style: TextStyle(
                fontSize: RS.FS(14),
                fontWeight: FontWeight.w600,
                color: CommonColors.primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLeadsList(BuildContext context) {
    return Column(
      children: [
        if (_isSelectMode)
          _buildSelectionBanner(context)
        else
          _buildListHeader(context),
        SizedBox(height: RS.VS(7)),
        Expanded(
          child: ListView(
            padding: EdgeInsets.only(bottom: RS.VS(16)),
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: RS.HS(16),
                  vertical: RS.VS(8),
                ),
                child: Column(
                  children: _leads.indexed
                      .map(
                        (entry) => GestureDetector(
                          onTap: () {
                            if (_isSelectMode) {
                              _toggleSelection(entry.$1);
                            } else {
                              Get.to(() => const LeadDetailScreen());
                            }
                          },
                          onLongPress: _isSelectMode
                              ? null
                              : () => _enterSelectMode(entry.$1),
                          child: LeadListCard(
                            lead: entry.$2,
                            isSelectMode: _isSelectMode,
                            isSelected: _selectedIndices.contains(entry.$1),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
              if (!_isSelectMode) _buildFooter(context),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyTab() {
    return const Center(
      child: Text('No leads', style: TextStyle(color: CommonColors.greyAEAEAE)),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: RS.VS(10)),
      child: Column(
        children: [
          Text(
            'Showing leads from the last 7 days',
            style: TextStyle(
              fontSize: RS.FS(11),
              color: CommonColors.greyAEAEAE,
            ),
          ),
          SizedBox(height: RS.VS(2)),
          Text.rich(
            TextSpan(
              text: 'Use ',
              style: TextStyle(
                fontSize: RS.FS(11),
                color: CommonColors.greyAEAEAE,
              ),
              children: [
                TextSpan(
                  text: 'filter',
                  recognizer: _filterTapRecognizer,
                  style: TextStyle(
                    color: CommonColors.primaryColor,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.underline,
                    decorationColor: CommonColors.primaryColor,
                  ),
                ),
                const TextSpan(text: ' to see older leads.'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectionBottomBar(BuildContext context) {
    final count = _selectedIndices.length;
    return Container(
      decoration: BoxDecoration(
        color: CommonColors.whiteColor,
        border: Border(top: BorderSide(color: CommonColors.borderDefault)),
      ),
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
              onPressed: () => showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (_) => const ReassignLeadSheet(),
              ),
              icon: Icon(Icons.person_add_outlined, size: RS.HS(16)),
              label: const Text('Reassign'),
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
              onPressed: count > 0 ? _onDeleteTap : null,
              icon: SvgPicture.asset(
                CommonImg.crmTrashOutlined,
                width: RS.HS(16),
                height: RS.HS(16),
                colorFilter: const ColorFilter.mode(
                  CommonColors.whiteColor,
                  BlendMode.srcIn,
                ),
              ),
              label: Text('Delete $count'),
              style: ElevatedButton.styleFrom(
                backgroundColor: CommonColors.primaryColor,
                disabledBackgroundColor: CommonColors.primaryColor.withValues(
                  alpha: 0.4,
                ),
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

class _HeaderAction extends StatelessWidget {
  final IconData? icon;
  final String label;
  final VoidCallback? onTap;

  const _HeaderAction({required this.icon, required this.label, this.onTap});

  @override
  Widget build(BuildContext context) {
    RS.init(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: RS.HS(10),
          vertical: RS.VS(5),
        ),
        decoration: BoxDecoration(
          border: Border.all(color: CommonColors.borderSubtle),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: RS.HS(14), color: CommonColors.textSecondary),
              SizedBox(width: RS.HS(4)),
            ],
            Text(
              label,
              style: TextStyle(
                fontSize: RS.FS(14),
                color: CommonColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
