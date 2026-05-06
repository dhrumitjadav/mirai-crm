import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirai_crm/utils/common_img.dart';
import 'package:mirai_crm/utils/common_logics.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _bootstrap();
  }

  Future<void> _bootstrap() async {
    // final isLoggedIn = CommonLogics.checkUserLogin();
    await Future<void>.delayed(const Duration(seconds: 2));
    // Get.off(() => isLoggedIn ? const _HomeplaceholderScreen() : const _AuthPlaceholderScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Image.asset(CommonImg.appLogo)));
  }
}

class _AuthPlaceholderScreen extends StatelessWidget {
  const _AuthPlaceholderScreen();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('Auth Screen')));
  }
}

class _HomeplaceholderScreen extends StatelessWidget {
  const _HomeplaceholderScreen();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: Text('Home Screen')));
  }
}
