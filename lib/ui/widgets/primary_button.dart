import 'package:flutter/material.dart';

import '../../shared/exported_shared.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({Key key, this.text, this.onTap}) : super(key: key);

  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: displayWidth(context) * 0.16,
      // height: 60,
      child: ElevatedButton(
        onPressed: onTap,
        child: Text(
          text.toUpperCase(),
          style: Theme.of(context).textTheme.button.copyWith(
                color: kAccentColor,
                fontSize: displayWidth(context) * 0.04,
              ),
        ),
      ),
    );
  }
}
