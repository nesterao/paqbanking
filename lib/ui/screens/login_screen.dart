import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/exported_shared.dart';
import '../screens/exported_screens.dart';
import '../widgets/exported_widgets.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  static int _swiperIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    // _accountController.getAccountInDB();
    super.initState();
  }

  // Widget _buildSwiperList(AccountInDB accountInDB, int index) {
  //   return Card(
  //     color: Get.isDarkMode ? kDarkPrimaryColor : kContentColorDarkTheme,
  //     elevation: 4,
  //     shape: RoundedRectangleBorder(
  //       side: const BorderSide(
  //         color: kAccentColor,
  //       ),
  //       borderRadius: BorderRadius.circular(6),
  //     ),
  //     child: Center(
  //       child: ListTile(
  //         horizontalTitleGap: 14,
  //         leading: Icon(
  //           Icons.phone_android_outlined,
  //           size: displayWidth(context) * 0.12,
  //           color: Get.isDarkMode ? kDarkSecondaryColor : kLightTertiaryColor,
  //         ),
  //         title: Text(
  //           FormatUtils.formatPhoneNumber(accountInDB.phoneNumber),
  //           style: Theme.of(context).textTheme.headline6.copyWith(
  //                 letterSpacing: 4,
  //                 fontSize: displayWidth(context) * 0.06,
  //               ),
  //         ),
  //         subtitle: Text(
  //           '(${FormatUtils.formatAccountNumber(accountInDB.accountNumber)})',
  //           style: Theme.of(context).textTheme.headline1.copyWith(
  //                 letterSpacing: 2,
  //                 fontSize: displayWidth(context) * 0.05,
  //               ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return BaseBody(
      content: SafeArea(
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.only(
              top: displayWidth(context) * 0.16,
            ),
            child: Column(
              children: <Widget>[
                WelcomeLogo(),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: displayWidth(context) * 0.04,
                  ),
                  child: Text(
                    'Swipe to select an account',
                    style: Theme.of(context).textTheme.headline1.copyWith(
                          fontSize: displayWidth(context) * 0.04,
                        ),
                  ),
                ),
                // SizedBox(
                //   height: displayWidth(context) * 0.4,
                //   width: displayWidth(context),
                //   child: Swiper(
                //     index: _swiperIndex,
                //     loop: false,
                //     itemCount: _authController.accountInDBList.length,
                //     viewportFraction: 0.86,
                //     scale: 0.93,
                //     itemBuilder: (BuildContext context, int index) {
                //       _accountInDB = _authController.accountInDBList[index];
                //       return _buildSwiperList(_accountInDB, index);
                //     },
                //     onIndexChanged: (int index) {
                //       _swiperIndex = index;
                //     },
                //     pagination: const SwiperPagination(
                //       builder: DotSwiperPaginationBuilder(
                //         size: 8,
                //         color: Colors.grey,
                //         activeColor: kAccentColor,
                //         activeSize: 12,
                //       ),
                //     ),
                //   ),
                // ),
                sizedBoxHeight(context, 0.08),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: displayWidth(context) * 0.08,
                  ),
                  child: PrimaryButton(
                    text: 'Login',
                    onTap: () {
                      Get.toNamed(
                        PinInput.routeName,
                      );
                    },
                  ),
                ),
                sizedBoxHeight(context, 0.06),
                TextButton(
                  onPressed: () {
                    // Get.toNamed(WelcomeScreen.routeName);
                  },
                  child: Text(
                    'Setup New User Account'.toUpperCase(),
                    style: Theme.of(context).textTheme.headline1.copyWith(
                          decoration: TextDecoration.underline,
                          fontSize: displayWidth(context) * 0.04,
                        ),
                  ),
                ),
                // sizedBoxHeight(context, 0.02),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
