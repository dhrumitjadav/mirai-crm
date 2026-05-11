import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirai_crm/screens/main_screen.dart';
import 'package:mirai_crm/utils/common_colors.dart';
import 'package:mirai_crm/utils/common_img.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) Get.off(() => const MainScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CommonColors.scaffoldBgColor,
      body: Center(
        child: Image.asset(
          CommonImg.appLogo,
          width: 120,
          errorBuilder: (_, __, ___) => const Icon(
            Icons.business,
            size: 80,
            color: CommonColors.primaryColor,
          ),
        ),
      ),
    );
  }
}
