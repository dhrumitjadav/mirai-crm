import 'package:get/get.dart';
import 'package:mirai_crm/utils/shared_preferences.dart';
import '../main.dart';

class CommonLogics {
  static void logOut() async {
    await sp!.clear();
    sp = await SpUtil.getInstance();
    Get.deleteAll(force: true);
    // Get.offAll(() => const _AuthPlaceholder());
  }

  static bool checkUserLogin() {
    return sp!.getBool(SpUtil.isLoggedIn) ?? false;
  }
}
