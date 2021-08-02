import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../shared/shared.dart';

class BaseBody extends StatelessWidget {
  const BaseBody({
    Key key,
    this.appBar,
    this.content,
    this.bottomNavBar,
  }) : super(key: key);

  final PreferredSizeWidget appBar;
  final Widget content;
  final Widget bottomNavBar;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          constraints: const BoxConstraints.expand(),
          child: const Image(
            fit: BoxFit.cover,
            image: AssetImage('assets/images/quick_background.png'),
          ),
        ),
        Scaffold(
          resizeToAvoidBottomInset: true,
          extendBody: true,
          extendBodyBehindAppBar: true,
          appBar: appBar,
          backgroundColor: Get.isDarkMode
              ? kContentColorLightTheme.withOpacity(0.88)
              : kContentColorDarkTheme.withOpacity(0.8),
          body: content ??
              const Center(
                child: Text('Base body Screen'),
              ),
          bottomNavigationBar: bottomNavBar,
        ),
      ],
    );
  }
}
