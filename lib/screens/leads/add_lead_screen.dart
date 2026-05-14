import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mirai_crm/utils/app_size.dart';
import 'package:mirai_crm/utils/common_app_bar.dart';
import 'package:mirai_crm/utils/common_colors.dart';
import 'package:mirai_crm/utils/common_img.dart';
import 'package:mirai_crm/utils/common_dropdown.dart';
import 'package:mirai_crm/utils/common_text_field.dart';

class AddLeadScreen extends StatefulWidget {
  const AddLeadScreen({super.key});

  @override
  State<AddLeadScreen> createState() => _AddLeadScreenState();
}

class _AddLeadScreenState extends State<AddLeadScreen> {
  int _step = 1;
  static const int _totalSteps = 3;

  // Step 1
  final _nameCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _cityCtrl = TextEditingController();
  final _nameFocus = FocusNode();
  final _phoneFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _cityFocus = FocusNode();

  // Step 2
  String? _source;
  String? _campaign;
  String _priority = 'Low';
  final _budgetMinCtrl = TextEditingController();
  final _budgetMaxCtrl = TextEditingController();

  // Step 3
  String? _team;
  String? _agent;
  String? _industry;
  final _notesCtrl = TextEditingController();

  @override
  void dispose() {
    _nameCtrl.dispose();
    _phoneCtrl.dispose();
    _emailCtrl.dispose();
    _cityCtrl.dispose();
    _budgetMinCtrl.dispose();
    _budgetMaxCtrl.dispose();
    _notesCtrl.dispose();
    _nameFocus.dispose();
    _phoneFocus.dispose();
    _emailFocus.dispose();
    _cityFocus.dispose();
    super.dispose();
  }

  void _onContinue() {
    if (_step < _totalSteps) {
      setState(() => _step++);
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CommonColors.scaffoldBgColor,
      appBar: CommonAppBar(
        title: 'Add Lead',
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(context.h(56)),
          child: _buildStepIndicator(context),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: context.w(16),
                vertical: context.h(20),
              ),
              child: _buildStepContent(context),
            ),
          ),
          _buildBottomButton(context),
        ],
      ),
    );
  }

  Widget _buildStepIndicator(BuildContext context) {
    return Container(
      color: CommonColors.whiteColor,
      padding: EdgeInsets.fromLTRB(
        context.w(24),
        context.h(10),
        context.w(24),
        context.h(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Step $_step of $_totalSteps',
            style: TextStyle(
              fontSize: context.s(12),
              fontWeight: FontWeight.w600,
              color: CommonColors.primaryColor,
            ),
          ),
          SizedBox(height: context.h(8)),
          Row(
            children: List.generate(_totalSteps, (i) {
              final filled = i < _step;
              return Expanded(
                child: Container(
                  margin: EdgeInsets.only(
                    right: i < _totalSteps - 1 ? context.w(6) : 0,
                  ),
                  height: context.h(4),
                  decoration: BoxDecoration(
                    color: filled
                        ? CommonColors.primaryColor
                        : CommonColors.grey75,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildStepContent(BuildContext context) {
    switch (_step) {
      case 1:
        return _buildStep1(context);
      case 2:
        return _buildStep2(context);
      default:
        return _buildStep3(context);
    }
  }

  Widget _buildStep1(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(context, 'Contact Details', 'Who are we adding?'),
        SizedBox(height: context.h(20)),
        _buildLabel(context, 'Full Name'),
        SizedBox(height: context.h(6)),
        CommonTextField(
          controller: _nameCtrl,
          focusNode: _nameFocus,
          hint: 'Write Your Full Name Here',
          textInputAction: TextInputAction.next,
          onSubmitted: () => _phoneFocus.requestFocus(),
        ),
        SizedBox(height: context.h(16)),
        _buildLabel(context, 'Phone Number'),
        SizedBox(height: context.h(6)),
        CommonTextField(
          controller: _phoneCtrl,
          focusNode: _phoneFocus,
          hint: 'Write Your Phone Number Here',
          isPhoneNumber: true,
          isApplyInputFormatter: true,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          textInputAction: TextInputAction.next,
          prefixIcon: _svgPrefix(context, CommonImg.crmPhoneOutlined),
          onSubmitted: () => _emailFocus.requestFocus(),
        ),
        SizedBox(height: context.h(16)),
        _buildLabel(context, 'Email'),
        SizedBox(height: context.h(6)),
        CommonTextField(
          controller: _emailCtrl,
          focusNode: _emailFocus,
          hint: 'Write Your Email Here',
          textInputAction: TextInputAction.next,
          prefixIcon: _svgPrefix(context, CommonImg.crmMailOutlined),
          onSubmitted: () => _cityFocus.requestFocus(),
        ),
        SizedBox(height: context.h(16)),
        _buildLabel(context, 'City'),
        SizedBox(height: context.h(6)),
        CommonTextField(
          controller: _cityCtrl,
          focusNode: _cityFocus,
          hint: 'Search Your City Name',
          textInputAction: TextInputAction.done,
        ),
      ],
    );
  }

  Widget _buildStep2(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(
          context,
          'Lead Details',
          'Where did this lead come from?',
        ),
        SizedBox(height: context.h(20)),
        _buildLabel(context, 'Source'),
        SizedBox(height: context.h(6)),
        _buildDropdown(
          context,
          value: _source,
          hint: 'Your Lead Source',
          items: const [
            'Facebook Ad',
            'Google Ad',
            'Referral',
            'Website',
            'Walk-in',
          ],
          onChanged: (v) => setState(() => _source = v),
        ),
        SizedBox(height: context.h(16)),
        _buildLabel(context, 'Campaign'),
        SizedBox(height: context.h(6)),
        _buildDropdown(
          context,
          value: _campaign,
          hint: 'Write Your Campaign Name Here',
          items: const ['Summer Sale', 'Q1 Outreach', 'Product Launch'],
          onChanged: (v) => setState(() => _campaign = v),
        ),
        SizedBox(height: context.h(16)),
        _buildLabel(context, 'Priority', required: false),
        SizedBox(height: context.h(10)),
        _buildPrioritySelector(context),
        SizedBox(height: context.h(16)),
        _buildLabel(context, 'Budget', required: false),
        SizedBox(height: context.h(10)),
        _buildBudgetFields(context),
      ],
    );
  }

  Widget _buildPrioritySelector(BuildContext context) {
    const priorities = ['Low', 'Medium', 'High', 'Urgent'];
    return Row(
      children: priorities.map((p) {
        final isSelected = _priority == p;
        return Padding(
          padding: EdgeInsets.only(right: context.w(8)),
          child: GestureDetector(
            onTap: () => setState(() => _priority = p),
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: context.w(16),
                vertical: context.h(8),
              ),
              decoration: BoxDecoration(
                color: isSelected
                    ? CommonColors.primaryColor.withValues(alpha: 0.08)
                    : CommonColors.whiteColor,
                border: Border.all(
                  color: isSelected
                      ? CommonColors.primaryColor
                      : CommonColors.borderDefault,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                p,
                style: TextStyle(
                  fontSize: context.s(13),
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  color: isSelected
                      ? CommonColors.primaryColor
                      : CommonColors.textSecondary,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildBudgetFields(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _buildBudgetField(
            context,
            label: 'Min',
            controller: _budgetMinCtrl,
            hint: '\$ 250',
          ),
        ),
        SizedBox(width: context.w(12)),
        Expanded(
          child: _buildBudgetField(
            context,
            label: 'Max',
            controller: _budgetMaxCtrl,
            hint: '\$ 1000',
          ),
        ),
      ],
    );
  }

  Widget _buildBudgetField(
    BuildContext context, {
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
      padding: EdgeInsets.symmetric(
        horizontal: context.w(14),
        vertical: context.h(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: context.s(11),
              color: CommonColors.textTertiary,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: context.h(2)),
          TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            style: TextStyle(
              fontSize: context.s(14),
              fontWeight: FontWeight.w500,
              color: CommonColors.primaryColor,
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                fontSize: context.s(14),
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

  Widget _buildStep3(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(context, 'Assignment', 'Who handles this lead?'),
        SizedBox(height: context.h(20)),
        _buildLabel(context, 'Team'),
        SizedBox(height: context.h(6)),
        _buildDropdown(
          context,
          value: _team,
          hint: 'Select Team',
          items: const ['Sales Team A', 'Sales Team B', 'Support'],
          onChanged: (v) => setState(() => _team = v),
        ),
        SizedBox(height: context.h(16)),
        _buildLabel(context, 'Assign To Agent'),
        SizedBox(height: context.h(6)),
        _buildDropdown(
          context,
          value: _agent,
          hint: 'Select Agent',
          items: const ['Nour', 'Alex', 'Sara', 'John'],
          onChanged: (v) => setState(() => _agent = v),
        ),
        SizedBox(height: context.h(16)),
        _buildLabel(context, 'Industry'),
        SizedBox(height: context.h(6)),
        _buildDropdown(
          context,
          value: _industry,
          hint: 'Select Industry',
          items: const [
            'Real Estate',
            'Finance',
            'Healthcare',
            'Technology',
            'Retail',
          ],
          onChanged: (v) => setState(() => _industry = v),
        ),
        SizedBox(height: context.h(16)),
        _buildLabel(context, 'Notes', required: false, suffix: '(optional)'),
        SizedBox(height: context.h(6)),
        CommonTextField(
          controller: _notesCtrl,
          hint: 'Write anything here',
          maxLines: 5,
        ),
      ],
    );
  }

  Widget _buildSectionHeader(
    BuildContext context,
    String title,
    String subtitle,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: context.s(22),
            fontWeight: FontWeight.w600,
            color: CommonColors.textPrimary,
          ),
        ),
        SizedBox(height: context.h(4)),
        Text(
          subtitle,
          style: TextStyle(
            fontSize: context.s(15),
            color: CommonColors.textTertiary,
          ),
        ),
      ],
    );
  }

  Widget _buildLabel(
    BuildContext context,
    String label, {
    bool required = true,
    String? suffix,
  }) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: context.s(14),
            height: 1.25,
            color: CommonColors.textPrimary,
          ),
        ),
        if (required)
          Text(
            ' *',
            style: TextStyle(fontSize: context.s(12), color: Colors.red),
          ),
        if (suffix != null) ...[
          SizedBox(width: context.w(4)),
          Text(
            suffix,
            style: TextStyle(
              fontSize: context.s(13),
              color: CommonColors.textTertiary,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildDropdown(
    BuildContext context, {
    required String? value,
    required String hint,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return CommonDropdown(
      hint: hint,
      value: value,
      items: items,
      onChanged: onChanged,
    );
  }

  Widget _svgPrefix(BuildContext context, String assetPath) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.w(12)),
      child: SvgPicture.asset(
        assetPath,
        width: context.w(18),
        height: context.w(18),
        colorFilter: ColorFilter.mode(
          CommonColors.textTertiary,
          BlendMode.srcIn,
        ),
      ),
    );
  }

  Widget _buildBottomButton(BuildContext context) {
    final isLastStep = _step == _totalSteps;
    return Container(
      color: CommonColors.whiteColor,
      padding: EdgeInsets.fromLTRB(
        context.w(16),
        context.h(12),
        context.w(16),
        context.h(16) + MediaQuery.of(context).padding.bottom,
      ),
      child: SizedBox(
        width: double.infinity,
        height: context.h(52),
        child: ElevatedButton(
          onPressed: _onContinue,
          style: ElevatedButton.styleFrom(
            backgroundColor: CommonColors.primaryColor,
            foregroundColor: CommonColors.whiteColor,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text(
            isLastStep ? 'Save Lead' : 'Continue',
            style: TextStyle(
              fontSize: context.s(16),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
