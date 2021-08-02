import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/shared.dart';

class BaseListView extends StatelessWidget {
  const BaseListView({
    Key key,
  }) : super(key: key);

  Widget buildBody(BuildContext context, int index) {
    return ListTile(
      // isThreeLine: true,
      leading: const Icon(
        Icons.check,
        color: Colors.green,
      ),
      title: Text(
        // transactions[index].transactionDescription,
        '',
        style: TextStyle(
          color: Get.isDarkMode ? kLightSecondaryColor : kLightPrimaryColor,
        ),
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        // 'Trans ID: ${transactions[index].transactionId.toString()} '
        // 'at ${transactions[index].transactionCharge} '
        // 'on ${transactions[index].timeStamp}',
        '',
        style: TextStyle(
          // fontSize: 6,
          color: Get.isDarkMode ? kDarkTertiaryColor : Colors.black,
        ),
        overflow: TextOverflow.clip,
      ),
      trailing: Text(
        // transactions[index].transactionAmount.toString(),
        '',
        style: TextStyle(
          fontSize: 19,
          color: Get.isDarkMode ? kDarkTertiaryColor : kLightPrimaryColor,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: displayWidth(context) * 0.04,
      ),
      decoration: BoxDecoration(
        color: Get.isDarkMode ? kDarkPrimaryColor : kLightSecondaryColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      child: ListView.separated(
        separatorBuilder: (BuildContext context, int index) => Divider(
          color: Get.isDarkMode ? kAccentColor : kLightPrimaryColor,
          indent: 32,
          endIndent: 32,
        ),
        itemCount: 9,
        // itemCount: transactions.length,
        itemBuilder: (BuildContext context, int index) =>
            buildBody(context, index),
      ),
    );
  }
}
