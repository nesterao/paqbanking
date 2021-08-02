import 'package:flutter/material.dart';

import '../../shared/shared.dart';

class ServiceButton extends StatelessWidget {
  const ServiceButton({Key key, this.onTap, this.text}) : super(key: key);

  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: displayWidth(context) * 0.26,
      height: displayHeight(context) * 0.18,
      child: ElevatedButton(
        onPressed: onTap,
        child: Text(
          text.toUpperCase().replaceAll(RegExp(' '), '\n'),
          style: Theme.of(context).textTheme.caption.copyWith(
                fontSize: displayWidth(context) * 0.036,
              ),
        ),
      ),
    );
  }
}
