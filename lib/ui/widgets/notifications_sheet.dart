import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/shared.dart';
import 'widgets.dart';

void openNotifications({BuildContext context}) {
  showModalBottomSheet(
    context: context,
    isDismissible: false,
    builder: (BuildContext context) {
      return const NotificationsSheetLayout();
    },
  );
}

class NotificationsSheetLayout extends StatelessWidget {
  const NotificationsSheetLayout({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Get.isDarkMode ? kDarkPrimaryColor : kContentColorDarkTheme,
      height: displayHeight(context),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: displayWidth(context) * 0.04),
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: displayWidth(context) * 0.04,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(
                        'Notifications',
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.headline1.copyWith(
                              fontSize: displayWidth(context) * 0.044,
                            ),
                      ),
                      sizedBoxWidth(context, 0.02),
                      Container(
                        padding: EdgeInsets.all(displayWidth(context) * 0.008),
                        decoration: BoxDecoration(
                          color: Get.isDarkMode
                              ? kAccentColor
                              : kLightPrimaryColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          // transactions.length.toString(),
                          '',
                          style: TextStyle(
                            color: Get.isDarkMode
                                ? kDarkPrimaryColor
                                : kAccentColor,
                            fontSize: displayWidth(context) * 0.04,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: Icon(
                      Icons.close_rounded,
                      color: Get.isDarkMode
                          ? kDarkTertiaryColor
                          : kLightPrimaryColor,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: displayHeight(context) * 0.42,
              child: const BaseListView(),
            ),
            // SecondaryButton(
            //   text: 'Close Notifications',
            //   onTap: () => Navigator.pop(context),
            // )
          ],
        ),
      ),
    );
  }
}
