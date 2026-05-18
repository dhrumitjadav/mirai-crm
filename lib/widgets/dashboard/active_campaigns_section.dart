import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mirai_crm/utils/responsive.dart';
import 'package:mirai_crm/utils/common_colors.dart';
import 'package:mirai_crm/utils/common_img.dart';
import 'package:mirai_crm/widgets/app_card.dart';

class ActiveCampaignsSection extends StatelessWidget {
  const ActiveCampaignsSection({super.key});

  static final _campaigns = [
    _Campaign(
      title: 'Q3 enterprise outreach',
      subtitle: '145 leads · \$1,200',
      progress: '10/145',
      svgIcon: CommonImg.crmMailOutlined,
    ),
    _Campaign(
      title: 'SaaS webinar promos',
      subtitle: '312 leads · \$3,400',
      progress: '80/312',
      svgIcon: CommonImg.crmMessageOutlined,
    ),
    _Campaign(
      title: 'Retargeting display ads',
      subtitle: '54 leads · \$850',
      progress: '10/52',
      svgIcon: CommonImg.crmStarOutlined,
    ),
  ];

  static const _iconBg = Color(0xFFEEF2FF);
  static const _iconColor = Color(0xFF4B6CF5);

  @override
  Widget build(BuildContext context) {
    RS.init(context);
    return AppCard(
      radius: 10,
      title: 'Active Campaigns',
      onViewAll: () {},
      child: Padding(
        padding: EdgeInsets.fromLTRB(RS.HS(16), RS.VS(0), RS.HS(16), RS.VS(16)),
        child: Column(
          children: [
            SizedBox(height: RS.VS(12)),
            ..._campaigns.map((c) => _CampaignCard(campaign: c)),
          ],
        ),
      ),
    );
  }
}

class _CampaignCard extends StatelessWidget {
  final _Campaign campaign;

  const _CampaignCard({required this.campaign});

  @override
  Widget build(BuildContext context) {
    RS.init(context);
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        splashColor: CommonColors.grey50,
        highlightColor: CommonColors.grey50,
        onTap: () {
          log('--------${campaign.title}');
        },
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: RS.VS(12),
            // horizontal: RS.HS(12),
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(RS.HS(10)),
                decoration: BoxDecoration(
                  color: ActiveCampaignsSection._iconBg,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SvgPicture.asset(
                  fit: BoxFit.fitHeight,
                  height: RS.VS(18),
                  campaign.svgIcon,
                  colorFilter: ColorFilter.mode(
                    ActiveCampaignsSection._iconColor,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              SizedBox(width: RS.HS(12)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      campaign.title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: RS.FS(14),
                        fontWeight: FontWeight.w700,
                        color: CommonColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: RS.VS(2)),
                    Text(
                      campaign.subtitle,
                      style: TextStyle(
                        fontSize: RS.FS(12),
                        color: CommonColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: RS.HS(12)),

              Text(
                campaign.progress,
                style: TextStyle(
                  fontSize: RS.FS(14),
                  fontWeight: FontWeight.w500,
                  color: CommonColors.textSecondary,
                ),
              ),
              SizedBox(width: RS.HS(4)),
              SvgPicture.asset(
                CommonImg.crmArrowRightOutlined,
                colorFilter: ColorFilter.mode(
                  CommonColors.greyAEAEAE,
                  BlendMode.srcIn,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Campaign {
  final String title;
  final String subtitle;
  final String progress;
  final String svgIcon;

  const _Campaign({
    required this.title,
    required this.subtitle,
    required this.progress,
    required this.svgIcon,
  });
}
