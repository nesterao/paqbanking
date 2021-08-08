import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import './data/controller/exported_controllers.dart';
import './data/helpers/db_helper.dart';
import './shared/exported_shared.dart';
import './ui/screens/exported_screens.dart';
import './ui/widgets/exported_widgets.dart';

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
  // final AccountController _accountController = Get.find();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 3), () async {
      checkLinkedAccounts();
    });
  }

  Future<void> checkLinkedAccounts() async {
    final bool _linkedUserAccounts = await databaseHelper.tableIsNotEmpty();
    if (_linkedUserAccounts) {
      AccountController().getAccountInDB();
      Get.offAllNamed(LoginScreen.routeName);
    } else {
      Get.offAllNamed(WelcomeScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
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
          Get.put(AccountController());
        },
      ),
      getPages: routes,
      home: BaseBody(
        content: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                WelcomeLogo(),
                const SizedBox(height: 64),
                CircularProgressIndicator(
                  color: Get.isDarkMode ? kAccentColor : kLightPrimaryColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
