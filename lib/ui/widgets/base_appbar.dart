import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';

import '../../shared/exported_shared.dart';
import '../screens/exported_screens.dart';
import '../widgets/exported_widgets.dart';

PreferredSizeWidget baseAppBar({
  BuildContext context,
  String title,
  bool showActions,
  bool showBackButton = false,
  bool isSettingsScreen = false,
}) {
  return AppBar(
    leadingWidth: displayWidth(context) * 0.20,
    leading: showBackButton
        ? IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Get.isDarkMode ? kDarkTertiaryColor : kLightSecondaryColor,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Image.asset(
              'assets/images/logo_white.png',
              fit: BoxFit.contain,
            ),
          ),
    title: Text(
      title.toUpperCase() ?? '',
      style: Theme.of(context).textTheme.caption.copyWith(
            color: Colors.white,
            fontSize: displayWidth(context) * 0.044,
          ),
    ),
    actions: showActions
        ? <Widget>[
            IconButton(
              icon: const Icon(
                Icons.notifications_none_outlined,
              ),
              onPressed: () {
                openNotifications(context: context);
              },
            ),
            if (!isSettingsScreen)
              IconButton(
                icon: const Icon(
                  Icons.settings,
                ),
                onPressed: () {
                  Get.toNamed(SettingsScreen.routeName);
                },
              )
            else
              const SizedBox(),
          ]
        : <Widget>[const SizedBox()],
    centerTitle: true,
    automaticallyImplyLeading: false,
  );
}
