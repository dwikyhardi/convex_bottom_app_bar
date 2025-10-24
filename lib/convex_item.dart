import 'package:flutter/material.dart';

/// A widget that represents an item in a convex bottom app bar.
/// Displays an icon and/or title, and handles tap events.
class ConvexItem extends StatelessWidget {
  /// Creates a [ConvexItem] widget.
  ///
  /// Displays an icon and/or title for a convex bottom app bar item.
  ///
  /// Parameters:
  /// - [icon]: The icon widget to display.
  /// - [index]: The index of the item.
  /// - [onTap]: Callback when the item is tapped.
  /// - [title]: Optional title text.
  /// - [titleTextStyle]: Optional text style for the title.
  /// - [isEnable]: Optional flag to enable/disable the item.
  /// - [itemSize]: Optional size for the item.
  /// - [color]: Optional color for icon and text.
  /// - [isNeedIconColorFilter]: Whether to apply a color filter to the icon.
  const ConvexItem({
    required this.icon,
    required this.index,
    required this.onTap,
    super.key,
    this.title,
    this.titleTextStyle,
    this.isEnable,
    this.itemSize,
    this.color,
    this.isNeedIconColorFilter = true,
  });

  /// The icon widget to display for the item.
  final Widget? icon;

  /// The size of the item.
  final double? itemSize;

  /// Whether the item is enabled.
  final bool? isEnable;

  /// The title text for the item.
  final String? title;

  /// The text style for the title.
  final TextStyle? titleTextStyle;

  /// Callback function when the item is tapped, receives the item's index.
  final void Function(int) onTap;

  /// Whether to apply a color filter to the icon.
  final bool isNeedIconColorFilter;

  /// The index of the item.
  final int index;

  /// The color for the icon and text.
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(index),
      overlayColor: const WidgetStatePropertyAll(Colors.transparent),
      borderRadius: BorderRadius.circular(8),
      child: Builder(builder: (context) {
        if (icon == null) {
          return Column(
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isNeedIconColorFilter)
                ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    color ?? Colors.black,
                    BlendMode.srcIn,
                  ),
                  child: icon,
                )
              else
                icon ?? const SizedBox(),
            ],
          );
        }

        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isNeedIconColorFilter)
              ColorFiltered(
                colorFilter: ColorFilter.mode(
                  color ?? Colors.black,
                  BlendMode.srcIn,
                ),
                child: icon,
              )
            else
              icon ?? const SizedBox(),
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
