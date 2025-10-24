import 'package:flutter/material.dart';

/// A controller for managing the state of a convex tab bar.
///
/// Notifies listeners when the selected tab index changes.
class ConvexTabController extends ChangeNotifier {
  /// Creates a [ConvexTabController] with an optional [initialIndex].
  ///
  /// The [initialIndex] must be non-negative.
  ConvexTabController({
    int initialIndex = 0,
  })  : assert(initialIndex >= 0),
        index = initialIndex;

  /// The current selected tab index.
  late int index;

  /// Changes the selected tab to the given [value] and notifies listeners.
  ///
  /// The [value] must be non-negative.
  void jumpToTab(int value) {
    assert(value >= 0);
    index = value;
    notifyListeners();
  }
}
