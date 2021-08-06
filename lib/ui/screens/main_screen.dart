import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../shared/exported_shared.dart';
import '../widgets/exported_widgets.dart';
import 'exported_screens.dart';

class MainScreen extends StatefulWidget {
  static const String routeName = '/main_screen';

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _index = 0;
  String _title = '';
  PageController _pageController;
  final _linkedAccount = Get.arguments;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    debugPrintSynchronously(_linkedAccount.toString());
    setTitle();
  }

  @override
  void dispose() {
    _pageController.dispose();
    setTitle();
    super.dispose();
  }

  void onTap(int index) => setState(() {
        _index = index;
        setTitle();

        _pageController.animateToPage(
          index,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeIn,
        );
      });

  void setTitle() {
    switch (_index) {
      case 0:
        _title = HomeScreen.title;
        break;

      case 1:
        _title = ServicesScreen.title;
        break;

      case 2:
        _title = AccountScreen.title;
        break;

      case 3:
        _title = HistoryScreen.title;
        break;
      default:
        debugPrint('No title found');
    }
  }

  Future<bool> onWillPop(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) => WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          title: Text(
            'Exit Quick Banking',
            style: TextStyle(
              color: Get.isDarkMode ? kAccentColor : kLightPrimaryColor,
              fontSize: displayWidth(context) * 0.04,
            ),
          ),
          content: Text(
            'Are you sure you want to exit Quick Banking?',
            style: TextStyle(
              fontSize: displayWidth(context) * 0.04,
              color: Get.isDarkMode ? kDarkTertiaryColor : kDarkPrimaryColor,
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                //    goto(nextPage);
                SystemChannels.platform.invokeMethod('SystemNavigator.pop');
              },
              child: Text(
                'Yes',
                style: TextStyle(
                  fontSize: displayWidth(context) * 0.044,
                  color: kErrorColor,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                //    goto(nextPage);
                Navigator.pop(context);
              },
              child: Text(
                'No',
                style: TextStyle(
                  fontSize: displayWidth(context) * 0.044,
                  color:
                      Get.isDarkMode ? kDarkTertiaryColor : kLightTertiaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => onWillPop(context),
      child: BaseBody(
        appBar: baseAppBar(
          context: context,
          title: _title,
          showActions: true,
        ),
        content: PageView(
          pageSnapping: false,
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          onPageChanged: (int index) {
            setState(() => _index = index);
          },
          children: <Widget>[
            HomeScreen(),
            ServicesScreen(),
            AccountScreen(),
            HistoryScreen(),
          ],
        ),
        bottomNavBar: BaseBottomNavBar(
          _index,
          onTap,
        ),
      ),
    );
  }
}
