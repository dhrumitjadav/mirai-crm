import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LeadDetailController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late final TabController tabController;

  // Reactive fields
  final status = 'Contacted'.obs;
  final campaign = 'Q4 Spring Sale'.obs;
  final agent = 'Agent 1'.obs;

  // Lead identity (set before navigation)
  final name = 'Michael Rodriguez'.obs;
  final phone = '+1 415 555-1451'.obs;
  final email = 'm.rodriguez23@gmail.com'.obs;
  final initials = 'MR'.obs;

  // Lead info fields
  final budget = r'$5,000–$10,000'.obs;
  final location = 'San Francisco, CA'.obs;
  final source = 'Facebook Ad'.obs;
  final priority = 'High'.obs;
  final created = 'Yesterday, 04:10 PM'.obs;

  // Custom info rows
  final customInfoRows = <(String, String)>[
    ('Info 1', 'Detail 1'),
    ('Info 2', 'Detail 2'),
    ('Info 3', 'Detail 3'),
  ].obs;

  static const int tabCount = 5;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: tabCount, vsync: this);
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  void onCall() {}

  void onWhatsapp() {}

  void onEmail() {}

  void onEditLead() {}

  void onReassign() {}
}
