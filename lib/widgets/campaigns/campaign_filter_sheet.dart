import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mirai_crm/utils/common_colors.dart';
import 'package:mirai_crm/utils/common_img.dart';
import 'package:mirai_crm/utils/common_text_field.dart';
import 'package:mirai_crm/utils/responsive.dart';

void showCampaignFilterSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => const CampaignFilterSheet(),
  );
}

class CampaignFilterSheet extends StatefulWidget {
  const CampaignFilterSheet({super.key});

  @override
  State<CampaignFilterSheet> createState() => _CampaignFilterSheetState();
}

class _CampaignFilterSheetState extends State<CampaignFilterSheet> {
  String? _dateRange;

  final Set<String> _modeSel = {};
  static const _allModes = ['FCFS', 'Distribution', 'Competition'];

  final Set<String> _statusSel = {};
  static const _allStatuses = ['Paused', 'Active', 'Scheduled', 'Ended'];

  final _teamCtrl = TextEditingController();
  final Set<String> _teamSel = {};
  static const _allTeams = ['Inbound', 'Outbound', 'Enterprise'];

  final _agentCtrl = TextEditingController();
  final Set<String> _agentSel = {};
  static const _allAgents = ['Nour', 'Sarah', 'Alex', 'Karim', 'Maya'];

  @override
  void initState() {
    super.initState();
    _teamCtrl.addListener(() => setState(() {}));
    _agentCtrl.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _teamCtrl.dispose();
    _agentCtrl.dispose();
    super.dispose();
  }

  int get _activeFilterCount {
    int count = 0;
    if (_dateRange != null) count++;
    if (_modeSel.isNotEmpty) count++;
    if (_statusSel.isNotEmpty) count++;
    if (_teamSel.isNotEmpty) count++;
    if (_agentSel.isNotEmpty) count++;
    return count;
  }

  void _clearAll() {
    setState(() {
      _dateRange = null;
      _modeSel.clear();
      _statusSel.clear();
      _teamSel.clear();
      _teamCtrl.clear();
      _agentSel.clear();
      _agentCtrl.clear();
    });
  }

  void _toggle(Set<String> set, String value) {
    setState(() {
      if (set.contains(value)) {
        set.remove(value);
      } else {
        set.add(value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    RS.init(context);
    final activeCount = _activeFilterCount;

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.9,
        ),
        decoration: const BoxDecoration(
          color: CommonColors.whiteColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeader(context, activeCount),
            Flexible(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(
                  RS.HS(16),
                  RS.VS(20),
                  RS.HS(16),
                  RS.VS(16) + MediaQuery.of(context).padding.bottom,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _sectionLabel('Date Range', 0, hideCount: true),
                    SizedBox(height: RS.VS(10)),
                    Wrap(
                      spacing: RS.HS(8),
                      runSpacing: RS.VS(8),
                      children: [
                        'Today',
                        'Last 7 Days',
                        'Last 30 Days',
                        'Last 90 Days',
                        'Custom',
                      ].map((d) {
                        return _FilterChip(
                          label: d,
                          selected: _dateRange == d,
                          onTap: () => setState(
                            () => _dateRange = _dateRange == d ? null : d,
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: RS.VS(20)),
                    _sectionLabel('Mode', _modeSel.length),
                    SizedBox(height: RS.VS(10)),
                    Wrap(
                      spacing: RS.HS(8),
                      runSpacing: RS.VS(8),
                      children: _allModes.map((m) {
                        return _FilterChip(
                          label: m,
                          selected: _modeSel.contains(m),
                          onTap: () => _toggle(_modeSel, m),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: RS.VS(20)),
                    _sectionLabel('Status', _statusSel.length),
                    SizedBox(height: RS.VS(10)),
                    Wrap(
                      spacing: RS.HS(8),
                      runSpacing: RS.VS(8),
                      children: _allStatuses.map((s) {
                        return _FilterChip(
                          label: s,
                          selected: _statusSel.contains(s),
                          onTap: () => _toggle(_statusSel, s),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: RS.VS(20)),
                    _sectionLabel('Team', _teamSel.length),
                    SizedBox(height: RS.VS(10)),
                    CommonTextField(
                      controller: _teamCtrl,
                      hint: 'Search Teams...',
                      prefixIcon: Padding(
                        padding: EdgeInsets.symmetric(horizontal: RS.HS(12)),
                        child: SvgPicture.asset(
                          CommonImg.crmSearchOutlined,
                          width: RS.HS(18),
                          height: RS.HS(18),
                          colorFilter: const ColorFilter.mode(
                            CommonColors.textTertiary,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                      showPrefixDivider: false,
                      textInputAction: TextInputAction.search,
                    ),
                    SizedBox(height: RS.VS(10)),
                    Wrap(
                      spacing: RS.HS(8),
                      runSpacing: RS.VS(8),
                      children: _allTeams
                          .where(
                            (t) => t.toLowerCase().contains(
                              _teamCtrl.text.toLowerCase(),
                            ),
                          )
                          .map((t) {
                            return _FilterChip(
                              label: t,
                              selected: _teamSel.contains(t),
                              onTap: () => _toggle(_teamSel, t),
                            );
                          })
                          .toList(),
                    ),
                    SizedBox(height: RS.VS(20)),
                    _sectionLabel('Agent', _agentSel.length),
                    SizedBox(height: RS.VS(10)),
                    CommonTextField(
                      controller: _agentCtrl,
                      hint: 'Search Agents...',
                      prefixIcon: Padding(
                        padding: EdgeInsets.symmetric(horizontal: RS.HS(12)),
                        child: SvgPicture.asset(
                          CommonImg.crmSearchOutlined,
                          width: RS.HS(18),
                          height: RS.HS(18),
                          colorFilter: const ColorFilter.mode(
                            CommonColors.textTertiary,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                      showPrefixDivider: false,
                      textInputAction: TextInputAction.search,
                    ),
                    SizedBox(height: RS.VS(10)),
                    Wrap(
                      spacing: RS.HS(8),
                      runSpacing: RS.VS(8),
                      children: _allAgents
                          .where(
                            (a) => a.toLowerCase().contains(
                              _agentCtrl.text.toLowerCase(),
                            ),
                          )
                          .map((a) {
                            return _FilterChip(
                              label: a,
                              selected: _agentSel.contains(a),
                              onTap: () => _toggle(_agentSel, a),
                            );
                          })
                          .toList(),
                    ),
                    SizedBox(height: RS.VS(24)),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: _clearAll,
                            style: OutlinedButton.styleFrom(
                              foregroundColor: CommonColors.textPrimary,
                              side: const BorderSide(
                                color: CommonColors.borderDefault,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: EdgeInsets.symmetric(
                                vertical: RS.VS(14),
                              ),
                            ),
                            child: Text(
                              'Clear All',
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
                            onPressed: () => Navigator.pop(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: CommonColors.primaryColor,
                              foregroundColor: CommonColors.whiteColor,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: EdgeInsets.symmetric(
                                vertical: RS.VS(14),
                              ),
                            ),
                            child: Text(
                              'Show $activeCount Result',
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
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, int activeCount) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: CommonColors.borderDefault),
        ),
        boxShadow: [
          BoxShadow(
            color: CommonColors.blackColor.withValues(alpha: 0.08),
            offset: const Offset(0, 2),
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
              RS.VS(12),
              RS.HS(16),
              RS.VS(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  activeCount > 0 ? 'Filters ($activeCount)' : 'Filters',
                  style: TextStyle(
                    fontSize: RS.FS(16),
                    fontWeight: FontWeight.w700,
                    color: CommonColors.textPrimary,
                  ),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: RS.HS(32),
                    height: RS.HS(32),
                    decoration: const BoxDecoration(
                      color: CommonColors.grey100,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: SvgPicture.asset(
                      CommonImg.crmCrossCircleOutlined,
                      height: RS.VS(22),
                      colorFilter: const ColorFilter.mode(
                        CommonColors.blackColor,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionLabel(String label, int count, {bool hideCount = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: RS.FS(14),
            fontWeight: FontWeight.w600,
            color: CommonColors.textPrimary,
          ),
        ),
        if (!hideCount)
          Text(
            '$count Selected',
            style: TextStyle(
              fontSize: RS.FS(13),
              fontWeight: count > 0 ? FontWeight.w500 : FontWeight.w400,
              color: count > 0
                  ? CommonColors.primaryColor
                  : CommonColors.textTertiary,
            ),
          ),
      ],
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    RS.init(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: RS.HS(16),
          vertical: RS.VS(8),
        ),
        decoration: BoxDecoration(
          color: selected ? CommonColors.red50 : CommonColors.whiteColor,
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
            fontSize: RS.FS(13),
            fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
            color: selected
                ? CommonColors.primaryColor
                : CommonColors.textSecondary,
          ),
        ),
      ),
    );
  }
}
