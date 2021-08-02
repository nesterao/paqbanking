import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:get/get.dart';

import '../../shared/shared.dart';

class AccountDetailsCard extends StatelessWidget {
  const AccountDetailsCard({
    Key key,
    this.showBalance,
  }) : super(key: key);

  final bool showBalance;

  Widget balanceLabel(BuildContext context, String label, double amount) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label,
            style: Theme.of(context).textTheme.headline6.copyWith(
                  fontSize: displayWidth(context) * 0.03,
                ),
          ),
          sizedBoxHeight(context, 0.0016),
          Text(
            amount.toStringAsFixed(2),
            style: Theme.of(context).textTheme.headline1.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: displayWidth(context) * 0.07,
                ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: showBalance
          ? displayWidth(context) * 0.46
          : displayWidth(context) * 0.34,
      child: Swiper(
        // itemCount: account.length,
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            color: Get.isDarkMode ? kDarkPrimaryColor : kContentColorDarkTheme,
            elevation: 4,
            shape: RoundedRectangleBorder(
              side: const BorderSide(
                color: kAccentColor,
              ),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.phone_android_outlined,
                      size: displayWidth(context) * 0.12,
                      color: Get.isDarkMode
                          ? kDarkSecondaryColor
                          : kLightTertiaryColor,
                    ),
                    sizedBoxWidth(context, 0.016),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          // phones[index].phoneNumber,
                          '',
                          style: Theme.of(context).textTheme.headline6.copyWith(
                                fontSize: displayWidth(context) * 0.05,
                              ),
                        ),
                        Text(
                          // phones[index].accountNumber.toString(),
                          '',
                          style: Theme.of(context).textTheme.headline1.copyWith(
                                fontSize: displayWidth(context) * 0.04,
                              ),
                        ),
                      ],
                    )
                  ],
                ),
                sizedBoxHeight(context, 0.024),
                if (showBalance)
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: displayWidth(context) * 0.06,
                    ),
                    child: Row(
                      children: <Widget>[
                        balanceLabel(
                          context,
                          'Available Balance',
                          // phones[index].availableBalance,
                          1,
                        ),
                        balanceLabel(
                          context,
                          'Actual Balance',
                          // phones[index].actualBalance,
                          2,
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          );
        },
        pagination: const SwiperPagination(
          builder: DotSwiperPaginationBuilder(
            size: 6,
            color: Colors.grey,
            activeColor: kAccentColor,
          ),
        ),
      ),
    );
  }
}
