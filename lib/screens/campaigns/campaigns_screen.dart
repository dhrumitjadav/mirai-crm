import 'package:flutter/material.dart';
import 'package:mirai_crm/utils/common_colors.dart';

class CampaignsScreen extends StatelessWidget {
  const CampaignsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: CommonColors.scaffoldBgColor,
      body: Center(
        child: Text('Campaigns'),
      ),
    );
  }
}
