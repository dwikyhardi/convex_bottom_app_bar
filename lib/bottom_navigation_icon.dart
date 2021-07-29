import 'package:flutter/material.dart';

class BottomNavigationIcon extends StatelessWidget {
  final IconData icon;
  final bool? isEnable;
  final int index;
  final String? title;
  final TextStyle? titleTextStyle;
  final Function(int)? overrideOnClick;
  final AnimationController? yController;
  final Color? selectedColor;
  final Color? disabledColor;

  BottomNavigationIcon(this.icon,
      {required this.index,
      this.title,
      this.titleTextStyle,
      this.isEnable,
      this.overrideOnClick,
      this.yController,
      this.selectedColor,
      this.disabledColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: InkWell(
            borderRadius: BorderRadius.all(Radius.circular(50)),
            onTap: () {
              overrideOnClick!(index);
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
                        : disabledColor ?? Theme.of(context).iconTheme.color,
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
