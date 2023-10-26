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

  const ConvexItem({
    super.key,
    required this.icon,
    required this.index,
    required this.onTap,
    this.controller,
    this.title,
    this.titleTextStyle,
    this.isEnable,
    this.itemSize,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(index);
      },
      child: Builder(builder: (context) {
        if (icon == null) {
          return Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                title ?? '',
                style: titleTextStyle ??
                    TextStyle(
                      color: color,
                      fontSize: 11,
                    ),
              ),
              const SizedBox(height: 8),
            ],
          );
        }

        if (title == null) {
          return Column(
            mainAxisSize: MainAxisSize.max,
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
            ],
          );
        }

        return Column(
          mainAxisSize: MainAxisSize.max,
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
            Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                title ?? '',
                style: titleTextStyle ??
                    TextStyle(
                      color: color,
                      fontSize: 11,
                    ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
