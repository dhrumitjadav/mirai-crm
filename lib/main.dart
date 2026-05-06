import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mirai_crm/repository/repository.dart';
import 'package:mirai_crm/splash_screen.dart';
import 'package:mirai_crm/theme/app_theme.dart';
import 'package:mirai_crm/utils/common_colors.dart';
import 'package:mirai_crm/utils/shared_preferences.dart';

SpUtil? sp;

const _systemUiStyle = SystemUiOverlayStyle(
  statusBarColor: CommonColors.scaffoldBgColor,
  statusBarIconBrightness: Brightness.dark,
  systemNavigationBarColor: CommonColors.scaffoldBgColor,
  systemNavigationBarIconBrightness: Brightness.dark,
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sp = await SpUtil.getInstance();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(_systemUiStyle);
  await Repository().initRepo();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: _systemUiStyle,
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: const SplashScreen(),
      ),
    );
  }
}
