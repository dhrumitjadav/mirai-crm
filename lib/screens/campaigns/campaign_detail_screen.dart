import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mirai_crm/utils/common_app_bar.dart';
import 'package:mirai_crm/utils/common_colors.dart';
import 'package:mirai_crm/utils/common_img.dart';
import 'package:mirai_crm/utils/responsive.dart';
import 'package:mirai_crm/widgets/campaigns/campaign_agents_tab.dart';
import 'package:mirai_crm/widgets/campaigns/campaign_history_sheet.dart';
import 'package:mirai_crm/widgets/campaigns/campaign_leads_tab.dart';
import 'package:mirai_crm/widgets/campaigns/campaign_list_card.dart';
import 'package:mirai_crm/widgets/campaigns/campaign_overview_tab.dart';
import 'package:mirai_crm/widgets/campaigns/campaign_performance_tab.dart';

({Color bg, Color text}) _statusColors(String status) => switch (status) {
  'Active' => (bg: CommonColors.green50, text: CommonColors.green600),
  'Paused' => (bg: CommonColors.warning50, text: CommonColors.warning700),
  'Scheduled' => (bg: CommonColors.info50, text: CommonColors.info600),
  'Draft' => (bg: CommonColors.grey100, text: CommonColors.textSecondary),
  'Hold' => (bg: CommonColors.red50, text: CommonColors.red700),
  _ => (bg: CommonColors.grey100, text: CommonColors.textSecondary),
};

class CampaignDetailScreen extends StatefulWidget {
  final CampaignItem campaign;

  const CampaignDetailScreen({super.key, required this.campaign});

  @override
  State<CampaignDetailScreen> createState() => _CampaignDetailScreenState();
}

class _CampaignDetailScreenState extends State<CampaignDetailScreen> {
  static const _tabs = ['Overview', 'Leads', 'Agents', 'Performance'];

  late bool _isPaused;

  @override
  void initState() {
    super.initState();
    _isPaused = widget.campaign.status == 'Paused';
  }

  Future<void> _showPauseDialog() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => _PauseCampaignDialog(campaignName: widget.campaign.title),
    );
    if (confirmed == true) setState(() => _isPaused = true);
  }

  Future<void> _showResumeDialog() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => _ResumeCampaignDialog(campaignName: widget.campaign.title),
    );
    if (confirmed == true) setState(() => _isPaused = false);
  }

  @override
  Widget build(BuildContext context) {
    RS.init(context);
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        backgroundColor: CommonColors.scaffoldBgColor,
        appBar: CommonAppBar(title: 'Campaign Details'),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            _buildTabBar(),
            Expanded(
              child: TabBarView(
                children: [
                  CampaignOverviewTab(campaign: widget.campaign),
                  const CampaignLeadsTab(),
                  const CampaignAgentsTab(),
                  const CampaignPerformanceTab(),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: _buildBottomBar(),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      color: CommonColors.whiteColor,
      padding: EdgeInsets.fromLTRB(RS.HS(16), RS.VS(16), RS.HS(16), RS.VS(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: RS.HS(63),
                height: RS.HS(63),
                decoration: BoxDecoration(
                  color: CommonColors.info50,
                  borderRadius: BorderRadius.circular(RS.HS(14)),
                ),
                child: Padding(
                  padding: EdgeInsets.all(RS.HS(12)),
                  child: Image.asset(
                    CommonImg.crmFacebookPng,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(width: RS.HS(12)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.campaign.title,
                      style: TextStyle(
                        fontSize: RS.FS(18),
                        height: 1.0,
                        fontWeight: FontWeight.w700,
                        color: CommonColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: RS.VS(8)),
                    Text(
                      '+1 415 555-1451',
                      style: TextStyle(
                        fontSize: RS.FS(14),
                        fontWeight: FontWeight.w500,
                        height: 1.0,
                        color: CommonColors.textTertiary,
                      ),
                    ),
                    SizedBox(height: RS.VS(8)),
                    Text(
                      'm.rodrigues123@gmail.com',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        height: 1.0,
                        color: CommonColors.textTertiary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: RS.VS(14)),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              spacing: RS.HS(6),
              children: [
                _StatusBadge(status: widget.campaign.status),
                _InfoChip(
                  svgPath: CommonImg.crmMegaphoneOutlined,
                  label: 'FCFS',
                ),
                _AgentTeamChip(
                  memberCount: widget.campaign.memberCount,
                  teamCount: widget.campaign.teamCount,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      color: CommonColors.whiteColor,
      child: TabBar(
        isScrollable: true,
        tabAlignment: TabAlignment.center,
        labelColor: CommonColors.primaryColor,
        unselectedLabelColor: CommonColors.textTertiary,
        labelStyle: TextStyle(fontSize: RS.FS(14), fontWeight: FontWeight.w600),
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
    );
  }

  Widget _buildBottomBar() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.fromLTRB(
          RS.HS(16),
          RS.VS(12),
          RS.HS(16),
          RS.VS(12),
        ),
        decoration: BoxDecoration(
          color: CommonColors.whiteColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              offset: const Offset(0, -2),
              blurRadius: 8,
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => showCampaignHistorySheet(context),
                style: OutlinedButton.styleFrom(
                  foregroundColor: CommonColors.textPrimary,
                  side: const BorderSide(color: CommonColors.borderDefault),
                  padding: EdgeInsets.symmetric(vertical: RS.VS(14)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      CommonImg.crmClockOutlined,
                      width: RS.HS(16),
                      height: RS.HS(16),
                      colorFilter: const ColorFilter.mode(
                        CommonColors.textPrimary,
                        BlendMode.srcIn,
                      ),
                    ),
                    SizedBox(width: RS.HS(6)),
                    Text(
                      'History',
                      style: TextStyle(
                        fontSize: RS.FS(14),
                        fontWeight: FontWeight.w500,
                        color: CommonColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: RS.HS(12)),
            Expanded(
              child: ElevatedButton(
                onPressed: _isPaused ? _showResumeDialog : _showPauseDialog,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isPaused
                      ? const Color(0xFF16A34A)
                      : CommonColors.primaryColor,
                  foregroundColor: CommonColors.whiteColor,
                  padding: EdgeInsets.symmetric(vertical: RS.VS(14)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      _isPaused
                          ? CommonImg.crmPlayOutlined
                          : CommonImg.crmPauseOutlined,
                      width: RS.HS(16),
                      height: RS.HS(16),
                      colorFilter: const ColorFilter.mode(
                        CommonColors.whiteColor,
                        BlendMode.srcIn,
                      ),
                    ),
                    SizedBox(width: RS.HS(6)),
                    Text(
                      _isPaused ? 'Resume' : 'Pause',
                      style: TextStyle(
                        fontSize: RS.FS(14),
                        fontWeight: FontWeight.w600,
                        color: CommonColors.whiteColor,
                      ),
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
}

// ── Pause confirmation dialog ──────────────────────────────────────────────────

class _PauseCampaignDialog extends StatelessWidget {
  final String campaignName;

  const _PauseCampaignDialog({required this.campaignName});

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
                      CommonImg.crmPauseOutlined,
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
            Text(
              'Pause this campaign?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: RS.FS(18),
                fontWeight: FontWeight.w600,
                color: CommonColors.textPrimary,
              ),
            ),
            SizedBox(height: RS.VS(8)),
            Text(
              "New leads will stop being distributed to agent for '$campaignName'. Existing leads remain assigned. You can resume anytime.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: RS.FS(13),
                color: CommonColors.textTertiary,
              ),
            ),
            SizedBox(height: RS.VS(16)),
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
                      'Yes Pause',
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

// ── Resume confirmation dialog ─────────────────────────────────────────────────

class _ResumeCampaignDialog extends StatelessWidget {
  final String campaignName;

  const _ResumeCampaignDialog({required this.campaignName});

  static const _green = Color(0xFF16A34A);
  static const _greenLight = Color(0xFFDCFCE7);

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
            Container(
              width: RS.HS(54),
              height: RS.HS(54),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: _green, width: 1),
                color: _greenLight,
              ),
              child: Center(
                child: Container(
                  width: RS.HS(44),
                  height: RS.HS(44),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: _green,
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      CommonImg.crmPlayOutlined,
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
            Text(
              'Resume this campaign?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: RS.FS(18),
                fontWeight: FontWeight.w600,
                color: CommonColors.textPrimary,
              ),
            ),
            SizedBox(height: RS.VS(8)),
            Text(
              "Lead distribution will resume immediately for '$campaignName'. Agents will start receiving new leads again.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: RS.FS(13),
                color: CommonColors.textTertiary,
              ),
            ),
            SizedBox(height: RS.VS(16)),
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
                      backgroundColor: _green,
                      foregroundColor: CommonColors.whiteColor,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.symmetric(vertical: RS.VS(14)),
                    ),
                    child: Text(
                      'Yes Resume',
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

// ── Status badge ──────────────────────────────────────────────────────────────

class _StatusBadge extends StatelessWidget {
  final String status;

  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    RS.init(context);
    final sc = _statusColors(status);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: RS.HS(10), vertical: RS.VS(6)),
      decoration: BoxDecoration(
        color: sc.bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: RS.HS(6),
            height: RS.HS(6),
            decoration: BoxDecoration(color: sc.text, shape: BoxShape.circle),
          ),
          SizedBox(width: RS.HS(5)),
          Text(
            status,
            style: TextStyle(
              fontSize: RS.FS(12),
              fontWeight: FontWeight.w500,
              color: sc.text,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Info chip ─────────────────────────────────────────────────────────────────

class _InfoChip extends StatelessWidget {
  final String svgPath;
  final String label;

  const _InfoChip({required this.svgPath, required this.label});

  @override
  Widget build(BuildContext context) {
    RS.init(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: RS.HS(10), vertical: RS.VS(6)),
      decoration: BoxDecoration(
        color: CommonColors.grey150,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            svgPath,
            width: RS.HS(13),
            height: RS.HS(13),
            colorFilter: const ColorFilter.mode(
              CommonColors.textPrimary,
              BlendMode.srcIn,
            ),
          ),
          SizedBox(width: RS.HS(5)),
          Text(
            label,
            style: TextStyle(
              fontSize: RS.FS(12),
              fontWeight: FontWeight.w500,
              color: CommonColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Agent + Team combined chip ────────────────────────────────────────────────

class _AgentTeamChip extends StatelessWidget {
  final int memberCount;
  final int teamCount;

  const _AgentTeamChip({required this.memberCount, required this.teamCount});

  @override
  Widget build(BuildContext context) {
    RS.init(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: RS.HS(10), vertical: RS.VS(6)),
      decoration: BoxDecoration(
        color: CommonColors.grey150,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            CommonImg.crmPersonOutlined,
            width: RS.HS(13),
            height: RS.HS(13),
            colorFilter: const ColorFilter.mode(
              CommonColors.textPrimary,
              BlendMode.srcIn,
            ),
          ),
          SizedBox(width: RS.HS(4)),
          Text(
            '$memberCount Agent',
            style: TextStyle(
              fontSize: RS.FS(12),
              fontWeight: FontWeight.w500,
              color: CommonColors.textPrimary,
            ),
          ),
          SizedBox(width: RS.HS(8)),
          SvgPicture.asset(
            CommonImg.crmTeamOutlined,
            width: RS.HS(13),
            height: RS.HS(13),
            colorFilter: const ColorFilter.mode(
              CommonColors.textPrimary,
              BlendMode.srcIn,
            ),
          ),
          SizedBox(width: RS.HS(4)),
          Text(
            '$teamCount Teams',
            style: TextStyle(
              fontSize: RS.FS(12),
              fontWeight: FontWeight.w500,
              color: CommonColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
