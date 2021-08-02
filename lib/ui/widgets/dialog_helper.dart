import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/shared.dart';

class DialogHelper {
  static void showErrorDialog({
    String title = 'An Error Occurred',
    String description = 'Something went wrong.',
  }) {
    Get.dialog(
      Dialog(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FittedBox(
            fit: BoxFit.fitHeight,
            child: Column(
              children: <Widget>[
                Text(
                  title ?? '',
                  style: const TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  description ?? '',
                  style: const TextStyle(
                    color: Colors.blue,
                    fontSize: 18,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (Get.isDialogOpen) Get.back();
                  },
                  child: const Text('Okay'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //show loading
  static void showLoading([String message]) {
    Get.dialog(
      Dialog(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SizedBox(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const <Widget>[
                CircularProgressIndicator(
                  strokeWidth: 3.0,
                ),
                SizedBox(
                  height: 24,
                ),
                Text(
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
      ),
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
