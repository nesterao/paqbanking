import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/shared.dart';
import '../screens/screens.dart';
import '../widgets/widgets.dart';

class WelcomeScreen extends StatefulWidget {
  static const String routeName = '/welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseBody(
      content: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: displayWidth(context) * 0.04,
          ),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: displayHeight(context) * 0.55,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    WelcomeLogo(),
                  ],
                ),
              ),
              SizedBox(
                height: displayHeight(context) * 0.45,
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: displayHeight(context) * 0.02,
                  ),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          ServiceButton(
                              text: 'Link Account',
                              onTap: () {
                                Get.toNamed(LinkAccountScreen.routeName);
                              }),
                          ServiceButton(
                            text: 'Quick Pay',
                            onTap: () {
                              DialogHelper.showErrorDialog();
                            },
                          ),
                          ServiceButton(
                            text: 'Quick Assist',
                            onTap: () async {
                              // debugPrint('End');
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: displayHeight(context) * 0.02,
                      ),
                      PrimaryButton(
                        text: 'Open Quick Account',
                        onTap: () => Get.toNamed(CreateAccountScreen.routeName),
                        // onTap: () async {
                        //   await data();
                        // },
                      ),
                      Footer(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
