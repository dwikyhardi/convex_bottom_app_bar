import 'package:flutter/material.dart';

class ConvexBottomAppBarItem {
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
  final Widget? icon;
  final Widget? unselectedIcon;
  final String? title;
  final bool? isEnable;
  final TextStyle? textStyle;
  final Color? selectedColor;
  final Color? unSelectedColor;
  final Color? selectedTitleColor;
  final Color? unSelectedTitleColor;
  final double? size;
}
