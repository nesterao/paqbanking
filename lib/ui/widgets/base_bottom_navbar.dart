import 'dart:ui';

import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/shared.dart';
import '../screens/screens.dart';

class BaseBottomNavBar extends StatelessWidget {
  const BaseBottomNavBar(this._index, this.onTap);

  final int _index;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      elevation: 4,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      clipBehavior: Clip.hardEdge,
      child: FloatingNavbar(
        iconSize: displayWidth(context) * 0.08,
        fontSize: displayWidth(context) * 0.032,
        margin: const EdgeInsets.all(0),
        backgroundColor:
            Get.isDarkMode ? kLightPrimaryColor : kContentColorDarkTheme,
        unselectedItemColor:
            Get.isDarkMode ? kDarkTertiaryColor : kLightTertiaryColor,
        selectedItemColor: kAccentColor,
        selectedBackgroundColor:
            Get.isDarkMode ? kDarkPrimaryColor : kLightPrimaryColor,
        onTap: (int _index) {
          onTap(_index);
        },
        currentIndex: _index,
        items: <FloatingNavbarItem>[
          FloatingNavbarItem(
            icon: Icons.home_filled,
            title: HomeScreen.title,
          ),
          FloatingNavbarItem(
            icon: Icons.grid_view,
            title: ServicesScreen.title,
          ),
          FloatingNavbarItem(
            icon: Icons.verified_user_rounded,
            title: AccountScreen.title,
          ),
          FloatingNavbarItem(
            icon: Icons.bar_chart_rounded,
            title: HistoryScreen.title,
          ),
        ],
      ),
    );
  }
}
