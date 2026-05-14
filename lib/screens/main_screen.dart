import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:mirai_crm/screens/campaigns/campaigns_screen.dart';
import 'package:mirai_crm/screens/dashboard/dashboard_screen.dart';
import 'package:mirai_crm/screens/leads/add_lead_screen.dart';
import 'package:mirai_crm/screens/leads/leads_screen.dart';
import 'package:mirai_crm/screens/more/more_screen.dart';
import 'package:mirai_crm/screens/task/task_screen.dart';
import 'package:mirai_crm/utils/app_size.dart';
import 'package:mirai_crm/utils/common_colors.dart';
import 'package:mirai_crm/utils/common_img.dart';
import 'package:mirai_crm/widgets/dashboard/quick_action_card.dart';
import 'package:mirai_crm/widgets/more_bottom_sheet.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 3;

  static const _screens = <Widget>[
    LeadsScreen(),
    CampaignsScreen(),
    TaskScreen(),
    DashboardScreen(),
    MoreScreen(),
  ];

  static const _items = [
    _NavItem(
      label: 'Leads',
      outlined: CommonImg.crmLeadsOutlined,
      filled: CommonImg.crmLeadsFilled,
    ),
    _NavItem(
      label: 'Campaigns',
      outlined: CommonImg.crmMegaphoneOutlined,
      filled: CommonImg.crmMegaphoneFilled,
    ),
    _NavItem(
      label: 'Task',
      outlined: CommonImg.crmTaskOutlined,
      filled: CommonImg.crmTaskFilled,
    ),
    _NavItem(
      label: 'Dashboard',
      outlined: CommonImg.crmDashboardOutlined,
      filled: CommonImg.crmDashboardFilled,
    ),
    _NavItem(
      label: 'More',
      outlined: CommonImg.crmListOutlined,
      filled: CommonImg.crmListOutlined,
    ),
  ];

  // static const _titles = ['Leads', 'Campaigns', 'Task', '', 'More'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CommonColors.scaffoldBgColor,
      appBar: _buildAppBar(context),
      body: IndexedStack(index: _selectedIndex, children: _screens),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(splashFactory: NoSplash.splashFactory),
        child: Container(
          decoration: BoxDecoration(
            color: CommonColors.whiteColor,
            boxShadow: [
              BoxShadow(
                color: CommonColors.blackColor.withValues(alpha: 0.03),
                offset: Offset(0, -5),
                blurStyle: BlurStyle.normal,
                blurRadius: context.h(24),
                spreadRadius: 0,
              ),
            ],
          ),
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: (i) {
              if (i == 4) {
                showMoreBottomSheet(context);
              } else {
                setState(() => _selectedIndex = i);
              }
            },
            type: BottomNavigationBarType.fixed,
            selectedItemColor: CommonColors.appRedColor,
            unselectedItemColor: CommonColors.grey475569,
            selectedLabelStyle: const TextStyle(fontSize: 12),
            unselectedLabelStyle: const TextStyle(fontSize: 12),
            backgroundColor: CommonColors.whiteColor,
            elevation: 0,
            items: _items
                .map(
                  (item) => BottomNavigationBarItem(
                    label: item.label,
                    icon: Container(
                      margin: EdgeInsets.only(bottom: context.h(8)),
                      child: SvgPicture.asset(
                        item.outlined,
                        width: 28,
                        height: 28,
                        colorFilter: const ColorFilter.mode(
                          CommonColors.grey475569,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                    activeIcon: Container(
                      margin: EdgeInsets.only(bottom: context.h(8)),
                      child: SvgPicture.asset(
                        item.filled,
                        width: 28,
                        height: 28,
                        colorFilter: const ColorFilter.mode(
                          CommonColors.appRedColor,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    final isDashboard = _selectedIndex == 3;
    final isLeads = _selectedIndex == 0;

    return AppBar(
      title: Row(
        children: [
          Image.asset(CommonImg.appLogo, height: context.h(35)),
          SizedBox(width: context.w(2)),
          Text(
            'Mirai',
            style: TextStyle(
              fontSize: context.s(18),
              fontWeight: FontWeight.w800,
              color: CommonColors.textPrimary,
            ),
          ),
        ],
      ),
      actions: [
        Stack(
          children: [
            Container(
              margin: const EdgeInsets.all(5),
              width: context.w(38),
              height: context.w(38),
              decoration: const BoxDecoration(
                color: Color(0xFFF0F2F5),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: SvgPicture.asset(
                  CommonImg.crmBellOutlined,
                  width: context.w(18),
                  height: context.w(18),
                  colorFilter: const ColorFilter.mode(
                    CommonColors.textPrimary,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            Positioned(
              top: context.h(4),
              right: context.w(6),
              child: Container(
                width: context.w(6),
                height: context.w(6),
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.all(5),
          width: context.w(36),
          height: context.w(36),
          decoration: BoxDecoration(
            color: CommonColors.greyF8F8F8,
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage(CommonImg.profilePicture),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
      bottom: isDashboard
          ? PreferredSize(
              preferredSize: const Size.fromHeight(156),
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: CommonColors.borderSubtle),
                  ),
                ),
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSearchBar(context),
                    const SizedBox(height: 12),
                    _buildQuickActions(context),
                  ],
                ),
              ),
            )
          : isLeads
          ? PreferredSize(
              preferredSize: const Size.fromHeight(56),
              child: Container(
                // decoration: BoxDecoration(
                //   border: Border(bottom: BorderSide(color: CommonColors.borderDefault)),
                // ),
                padding: EdgeInsets.fromLTRB(
                  context.w(16),
                  0,
                  context.w(16),
                  context.h(10),
                ),
                child: Row(
                  children: [
                    Expanded(child: _buildLeadsSearchBar(context)),
                    SizedBox(width: context.w(8)),
                    _buildIconBtn(context, CommonImg.crmFunnelOutlined),
                    SizedBox(width: context.w(8)),
                    _buildAddBtn(context),
                  ],
                ),
              ),
            )
          : null,
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return TextFormField(
      style: TextStyle(
        fontSize: context.s(12),
        color: CommonColors.textPrimary,
      ),
      decoration: InputDecoration(
        hintText: 'Search leads, campaigns...',
        hintStyle: TextStyle(
          fontSize: context.s(12),
          color: CommonColors.greyAEAEAE,
        ),
        prefixIcon: Icon(
          Icons.search,
          size: context.w(18),
          color: CommonColors.greyAEAEAE,
        ),
        filled: true,
        fillColor: const Color(0xFFF0F2F5),
        contentPadding: EdgeInsets.symmetric(vertical: context.h(11)),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: QuickActionCard(
            label: 'All Leads',
            subtitle: 'Browse all leads',
            svgIcon: CommonImg.crmLeadsOutlined,
            color: CommonColors.red500,
            onTap: () {},
          ),
        ),
        SizedBox(width: context.w(10)),

        Expanded(
          child: QuickActionCard(
            label: 'View Campaigns',
            subtitle: 'Manage Campaigns',
            svgIcon: CommonImg.crmMegaphoneOutlined,
            color: CommonColors.info600,
            onTap: () {},
          ),
        ),
      ],
    );
  }

  Widget _buildLeadsSearchBar(BuildContext context) {
    return SizedBox(
      height: context.h(38),
      child: TextFormField(
        style: TextStyle(
          fontSize: context.s(12),
          color: CommonColors.textPrimary,
        ),
        decoration: InputDecoration(
          hintText: 'Search leads...',
          hintStyle: TextStyle(
            fontSize: context.s(12),
            color: CommonColors.greyAEAEAE,
          ),
          prefixIcon: Icon(
            Icons.search,
            size: context.w(16),
            color: CommonColors.greyAEAEAE,
          ),
          filled: true,
          fillColor: const Color(0xFFF0F2F5),
          contentPadding: EdgeInsets.zero,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildIconBtn(BuildContext context, String svgPath) {
    return Container(
      width: context.w(38),
      height: context.h(38),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F2F5),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: SvgPicture.asset(
          svgPath,
          width: context.w(16),
          height: context.w(16),
          colorFilter: const ColorFilter.mode(
            CommonColors.grey475569,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }

  Widget _buildAddBtn(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => AddLeadScreen());
      },
      child: Container(
        height: context.h(38),
        padding: EdgeInsets.symmetric(horizontal: context.w(14)),
        decoration: BoxDecoration(
          color: CommonColors.primaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.add,
              size: context.w(16),
              color: CommonColors.whiteColor,
            ),
            SizedBox(width: context.w(4)),
            Text(
              'Add',
              style: TextStyle(
                fontSize: context.s(12),
                fontWeight: FontWeight.w600,
                color: CommonColors.whiteColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem {
  final String label;
  final String outlined;
  final String filled;

  const _NavItem({
    required this.label,
    required this.outlined,
    required this.filled,
  });
}
