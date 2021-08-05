import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/exported_shared.dart';

class WelcomeLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: <Widget>[
          Text(
            'WELCOME TO',
            style: Theme.of(context).textTheme.headline1.copyWith(
                  color: Get.isDarkMode ? Colors.white : kLightPrimaryColor,
                  fontSize: displayWidth(context) * 0.06,
                ),
          ),
          Image.asset(
            Get.isDarkMode
                ? 'assets/images/logo_white.png'
                : 'assets/images/logo_blue.png',
            width: displayWidth(context) * 0.4,
            fit: BoxFit.contain,
          )
        ],
      ),
    );
  }
}
