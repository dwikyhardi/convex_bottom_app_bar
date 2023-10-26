import 'package:flutter/material.dart';

class ConvexBottomAppBarItem {
  final Widget? icon;
  final String? title;
  final bool? isEnable;
  final TextStyle? textStyle;
  final Color? selectedColor;
  final Color? unSelectedColor;
  final Color? selectedTitleColor;
  final Color? unSelectedTitleColor;
  final double? size;

  ConvexBottomAppBarItem({
    this.icon,
    this.title,
    this.textStyle,
    this.selectedColor,
    this.unSelectedColor,
    this.selectedTitleColor,
    this.unSelectedTitleColor,
    this.isEnable,
    this.size,
  });
}
