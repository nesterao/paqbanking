import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pa_quick_banking/ui/widgets/primary_button.dart';

import '../../shared/exported_shared.dart';

class DialogHelper {
  static void showErrorDialog({String title, String description}) {
    Get.dialog(
      Dialog(
        backgroundColor:
            Get.isDarkMode ? kContentColorLightTheme : kContentColorDarkTheme,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                title ?? 'An Error Occurred',
                textAlign: TextAlign.left,
                style: const TextStyle(
                  color: kErrorColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                description ?? 'Something went wrong. Please try again later.',
                style: TextStyle(
                  color:
                      Get.isDarkMode ? kDarkTertiaryColor : kLightPrimaryColor,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 24),
              PrimaryButton(
                onTap: () {
                  if (Get.isDialogOpen) Get.back();
                },
                text: 'Okay',
              ),
            ],
          ),
        ),
      ),
    );
  }

  //show loading
  static void showLoading([String message]) {
    Get.dialog(
      Dialog(
        backgroundColor:
            Get.isDarkMode ? kDarkPrimaryColor : kContentColorDarkTheme,
        // insetPadding: ,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CircularProgressIndicator(
                strokeWidth: 3.0,
                color: Get.isDarkMode ? kAccentColor : kLightPrimaryColor,
              ),
              const SizedBox(
                height: 24,
              ),
              const Text(
                'Loading...',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 24,
                ),
              )
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  //hide loading
  static void hideLoading() {
    if (Get.isDialogOpen) Get.back();
  }

  static void showErrorSnackBar(String e) {
    Get.rawSnackbar(
      snackStyle: SnackStyle.FLOATING,
      backgroundColor: kErrorColor,
      borderRadius: 4,
      messageText: Text(
        e ?? '',
        maxLines: 30,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
      isDismissible: true,
      forwardAnimationCurve: Curves.easeInOut,
      barBlur: 16,
      snackPosition: SnackPosition.TOP,
      margin: const EdgeInsets.all(16),
      duration: const Duration(seconds: 5),
    );
  }

  static void showSuccessSnackBar(String e) {
    Get.rawSnackbar(
      snackStyle: SnackStyle.FLOATING,
      backgroundColor: kAccentColor,
      borderRadius: 4,
      messageText: Text(
        e ?? '',
        maxLines: 30,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),
      ),
      isDismissible: true,
      forwardAnimationCurve: Curves.easeInOut,
      barBlur: 16,
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
      duration: const Duration(seconds: 5),
    );
  }
}
