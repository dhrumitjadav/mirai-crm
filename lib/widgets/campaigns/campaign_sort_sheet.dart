import 'package:flutter/material.dart';
import 'package:mirai_crm/utils/common_colors.dart';
import 'package:mirai_crm/utils/responsive.dart';
import 'package:mirai_crm/widgets/app_divider.dart';

void showCampaignSortSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (_) => const _CampaignSortSheet(),
  );
}

class _CampaignSortSheet extends StatefulWidget {
  const _CampaignSortSheet();

  @override
  State<_CampaignSortSheet> createState() => _CampaignSortSheetState();
}

class _CampaignSortSheetState extends State<_CampaignSortSheet> {
  String _selected = 'Recently Created';

  static const _options = [
    'Recently Created',
    'Name (A - Z)',
    'Most Leads',
    'Highest Conversion',
    'Ending soonest',
  ];

  @override
  Widget build(BuildContext context) {
    RS.init(context);
    return Container(
      decoration: const BoxDecoration(
        color: CommonColors.bottomSheetBgColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
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
              children: [_buildHandle(), _buildHeader(context)],
            ),
          ),
          AppDivider(indent: 20, endIndent: 20),
          ...List.generate(
            _options.length,
            (i) => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildOption(context, _options[i]),
                if (i < _options.length - 1)
                  AppDivider(indent: 20, endIndent: 20),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(RS.HS(16)),
            child: SizedBox(
              width: double.infinity,
              height: RS.VS(50),
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: CommonColors.primaryColor,
                  foregroundColor: CommonColors.whiteColor,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Apply',
                  style: TextStyle(
                    fontSize: RS.FS(16),
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

  Widget _buildHandle() {
    return Padding(
      padding: EdgeInsets.only(top: RS.VS(12), bottom: RS.VS(4)),
      child: Container(
        width: RS.HS(40),
        height: RS.VS(4),
        decoration: BoxDecoration(
          color: CommonColors.blackColor.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: RS.HS(16),
        vertical: RS.VS(14),
      ),
      child: Row(
        children: [
          Text(
            'Sort Campaigns',
            style: TextStyle(
              fontSize: RS.FS(20),
              fontWeight: FontWeight.w600,
              color: CommonColors.textPrimary,
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.close,
              size: RS.HS(22),
              color: CommonColors.blackColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOption(BuildContext context, String label) {
    final isSelected = _selected == label;
    return InkWell(
      onTap: () => setState(() => _selected = label),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: RS.HS(20),
          vertical: RS.VS(14),
        ),
        child: Row(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: RS.FS(15),
                color: isSelected
                    ? CommonColors.primaryColor
                    : CommonColors.textPrimary,
              ),
            ),
            const Spacer(),
            Container(
              width: RS.HS(22),
              height: RS.HS(22),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected
                    ? CommonColors.primaryColor
                    : Colors.transparent,
                border: Border.all(
                  color: isSelected
                      ? CommonColors.primaryColor
                      : CommonColors.grey300,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: RS.HS(8),
                        height: RS.HS(8),
                        decoration: const BoxDecoration(
                          color: CommonColors.whiteColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
