import 'package:flutter/material.dart';
import 'package:mirai_crm/utils/responsive.dart';
import 'package:mirai_crm/utils/common_colors.dart';
import 'package:mirai_crm/utils/common_text_field.dart';

class _Agent {
  final String name;
  final String initials;
  final int assignedLeads;
  final int totalLeads;
  final bool isActive;

  const _Agent({
    required this.name,
    required this.initials,
    required this.assignedLeads,
    required this.totalLeads,
    required this.isActive,
  });
}

const _agents = [
  _Agent(
    name: 'Sarah',
    initials: 'S',
    assignedLeads: 18,
    totalLeads: 28,
    isActive: true,
  ),
  _Agent(
    name: 'Alex',
    initials: 'A',
    assignedLeads: 31,
    totalLeads: 31,
    isActive: false,
  ),
  _Agent(
    name: 'Maya',
    initials: 'M',
    assignedLeads: 9,
    totalLeads: 18,
    isActive: true,
  ),
];

class ReassignLeadSheet extends StatefulWidget {
  const ReassignLeadSheet({super.key});

  @override
  State<ReassignLeadSheet> createState() => _ReassignLeadSheetState();
}

class _ReassignLeadSheetState extends State<ReassignLeadSheet> {
  int? _selectedIndex;
  final _reasonCtrl = TextEditingController();
  final _searchCtrl = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _searchCtrl.addListener(
      () => setState(() => _searchQuery = _searchCtrl.text),
    );
  }

  @override
  void dispose() {
    _reasonCtrl.dispose();
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    RS.init(context);
    final filtered = _agents
        .where((a) => a.name.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        decoration: const BoxDecoration(
          color: CommonColors.whiteColor,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
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
                        RS.HS(24),
                        RS.VS(9),
                        RS.HS(16),
                        RS.VS(18),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Reassign Lead',
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
                                shape: BoxShape.circle,
                                color: CommonColors.grey100,
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
              SizedBox(height: RS.VS(16)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: RS.HS(16)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Select New Agent',
                      style: TextStyle(
                        fontSize: RS.FS(14),
                        fontWeight: FontWeight.w600,
                        color: CommonColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: RS.VS(10)),
                    CommonTextField(
                      controller: _searchCtrl,
                      hint: 'Search Agent...',
                      prefixIcon: Icon(
                        Icons.search,
                        size: RS.HS(20),
                        color: CommonColors.textTertiary,
                      ),
                      textInputAction: TextInputAction.search,
                    ),
                    SizedBox(height: RS.VS(8)),
                    ...filtered.asMap().entries.map((entry) {
                      final i = _agents.indexOf(entry.value);
                      final agent = entry.value;
                      final selected = _selectedIndex == i;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedIndex = i),
                        child: Container(
                          margin: EdgeInsets.only(bottom: RS.VS(8)),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: CommonColors.borderDefault,
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: RS.VS(10),
                            horizontal: RS.HS(12),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: RS.HS(40),
                                height: RS.HS(40),
                                decoration: BoxDecoration(
                                  color:agent.isActive
                                      ? CommonColors.green50
                                      : CommonColors.warning100,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(
                                    agent.initials,
                                    style: TextStyle(
                                      fontSize: RS.FS(14),
                                      fontWeight: FontWeight.w600,
                                      color: agent.isActive
                                          ? CommonColors.green600
                                          : CommonColors.warning600,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: RS.HS(12)),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      agent.name,
                                      style: TextStyle(
                                        fontSize: RS.FS(13),
                                        fontWeight: FontWeight.w700,
                                        color: CommonColors.textPrimary,
                                      ),
                                    ),
                                    SizedBox(height: RS.VS(2)),
                                    Row(
                                      children: [
                                        Text(
                                          '${agent.assignedLeads}/${agent.totalLeads} Leads',
                                          style: TextStyle(
                                            fontSize: RS.FS(11),
                                            color: CommonColors.textSecondary,
                                          ),
                                        ),
                                        SizedBox(width: RS.HS(8)),
                                        Text(
                                          agent.isActive ? 'Active' : 'Busy',
                                          style: TextStyle(
                                            fontSize: RS.FS(11),
                                            fontWeight: FontWeight.w500,
                                            color: agent.isActive
                                                ? CommonColors.green600
                                                : CommonColors.warning600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: RS.HS(20),
                                height: RS.HS(20),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: selected
                                        ? CommonColors.primaryColor
                                        : CommonColors.borderDefault,
                                    width: selected ? 5 : 1.5,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                    SizedBox(height: RS.VS(8)),
                    Text(
                      'Reason (optional)',
                      style: TextStyle(
                        fontSize: RS.FS(14),
                        fontWeight: FontWeight.w600,
                        color: CommonColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: RS.VS(10)),
                    CommonTextField(
                      controller: _reasonCtrl,
                      hint: 'Write a Reason For Reassign Lead...',
                      maxLines: 4,
                      textInputAction: TextInputAction.done,
                    ),
                    SizedBox(height: RS.VS(20)),
                    SizedBox(
                      width: double.infinity,
                      height: RS.VS(52),
                      child: ElevatedButton(
                        onPressed: _selectedIndex == null
                            ? null
                            : () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: CommonColors.primaryColor,
                          disabledBackgroundColor: CommonColors.primaryColor
                              .withValues(alpha: 0.4),
                          foregroundColor: CommonColors.whiteColor,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(
                          'Reassign',
                          style: TextStyle(
                            fontSize: RS.FS(16),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: RS.VS(24) + MediaQuery.of(context).padding.bottom,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
