import 'package:flutter/material.dart';

class ConvexItem extends StatelessWidget {
  /// Icon that displayed on bottom app bar
  final IconData icon;
  final bool? isEnable;
  final int? index;
  final String? title;
  final TextStyle? titleTextStyle;
  final Function(int)? overrideOnClick;
  final Color? selectedColor;
  final Color? unselectedColor;

  /// for controlling animation. don't put anything to this parameter
  final AnimationController? yController;

  ConvexItem(this.icon,
      {this.index,
        this.title,
        this.titleTextStyle,
        this.isEnable,
        this.overrideOnClick,
        this.yController,
        this.selectedColor,
        this.unselectedColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              overrideOnClick!(index ?? 0);
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 500),
              alignment:
              isEnable ?? false ? Alignment.topCenter : Alignment.center,
              child: AnimatedContainer(
                height: isEnable ?? false ? 40 : 20,
                duration: Duration(milliseconds: 300),
                alignment: Alignment.center,
                child: Opacity(
                  opacity: isEnable ?? false ? yController?.value ?? 0 : 1,
                  child: Icon(
                    icon,
                    color: isEnable ?? false
                        ? selectedColor ?? Color(0xffE65829)
                        : unselectedColor ?? Theme.of(context).iconTheme.color,
                  ),
                ),
              ),
            ),
          ),
        ),
        if (title != null && (isEnable ?? false))
          Opacity(
            opacity: isEnable ?? false ? yController?.value ?? 0 : 1,
            child: Text(
              title ?? '',
              style: titleTextStyle ?? TextStyle(color: Colors.black),
            ),
          ),
      ],
    );
  }
}
