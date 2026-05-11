import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mirai_crm/repository/repository.dart';
import 'package:mirai_crm/splash_screen.dart';
import 'package:mirai_crm/theme/app_theme.dart';
import 'package:mirai_crm/utils/shared_preferences.dart';

SpUtil? sp;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sp = await SpUtil.getInstance();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  await Repository().initRepo();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const SplashScreen(),
    );
  }
}
