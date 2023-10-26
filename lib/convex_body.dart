import 'package:flutter/material.dart';

import 'convex_bottom_app_bar.dart';

class ConvexBody extends StatelessWidget {
  final AlignmentGeometry alignment;
  final TextDirection? textDirection;
  final Clip clipBehavior;
  final StackFit sizing;
  final List<Widget> children;
  final ConvexTabController controller;

  const ConvexBody({
    super.key,
    this.alignment = AlignmentDirectional.topStart,
    this.textDirection,
    this.clipBehavior = Clip.hardEdge,
    this.sizing = StackFit.loose,
    required this.controller,
    required this.children,
  });

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
