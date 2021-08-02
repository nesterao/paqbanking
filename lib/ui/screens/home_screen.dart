import 'package:flutter/material.dart';

import '../../shared/shared.dart';
import '../widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  static const String title = 'Home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool showBalance = true;
  List<String> services = <String>[
    'Quick Save',
    'Quick Cash',
    'Quick TopUp',
    'Quick Loans',
    'Quick Pay',
    'Quick Insure',
    'Quick Banking',
    'Quick Assist',
    'Favorites',
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
                sizedBoxHeight(context, 0.03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Expanded(
                      child: ServiceButton(
                        text: 'Favorites',
                        onTap: () {},
                      ),
                    ),
                    sizedBoxWidth(context, 0.04),
                    Expanded(
                      child: ServiceButton(
                        text: 'Quick Save',
                        onTap: () {},
                      ),
                    ),
                    sizedBoxWidth(context, 0.04),
                    Expanded(
                      child: ServiceButton(
                        text: 'Quick Cash',
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
                // SizedBox(
                //   height: displayHeight(context) * 0.3,
                //   child: GridView.builder(
                //     itemCount: services.length,
                //     reverse: true,
                //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                //       crossAxisCount: 3,
                //       mainAxisExtent: displayWidth(context) * 0.4,
                //       crossAxisSpacing: displayWidth(context) * 0.04,
                //       mainAxisSpacing: displayHeight(context) * 0.04,
                //     ),
                //     itemBuilder: (BuildContext context, int index) {
                //       return ServiceButton(
                //         text: services[index],
                //         onTap: () {},
                //       );
                //     },
                //   ),
                // ),
                sizedBoxHeight(context, 0.03),
                const Flexible(
                  child: BaseListView(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
