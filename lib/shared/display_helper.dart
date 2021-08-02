import 'package:flutter/material.dart';

//Display helpers
MediaQueryData displayQuery(BuildContext context) {
  return MediaQuery.of(context);
}

Size displaySize(BuildContext context) {
  return MediaQuery.of(context).size;
}

double displayHeight(BuildContext context) {
  return displaySize(context).height - displayQuery(context).padding.top;
}

double displayWidth(BuildContext context) {
  return displaySize(context).width;
}

Widget sizedBoxHeight(BuildContext context, double space) {
  return SizedBox(
    height: displayHeight(context) * space,
  );
}

Widget sizedBoxWidth(BuildContext context, double space) {
  return SizedBox(
    width: displayWidth(context) * space,
  );
}
