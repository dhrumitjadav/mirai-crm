import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mirai_crm/utils/app_size.dart';
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
    return DraggableScrollableSheet(
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
            _buildHandle(context),
            _buildProfile(context),
            Expanded(
              child: ListView(
                controller: controller,
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).padding.bottom + context.h(16),
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
      padding: EdgeInsets.only(top: context.h(12), bottom: context.h(8)),
      child: Container(
        width: context.w(40),
        height: context.h(4),
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
        horizontal: context.w(16),
        vertical: context.h(12),
      ),
      child: Row(
        children: [
          Container(
            width: context.w(52),
            height: context.w(52),
            decoration: BoxDecoration(
              color: CommonColors.greyF8F8F8,
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: AssetImage(CommonImg.profilePicture),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: context.w(12)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'John Walter',
                  style: TextStyle(
                    fontSize: context.s(16),
                    fontWeight: FontWeight.w700,
                    color: CommonColors.textPrimary,
                  ),
                ),
                SizedBox(height: context.h(3)),
                Row(
                  children: [
                    Container(
                      width: context.w(7),
                      height: context.w(7),
                      decoration: const BoxDecoration(
                        color: CommonColors.success500,
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(width: context.w(5)),
                    Text(
                      'Sales Manager – Active',
                      style: TextStyle(
                        fontSize: context.s(12),
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
            width: context.w(18),
            height: context.w(18),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(
            context.w(16),
            context.h(16),
            context.w(16),
            context.h(8),
          ),
          child: Text(
            section.label,
            style: TextStyle(
              fontSize: context.s(11),
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
                AppDivider(indent: context.w(15), endIndent: context.w(15)),
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
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.w(16),
          vertical: context.h(16),
        ),
        child: Row(
          children: [
            Container(
              width: context.w(44),
              height: context.w(44),
              decoration: BoxDecoration(
                color: item.iconBg,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: SvgPicture.asset(
                  item.icon,
                  width: context.w(22),
                  height: context.w(22),
                  colorFilter: ColorFilter.mode(
                    item.iconColor ?? CommonColors.whiteColor,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            SizedBox(width: context.w(16)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.label,
                    style: TextStyle(
                      fontSize: context.s(15),
                      fontWeight: FontWeight.w600,
                      color: CommonColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: context.h(2)),
                  Text(
                    item.subtitle,
                    style: TextStyle(
                      fontSize: context.s(13),
                      color: CommonColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            SvgPicture.asset(
              CommonImg.crmArrowRightOutlined,
              width: context.w(18),
              height: context.w(18),
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
