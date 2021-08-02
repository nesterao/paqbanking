import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pa_quick_banking/ui/widgets/base_body.dart';

import './constants/constants.dart';
import './data/controller/controller.dart';
import './data/helpers/helpers.dart';
import './data/model/model.dart';
import './shared/shared.dart';
import './ui/screens/screens.dart';

// void main() => runApp(MyApp());
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays(
      <SystemUiOverlay>[SystemUiOverlay.bottom, SystemUiOverlay.top]);
  await DatabaseHelper().initializeDatabase();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final DatabaseHelper databaseHelper = DatabaseHelper();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 3), () async {
      checkLinkedAccounts();
    });
  }

  Future<void> checkLinkedAccounts() async {
    final bool linkedAccounts = await databaseHelper.tableIsNotEmpty();
    linkedAccounts
        ? Get.offAllNamed(LoginScreen.routeName)
        : Get.offAllNamed(WelcomeScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    // FocusScope.of(context).requestFocus(FocusNode());
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    SystemChrome.setPreferredOrientations(
      <DeviceOrientation>[DeviceOrientation.portraitUp],
    );
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Get.isDarkMode ? Themes().darkTheme : Themes().lightTheme,
      darkTheme: Themes().darkTheme,
      initialRoute: '/',
      initialBinding: BindingsBuilder<dynamic>(
        () {
          Get.put(AccountInDB());
          Get.put(DatabaseHelper());
          Get.put(LoginController());
          Get.put(AccountController());
        },
      ),
      getPages: routes,
      home: BaseBody(
        content: SafeArea(
          child: Center(
            child: CircularProgressIndicator(
              color: Get.isDarkMode ? kAccentColor : kLightPrimaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
