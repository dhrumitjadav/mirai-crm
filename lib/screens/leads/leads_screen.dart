import 'package:flutter/material.dart';
import 'package:mirai_crm/utils/common_colors.dart';

class LeadsScreen extends StatelessWidget {
  const LeadsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: CommonColors.scaffoldBgColor,
      body: Center(
        child: Text('Leads'),
      ),
    );
  }
}
