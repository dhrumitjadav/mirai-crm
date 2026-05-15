import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mirai_crm/utils/responsive.dart';
import 'package:mirai_crm/utils/common_colors.dart';
import 'package:mirai_crm/utils/common_img.dart';
import 'package:mirai_crm/widgets/lead_detail/lead_detail_models.dart';

class UploadFileSheet extends StatefulWidget {
  final void Function(String name, String meta, LeadFileType type) onUpload;

  const UploadFileSheet({super.key, required this.onUpload});

  @override
  State<UploadFileSheet> createState() => _UploadFileSheetState();
}

class _UploadFileSheetState extends State<UploadFileSheet> {
  ({String name, String meta, LeadFileType type, String icon, Color color})?
  _selected;

  void _simulatePick(
    String name,
    String meta,
    LeadFileType type, {
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
    RS.init(context);
    return Container(
      decoration: const BoxDecoration(
        color: CommonColors.whiteColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
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
                  offset: Offset(0, 2),
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
                    RS.VS(16),
                    RS.HS(16),
                    RS.VS(16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Upload File',
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
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: CommonColors.grey75,
                          ),
                          child: Icon(
                            Icons.close,
                            size: RS.HS(18),
                            color: CommonColors.blackColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: RS.VS(4)),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: RS.HS(16),
              vertical: RS.VS(12),
            ),
            child: GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: RS.HS(12),
              mainAxisSpacing: RS.VS(12),
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
                    LeadFileType.image,
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
                    LeadFileType.image,
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
                    LeadFileType.pdf,
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
                    LeadFileType.audio,
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
                RS.HS(16),
                RS.VS(4),
                RS.HS(16),
                RS.VS(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ready To Upload',
                    style: TextStyle(
                      fontSize: RS.FS(13),
                      fontWeight: FontWeight.w600,
                      color: CommonColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: RS.VS(10)),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: RS.HS(12),
                      vertical: RS.VS(10),
                    ),
                    decoration: BoxDecoration(
                      color: CommonColors.whiteColor,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: CommonColors.borderSubtle),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: RS.HS(36),
                          height: RS.HS(36),
                          decoration: BoxDecoration(
                            color: _selected!.color,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                              _selected!.icon,
                              width: RS.HS(18),
                              height: RS.HS(18),
                              colorFilter: const ColorFilter.mode(
                                CommonColors.whiteColor,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: RS.HS(10)),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _selected!.name,
                                style: TextStyle(
                                  fontSize: RS.FS(13),
                                  fontWeight: FontWeight.w600,
                                  color: CommonColors.textPrimary,
                                ),
                              ),
                              Text(
                                _selected!.meta,
                                style: TextStyle(
                                  fontSize: RS.FS(11),
                                  color: CommonColors.textTertiary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () => setState(() => _selected = null),
                          child: Container(
                            width: RS.HS(32),
                            height: RS.HS(32),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: CommonColors.grey75,
                            ),
                            child: Icon(
                              Icons.close,
                              size: RS.HS(16),
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
              RS.HS(16),
              RS.VS(4),
              RS.HS(16),
              RS.VS(24) + MediaQuery.of(context).padding.bottom,
            ),
            child: SizedBox(
              width: double.infinity,
              height: RS.VS(52),
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
              width: RS.HS(48),
              height: RS.HS(48),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Center(
                child: SvgPicture.asset(
                  icon,
                  width: RS.HS(24),
                  height: RS.HS(24),
                  colorFilter: const ColorFilter.mode(
                    CommonColors.whiteColor,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            SizedBox(height: RS.VS(8)),
            Text(
              label,
              style: TextStyle(
                fontSize: RS.FS(13),
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
