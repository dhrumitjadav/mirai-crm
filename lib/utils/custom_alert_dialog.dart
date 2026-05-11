import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mirai_crm/utils/common_colors.dart';

showToastMessage({String? msg}) {
  Get.closeAllSnackbars();
  Get.rawSnackbar(message: msg, backgroundColor: CommonColors.appColor);
}

showErrorToastMessage({String? msg}) {
  Get.closeAllSnackbars();
  Get.rawSnackbar(message: msg, backgroundColor: CommonColors.redB52424);
}

showAlertDialog({String? msg}) {
  final message = msg != null && msg.contains("Exception")
      ? msg.replaceAll("Exception: ", "")
      : msg ?? 'Something went wrong';

  Get.dialog(
    Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 32),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: CommonColors.whiteColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: CommonColors.appRedColor.withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.error_outline_rounded,
                size: 30,
                color: CommonColors.appRedColor,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Error',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: CommonColors.blackColor,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 13,
                color: CommonColors.hintColor,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Get.back(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: CommonColors.primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 13),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'OK',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: CommonColors.whiteColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

noInternetDialog({required Function() onRetry}) {
  Get.dialog(
    Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 32),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: CommonColors.whiteColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: CommonColors.appColor.withValues(alpha: 0.08),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.wifi_off_rounded,
                size: 30,
                color: CommonColors.appColor,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'No Internet',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: CommonColors.blackColor,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Please check your internet connection and try again.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: CommonColors.hintColor,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Get.back(),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 13),
                      side: const BorderSide(color: CommonColors.borderColor),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Dismiss',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: CommonColors.txtPrimary,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Get.back();
                      onRetry();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: CommonColors.primaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 13),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Retry',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: CommonColors.whiteColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
    barrierDismissible: false,
  );
}
