import 'package:convex_bottom_app_bar/convex_bottom_app_bar.dart';
import 'package:flutter/material.dart';

class ConvexItem extends StatelessWidget {
  /// Icon that displayed on bottom app bar
  final Widget? icon;
  final ConvexTabController? controller;
  final double? itemSize;
  final bool? isEnable;
  final String? title;
  final TextStyle? titleTextStyle;
  final Function(int) onTap;
  final int index;
  final Color? color;
  final Color? backgroundColor;

  const ConvexItem({
    super.key,
    required this.icon,
    required this.index,
    required this.onTap,
    required this.controller,
    this.title,
    this.titleTextStyle,
    this.isEnable,
    this.itemSize,
    this.color,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap(index);
      },
      child: Container(
        color: backgroundColor,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ColorFiltered(
              colorFilter: ColorFilter.mode(
                color ?? Colors.black,
                BlendMode.srcIn,
              ),
              child: icon,
            ),
            if (title != null)
              Text(
                title ?? '',
                style: titleTextStyle ??
                    TextStyle(
                      color: color,
                      fontSize: 11,
                    ),
              ),
          ],
        ),
      ),
    );
  }
}
