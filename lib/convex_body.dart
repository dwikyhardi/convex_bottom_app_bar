import 'package:convex_bottom_app_bar/convex_bottom_app_bar.dart';
import 'package:flutter/material.dart';

class ConvexBody extends StatelessWidget {
  const ConvexBody({
    required this.controller,
    required this.children,
    super.key,
    this.alignment = AlignmentDirectional.topStart,
    this.textDirection,
    this.clipBehavior = Clip.hardEdge,
    this.sizing = StackFit.loose,
  });
  final AlignmentGeometry alignment;
  final TextDirection? textDirection;
  final Clip clipBehavior;
  final StackFit sizing;
  final List<Widget> children;
  final ConvexTabController controller;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: controller,
      builder: (_, __) {
        return IndexedStack(
          key: key,
          index: controller.index,
          alignment: alignment,
          clipBehavior: clipBehavior,
          sizing: sizing,
          textDirection: textDirection,
          children: children,
        );
      },
    );
  }
}
