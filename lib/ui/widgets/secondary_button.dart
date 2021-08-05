import 'package:flutter/material.dart';

import '../../shared/exported_shared.dart';

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    Key key,
    @required this.text,
    @required this.onTap,
  }) : super(key: key);

  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: displayWidth(context) * 0.16,
      child: OutlinedButton(
        onPressed: onTap,
        child: Text(
          text.toUpperCase(),
          style: Theme.of(context).textTheme.button.copyWith(
                fontSize: displayWidth(context) * 0.042,
              ),
        ),
      ),
    );
  }
}
