import 'package:flutter/material.dart';

class ConvexBottomAppBarItem {
  final IconData icon;
  final String? title;
  final TextStyle? titleTextStyle;
  final Function(int)? overrideOnClick;
  final Color? selectedColor;
  final Color? unSelectedColor;

  ConvexBottomAppBarItem(this.icon,
      {this.title,
      this.titleTextStyle,
      this.overrideOnClick,
      this.selectedColor,
      this.unSelectedColor});
}
