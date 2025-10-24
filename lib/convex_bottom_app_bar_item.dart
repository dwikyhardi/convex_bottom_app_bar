import 'package:flutter/material.dart';

/// Represents an item in a convex bottom app bar.
///
/// Each item can have an icon, an unselected icon, a title, custom text style,
/// selected and unselected colors for the icon and title, an enabled state, and a size.
class ConvexBottomAppBarItem {
  /// Creates a [ConvexBottomAppBarItem].
  ///
  /// All parameters are optional and can be customized for each item.
  ConvexBottomAppBarItem({
    this.icon,
    this.unselectedIcon,
    this.title,
    this.textStyle,
    this.selectedColor,
    this.unSelectedColor,
    this.selectedTitleColor,
    this.unSelectedTitleColor,
    this.isEnable,
    this.size,
  });

  /// The icon widget to display when the item is selected.
  final Widget? icon;

  /// The icon widget to display when the item is unselected.
  final Widget? unselectedIcon;

  /// The title text of the item.
  final String? title;

  /// Whether the item is enabled.
  final bool? isEnable;

  /// The text style for the title.
  final TextStyle? textStyle;

  /// The color of the icon when selected.
  final Color? selectedColor;

  /// The color of the icon when unselected.
  final Color? unSelectedColor;

  /// The color of the title when selected.
  final Color? selectedTitleColor;

  /// The color of the title when unselected.
  final Color? unSelectedTitleColor;

  /// The size of the icon.
  final double? size;
}
