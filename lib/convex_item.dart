import 'package:flutter/material.dart';

class ConvexItem extends StatelessWidget {
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

  /// Icon that displayed on bottom app bar
  final Widget? icon;
  final double? itemSize;
  final bool? isEnable;
  final String? title;
  final TextStyle? titleTextStyle;
  final Function(int) onTap;
  final bool isNeedIconColorFilter;
  final int index;
  final Color? color;

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
              isNeedIconColorFilter
                  ? ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        color ?? Colors.black,
                        BlendMode.srcIn,
                      ),
                      child: icon,
                    )
                  : icon ?? const SizedBox(),
            ],
          );
        }

        return Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isNeedIconColorFilter
                ? ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      color ?? Colors.black,
                      BlendMode.srcIn,
                    ),
                    child: icon,
                  )
                : icon ?? const SizedBox(),
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
