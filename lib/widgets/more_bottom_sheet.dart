import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mirai_crm/utils/responsive.dart';
import 'package:mirai_crm/utils/common_colors.dart';
import 'package:mirai_crm/utils/common_img.dart';
import 'package:mirai_crm/widgets/app_divider.dart';

void showMoreBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => const _MoreSheet(),
  );
}

class _MoreSheet extends StatelessWidget {
  const _MoreSheet();

  static final _sections = const [
    _Section(
      label: 'WORK',
      items: [
        _Item(
          label: 'Leaves',
          subtitle: '5 pending approvals',
          icon: CommonImg.crmCalendarOutlined,
          iconBg: CommonColors.warning600,
        ),
        _Item(
          label: 'Services / Products',
          subtitle: '3 templates',
          icon: CommonImg.crmStarOutlined,
          iconBg: Color(0xff9333EA),
        ),
        _Item(
          label: 'Leads Stages',
          subtitle: 'Set leads Stages',
          icon: CommonImg.crmBarChartOutlined,
          iconBg: CommonColors.percent61to80,
        ),
        _Item(
          label: 'Leads Priority',
          subtitle: 'Set leads Priority',
          icon: CommonImg.crmTrendingUpOutlined,
          iconBg: CommonColors.error500,
        ),
        _Item(
          label: 'Reports',
          subtitle: 'Analytics & exports',
          icon: CommonImg.crmMailOutlined,
          iconBg: CommonColors.grey600,
        ),
        _Item(
          label: 'AI Sales Agent',
          subtitle: 'Leverage the AI into Sales',
          icon: CommonImg.crmAiOutlined,
          iconBg: Color(0xFFEA580C),
        ),
      ],
    ),
    _Section(
      label: 'PEOPLE',
      items: [
        _Item(
          label: 'Teams',
          subtitle: '12 Total teams',
          icon: CommonImg.crmFlagOutlined,
          iconBg: CommonColors.info600,
        ),
        _Item(
          label: 'Agents',
          subtitle: '22 Total agents',
          icon: CommonImg.crmPersonOutlined,
          iconBg: CommonColors.green600,
        ),
      ],
    ),
    _Section(
      label: 'ACCOUNT',
      items: [
        _Item(
          label: 'Billing & Plan',
          subtitle: 'Manage your subscription',
          icon: CommonImg.crmCardOutlined,
          iconBg: CommonColors.info600,
        ),
      ],
    ),
    _Section(
      label: 'More',
      items: [
        _Item(
          label: 'Help Desk',
          subtitle: 'Support & tickets',
          icon: CommonImg.crmClockOutlined,
          iconColor: CommonColors.grey600,
          iconBg: CommonColors.grey50,
        ),
        _Item(
          label: 'Settings',
          subtitle: 'App preferences',
          icon: CommonImg.crmSettingGearOutlined,
          iconBg: CommonColors.grey600,
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    RS.init(context);
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.85,
      minChildSize: 0.5,
      maxChildSize: 0.95,
      builder: (_, controller) => Container(
        decoration: const BoxDecoration(
          color: CommonColors.whiteColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
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
                  _buildHandle(context),
                  _buildProfile(context),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                controller: controller,
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).padding.bottom + RS.VS(16),
                ),
                children: _sections
                    .map((s) => _SectionWidget(section: s))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHandle(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: RS.VS(12), bottom: RS.VS(8)),
      child: Container(
        width: RS.HS(40),
        height: RS.VS(4),
        decoration: BoxDecoration(
          color: CommonColors.grey300,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }

  Widget _buildProfile(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: RS.HS(16),
        vertical: RS.VS(12),
      ),
      child: Row(
        children: [
          Container(
            width: RS.HS(52),
            height: RS.HS(52),
            decoration: BoxDecoration(
              color: CommonColors.greyF8F8F8,
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: AssetImage(CommonImg.profilePicture),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: RS.HS(12)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'John Walter',
                  style: TextStyle(
                    fontSize: RS.FS(16),
                    fontWeight: FontWeight.w700,
                    color: CommonColors.textPrimary,
                  ),
                ),
                SizedBox(height: RS.VS(3)),
                Row(
                  children: [
                    Container(
                      width: RS.HS(7),
                      height: RS.HS(7),
                      decoration: const BoxDecoration(
                        color: CommonColors.success500,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: RS.HS(5)),
                    Text(
                      'Sales Manager – Active',
                      style: TextStyle(
                        fontSize: RS.FS(12),
                        color: CommonColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SvgPicture.asset(
            CommonImg.crmArrowRightOutlined,
            width: RS.HS(18),
            height: RS.HS(18),
            colorFilter: const ColorFilter.mode(
              CommonColors.greyAEAEAE,
              BlendMode.srcIn,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionWidget extends StatelessWidget {
  final _Section section;

  const _SectionWidget({required this.section});

  @override
  Widget build(BuildContext context) {
    RS.init(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(
            RS.HS(16),
            RS.VS(16),
            RS.HS(16),
            RS.VS(8),
          ),
          child: Text(
            section.label,
            style: TextStyle(
              fontSize: RS.FS(11),
              fontWeight: FontWeight.w600,
              letterSpacing: 0.8,
              color: CommonColors.textPrimary,
            ),
          ),
        ),
        Column(
          children: List.generate(section.items.length, (i) {
            final item = section.items[i];
            return Column(
              children: [
                _ItemTile(item: item),
                AppDivider(indent: RS.HS(15), endIndent: RS.HS(15)),
              ],
            );
          }),
        ),
      ],
    );
  }
}

class _ItemTile extends StatelessWidget {
  final _Item item;

  const _ItemTile({required this.item});

  @override
  Widget build(BuildContext context) {
    RS.init(context);
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: RS.HS(16),
          vertical: RS.VS(16),
        ),
        child: Row(
          children: [
            Container(
              width: RS.HS(44),
              height: RS.HS(44),
              decoration: BoxDecoration(
                color: item.iconBg,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: SvgPicture.asset(
                  item.icon,
                  width: RS.HS(22),
                  height: RS.HS(22),
                  colorFilter: ColorFilter.mode(
                    item.iconColor ?? CommonColors.whiteColor,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            SizedBox(width: RS.HS(16)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.label,
                    style: TextStyle(
                      fontSize: RS.FS(15),
                      fontWeight: FontWeight.w600,
                      color: CommonColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: RS.VS(2)),
                  Text(
                    item.subtitle,
                    style: TextStyle(
                      fontSize: RS.FS(13),
                      color: CommonColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            SvgPicture.asset(
              CommonImg.crmArrowRightOutlined,
              width: RS.HS(18),
              height: RS.HS(18),
              colorFilter: const ColorFilter.mode(
                CommonColors.grey350,
                BlendMode.srcIn,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Section {
  final String label;
  final List<_Item> items;

  const _Section({required this.label, required this.items});
}

class _Item {
  final String label;
  final String subtitle;
  final String icon;
  final Color? iconColor;
  final Color iconBg;

  const _Item({
    required this.label,
    required this.subtitle,
    required this.icon,
    this.iconColor,
    required this.iconBg,
  });
}
