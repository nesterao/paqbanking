import 'package:flutter/material.dart';

import '../../shared/shared.dart';
import '../widgets/widgets.dart';

class SettingsScreen extends StatefulWidget {
  static const String title = '/settings_screen';
  static const String routeName = '/settings_screen';

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  int index = 0;

  List<String> services = <String>[
    'Notifications',
    'General',
    'Account',
    'Privacy',
    'Logout',
    'Help',
  ];
  @override
  Widget build(BuildContext context) {
    return BaseBody(
      appBar: baseAppBar(
        context: context,
        title: 'Settings',
        showActions: true,
        showBackButton: true,
        isSettingsScreen: true,
      ),
      content: Padding(
        padding: EdgeInsets.all(
          displayWidth(context) * 0.04,
        ),
        child: SafeArea(
          bottom: false,
          child: GridView.builder(
            itemCount: services.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: displayWidth(context) * 0.4,
              crossAxisSpacing: displayWidth(context) * 0.04,
              mainAxisSpacing: displayHeight(context) * 0.04,
            ),
            itemBuilder: (BuildContext context, int index) {
              return ServiceButton(
                text: services[index],
                onTap: () {},
              );
            },
          ),
        ),
      ),
    );
  }
}
