import 'package:convex_bottom_app_bar/convex_bottom_app_bar.dart';
import 'package:flutter/material.dart';

/// A widget that displays a stack of children, showing only the child at the current index
/// provided by the [ConvexTabController]. The stack updates when the controller notifies listeners.
///
/// The [ConvexBody] allows customization of alignment, text direction, clipping behavior,
/// and sizing of the stack.
///
/// Example usage:
/// ```dart
/// ConvexBody(
///   controller: myController,
///   children: [Widget1(), Widget2()],
/// )
/// ```
class ConvexBody extends StatelessWidget {
  /// Creates a [ConvexBody] widget.
  ///
  /// [controller] controls the currently visible child.
  /// [children] is the list of widgets to display.
  /// [alignment] aligns the stack's children.
  /// [textDirection] sets the text direction for alignment.
  /// [clipBehavior] determines how to clip the stack's children.
  /// [sizing] controls how the stack sizes its children.
  const ConvexBody({
    required this.controller,
    required this.children,
    super.key,
    this.alignment = AlignmentDirectional.topStart,
    this.textDirection,
    this.clipBehavior = Clip.hardEdge,
    this.sizing = StackFit.loose,
  });

  /// Alignment for the stack's children.
  final AlignmentGeometry alignment;

  /// Text direction for alignment.
  final TextDirection? textDirection;

  /// Clipping behavior for the stack.
  final Clip clipBehavior;

  /// Sizing for the stack's children.
  final StackFit sizing;

  /// List of widgets to display in the stack.
  final List<Widget> children;

  /// Controller that manages the current index.
  final ConvexTabController controller;

  /// Builds the widget tree for [ConvexBody].
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
