import 'package:flutter/material.dart';

class ConvexTabController extends ChangeNotifier {
  ConvexTabController({
    int initialIndex = 0,
  })  : assert(initialIndex >= 0),
        index = initialIndex;

  late int index;

  void jumpToTab(int value) {
    assert(value >= 0);
    index = value;
    notifyListeners();
  }
}
