import 'package:flutter/material.dart';

class ConvexTabController extends TabController {
  ConvexTabController({
    int initialIndex = 0,
    required int length,
    required TickerProvider vsync,
  })  : assert(initialIndex >= 0),
        assert(initialIndex < length),
        super(length: length, vsync: vsync, initialIndex: initialIndex);

  void jumpToTab(int value) {
    assert(value >= 0);
    index = value;
    notifyListeners();
  }
}
