import 'package:flutter/material.dart';

import '../../shared/exported_shared.dart';
import '../widgets/exported_widgets.dart';

class AccountScreen extends StatefulWidget {
  static const String title = 'Account';

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  List<String> services = <String>[
    'Transactions',
    'Request Update',
    'More',
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(displayWidth(context) * 0.04),
          child: SizedBox(
            height: displayHeight(context) * 0.94,
            child: Column(
              children: <Widget>[
                const AccountDetailsCard(
                  showBalance: true,
                ),
                sizedBoxHeight(context, 0.02),
                SizedBox(
                  height: displayHeight(context) * 0.6,
                  child: GridView.builder(
                    itemCount: services.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisExtent: displayWidth(context) * 0.4,
                      crossAxisSpacing: displayWidth(context) * 0.06,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
