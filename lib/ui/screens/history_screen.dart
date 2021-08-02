import 'package:flutter/material.dart';

import '../../shared/shared.dart';
import '../widgets/widgets.dart';

class HistoryScreen extends StatefulWidget {
  static const String title = 'History';

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: EdgeInsets.all(displayWidth(context) * 0.04),
        child: const BaseListView(),
      ),
    );
  }
}
