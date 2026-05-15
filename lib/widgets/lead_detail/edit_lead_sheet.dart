import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mirai_crm/utils/responsive.dart';
import 'package:mirai_crm/utils/common_colors.dart';
import 'package:mirai_crm/utils/common_dropdown.dart';
import 'package:mirai_crm/utils/common_img.dart';
import 'package:mirai_crm/utils/common_text_field.dart';

class EditLeadSheet extends StatefulWidget {
  const EditLeadSheet({super.key});

  @override
  State<EditLeadSheet> createState() => _EditLeadSheetState();
}

class _EditLeadSheetState extends State<EditLeadSheet> {
  final _nameCtrl = TextEditingController(text: 'Rohan Mehta');
  final _phoneCtrl = TextEditingController(text: '9876543210');
  final _emailCtrl = TextEditingController(text: 'rohan.mehta@gmail.com');
  final _budgetMinCtrl = TextEditingController(text: '250');
  final _budgetMaxCtrl = TextEditingController(text: '1000');
  final _notesCtrl = TextEditingController(
    text:
        'Looking for 2BHK in west Ahmedabad. Prefers site visits on weekends. Budget slightly flexible if location is prime.',
  );

  String? _city = 'Ahmedabad';
  String? _source = 'Facebook Ads';
  String? _campaign = 'Facebook Ads';
  String _priority = 'Low';
  String? _team = 'Sales Team A';
  String? _agent = 'Priya Shah';
  String? _industry = 'Real Estate';

  @override
  void dispose() {
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
    _emailCtrl.dispose();
    _budgetMinCtrl.dispose();
    _budgetMaxCtrl.dispose();
    _notesCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    RS.init(context);
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
                      RS.VS(12),
                      RS.HS(16),
                      RS.VS(16),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Edit',
                          style: TextStyle(
                            fontSize: RS.FS(16),
                            fontWeight: FontWeight.w700,
                            color: CommonColors.textPrimary,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            width: RS.HS(28),
                            height: RS.HS(28),
                            decoration: BoxDecoration(
                              color: CommonColors.grey100,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              Icons.close,
                              size: RS.HS(16),
                              color: CommonColors.textSecondary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(
                  RS.HS(16),
                  RS.VS(16),
                  RS.HS(16),
                  RS.VS(24) + MediaQuery.of(context).padding.bottom,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _label('Full Name'),
                    SizedBox(height: RS.VS(6)),
                    CommonTextField(
                      controller: _nameCtrl,
                      hint: 'Write Your Full Name Here',
                      textInputAction: TextInputAction.next,
                    ),
                    SizedBox(height: RS.VS(16)),
                    _label('Phone Number'),
                    SizedBox(height: RS.VS(6)),
                    CommonTextField(
                      controller: _phoneCtrl,
                      hint: 'Write Your Phone Number Here',
                      isPhoneNumber: true,
                      isApplyInputFormatter: true,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      textInputAction: TextInputAction.next,
                      prefixIcon: _svgPrefix(CommonImg.crmPhoneOutlined),
                    ),
                    SizedBox(height: RS.VS(16)),
                    _label('Email', required: false),
                    SizedBox(height: RS.VS(6)),
                    CommonTextField(
                      controller: _emailCtrl,
                      hint: 'Write Your Email Here',
                      textInputAction: TextInputAction.next,
                      prefixIcon: _svgPrefix(CommonImg.crmMailOutlined),
                    ),
                    SizedBox(height: RS.VS(16)),
                    _label('City'),
                    SizedBox(height: RS.VS(6)),
                    CommonDropdown(
                      hint: 'Select City',
                      value: _city,
                      items: const [
                        'Ahmedabad',
                        'Mumbai',
                        'Delhi',
                        'Bangalore',
                        'Pune',
                      ],
                      onChanged: (v) => setState(() => _city = v),
                    ),
                    SizedBox(height: RS.VS(16)),
                    _label('Source'),
                    SizedBox(height: RS.VS(6)),
                    CommonDropdown(
                      hint: 'Your Lead Source',
                      value: _source,
                      items: const [
                        'Facebook Ads',
                        'Google Ad',
                        'Referral',
                        'Website',
                        'Walk-in',
                      ],
                      onChanged: (v) => setState(() => _source = v),
                    ),
                    SizedBox(height: RS.VS(16)),
                    _label('Campaign'),
                    SizedBox(height: RS.VS(6)),
                    CommonDropdown(
                      hint: 'Select Campaign',
                      value: _campaign,
                      items: const [
                        'Facebook Ads',
                        'Summer Sale',
                        'Q1 Outreach',
                        'Product Launch',
                      ],
                      onChanged: (v) => setState(() => _campaign = v),
                    ),
                    SizedBox(height: RS.VS(16)),
                    _label('Priority', required: false),
                    SizedBox(height: RS.VS(10)),
                    _buildPrioritySelector(),
                    SizedBox(height: RS.VS(16)),
                    _label('Budget', required: false),
                    SizedBox(height: RS.VS(10)),
                    _buildBudgetFields(),
                    SizedBox(height: RS.VS(16)),
                    _label('Team'),
                    SizedBox(height: RS.VS(6)),
                    CommonDropdown(
                      hint: 'Select Team',
                      value: _team,
                      items: const ['Sales Team A', 'Sales Team B', 'Support'],
                      onChanged: (v) => setState(() => _team = v),
                    ),
                    SizedBox(height: RS.VS(16)),
                    _label('Assign To Agent'),
                    SizedBox(height: RS.VS(6)),
                    CommonDropdown(
                      hint: 'Select Agent',
                      value: _agent,
                      items: const [
                        'Priya Shah',
                        'Nour',
                        'Alex',
                        'Sara',
                        'John',
                      ],
                      onChanged: (v) => setState(() => _agent = v),
                    ),
                    SizedBox(height: RS.VS(16)),
                    _label('Industry'),
                    SizedBox(height: RS.VS(6)),
                    CommonDropdown(
                      hint: 'Select Industry',
                      value: _industry,
                      items: const [
                        'Real Estate',
                        'Finance',
                        'Healthcare',
                        'Technology',
                        'Retail',
                      ],
                      onChanged: (v) => setState(() => _industry = v),
                    ),
                    SizedBox(height: RS.VS(16)),
                    _label('Notes', required: false, suffix: '(optional)'),
                    SizedBox(height: RS.VS(6)),
                    CommonTextField(
                      controller: _notesCtrl,
                      hint: 'Write anything here',
                      maxLines: 4,
                    ),
                    SizedBox(height: RS.VS(24)),
                    SizedBox(
                      width: double.infinity,
                      height: RS.VS(52),
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: CommonColors.primaryColor,
                          foregroundColor: CommonColors.whiteColor,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Save Lead',
                          style: TextStyle(
                            fontSize: RS.FS(16),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
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

  Widget _label(String text, {bool required = true, String? suffix}) {
    return Row(
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: RS.FS(14),
            height: 1.25,
            color: CommonColors.textPrimary,
          ),
        ),
        if (required)
          Text(
            ' *',
            style: TextStyle(fontSize: RS.FS(12), color: Colors.red),
          ),
        if (suffix != null) ...[
          SizedBox(width: RS.HS(4)),
          Text(
            suffix,
            style: TextStyle(
              fontSize: RS.FS(13),
              color: CommonColors.textTertiary,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildPrioritySelector() {
    const priorities = ['Low', 'Medium', 'High', 'Urgent'];
    return Row(
      children: priorities.map((p) {
        final isSelected = _priority == p;
        return Padding(
          padding: EdgeInsets.only(right: RS.HS(8)),
          child: GestureDetector(
            onTap: () => setState(() => _priority = p),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: RS.HS(16),
                vertical: RS.VS(8),
              ),
              decoration: BoxDecoration(
                color: isSelected
                    ? CommonColors.red50
                    : CommonColors.whiteColor,
                border: Border.all(
                  color: isSelected
                      ? CommonColors.red300
                      : CommonColors.borderDefault,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                p,
                style: TextStyle(
                  fontSize: RS.FS(14),
                  height: 1.25,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  color: isSelected
                      ? CommonColors.red500
                      : CommonColors.textSecondary,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildBudgetFields() {
    return Row(
      children: [
        Expanded(
          child: _buildBudgetField(
            label: 'Min',
            controller: _budgetMinCtrl,
            hint: '\$ 250',
          ),
        ),
        SizedBox(width: RS.HS(12)),
        Expanded(
          child: _buildBudgetField(
            label: 'Max',
            controller: _budgetMaxCtrl,
            hint: '\$ 1000',
          ),
        ),
      ],
    );
  }

  Widget _buildBudgetField({
    required String label,
    required TextEditingController controller,
    required String hint,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: CommonColors.whiteColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: CommonColors.borderDefault),
      ),
      padding: EdgeInsets.symmetric(horizontal: RS.HS(14), vertical: RS.VS(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: RS.FS(11),
              color: CommonColors.textTertiary,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: RS.VS(2)),
          TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            style: TextStyle(
              fontSize: RS.FS(14),
              fontWeight: FontWeight.w500,
              height: 1.3,
              color: CommonColors.primaryColor,
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                fontSize: RS.FS(14),
                color: CommonColors.primaryColor,
              ),
              isDense: true,
              contentPadding: EdgeInsets.zero,
              border: InputBorder.none,
            ),
          ),
        ],
      ),
    );
  }

  Widget _svgPrefix(String assetPath) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: RS.HS(12)),
      child: SvgPicture.asset(
        assetPath,
        width: RS.HS(18),
        height: RS.HS(18),
        colorFilter: const ColorFilter.mode(
          CommonColors.textTertiary,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}
