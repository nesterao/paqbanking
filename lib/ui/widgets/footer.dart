import 'package:flutter/material.dart';

import '../../shared/exported_shared.dart';

class Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Text(
          'Terms and Conditions. Copyright 2021',
          style: Theme.of(context).textTheme.headline1.copyWith(
                fontSize: displayWidth(context) * 0.024,
              ),
        ),
      ),
    );
  }
}
