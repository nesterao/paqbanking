import 'package:flutter/material.dart';

import '../../shared/exported_shared.dart';
import '../widgets/exported_widgets.dart';

class ServicesScreen extends StatefulWidget {
  static const String title = 'Services';

  @override
  _ServicesScreenState createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
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
      child: Padding(
        padding: EdgeInsets.all(
          displayWidth(context) * 0.05,
        ),
        child: GridView.builder(
          itemCount: services.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
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
    );
  }
}
