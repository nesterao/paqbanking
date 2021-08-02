import 'package:get/get_navigation/get_navigation.dart';

import '../ui/screens/screens.dart';

List<GetPage<dynamic>> routes = <GetPage<dynamic>>[
  // ignore: always_specify_types
  GetPage(
    name: '/',
    page: () => WelcomeScreen(),
  ),
  // ignore: always_specify_types
  GetPage(
    name: LinkAccountScreen.routeName,
    page: () => const LinkAccountScreen(),
    // transition: Transition.leftToRightWithFade,
    // transitionDuration: const Duration(milliseconds: 400),
  ),
  // ignore: always_specify_types
  GetPage(
    name: SecurityScreen.routeName,
    page: () => SecurityScreen(),
    // transition: Transition.leftToRightWithFade,
    // transitionDuration: const Duration(milliseconds: 400),
  ),
  // ignore: always_specify_types
  GetPage(
    name: LoginScreen.routeName,
    page: () => LoginScreen(),
    transition: Transition.topLevel,
    // transitionDuration: const Duration(seconds: 1),
  ),
  // ignore: always_specify_types
  GetPage(
    name: PinInput.routeName,
    page: () => PinInput(),
    transition: Transition.topLevel,
    // transitionDuration: const Duration(seconds: 1),
  ),
  // ignore: always_specify_types
  GetPage(
    name: OTPVerification.routeName,
    page: () => OTPVerification(),
    transition: Transition.topLevel,
    // transitionDuration: const Duration(seconds: 1),
  ),
  // ignore: always_specify_types
  GetPage(
    name: CreateAccountScreen.routeName,
    page: () => const CreateAccountScreen(),
    transition: Transition.topLevel,
    // transitionDuration: const Duration(seconds: 1),
  ),
  // ignore: always_specify_types
  GetPage(
    name: MainScreen.routeName,
    page: () => MainScreen(),
    transition: Transition.topLevel,
    // transitionDuration: const Duration(seconds: 1),
  ),
  // ignore: always_specify_types
  GetPage(
    name: SettingsScreen.routeName,
    page: () => SettingsScreen(),
    // transition: Transition.leftToRightWithFade,
    // transitionDuration: const Duration(milliseconds: 400),
  ),
  // ignore: always_specify_types
  GetPage(
    name: WelcomeScreen.routeName,
    page: () => WelcomeScreen(),
  ),
];
