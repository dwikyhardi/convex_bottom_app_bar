import 'package:convex_bottom_app_bar/convex_bottom_app_bar.dart';
import 'package:flutter/material.dart';

class ConvexTabView extends StatelessWidget {
  const ConvexTabView({
    required ConvexTabController controller,
    required List<ConvexBottomAppBarItem> items,
    required List<Widget> screens,
    super.key,
    Color? backgroundColor,
    Color? indicatorColor,
    Color? selectedColor,
    Color? unselectedColor,
    double? convexBottomAppHeight,
    NotchedShape? shape,
    Clip? clipBehavior,
    double? notchMargin,
    double? elevation,
    Color? shadowColor,
    EdgeInsetsGeometry? padding,
    Color? surfaceTintColor,
    Color? selectedTitleColor,
    Color? unSelectedTitleColor,
  })  : _controller = controller,
        _items = items,
        _screens = screens,
        _backgroundColor = backgroundColor,
        _indicatorColor = indicatorColor,
        _selectedColor = selectedColor,
        _unselectedColor = unselectedColor,
        _convexBottomAppHeight = convexBottomAppHeight,
        _shape = shape,
        _clipBehavior = clipBehavior ?? Clip.none,
        _notchMargin = notchMargin ?? 5.0,
        _elevation = elevation,
        _shadowColor = shadowColor,
        _padding = padding,
        _surfaceTintColor = surfaceTintColor,
        _selectedTitleColor = selectedTitleColor,
        _unSelectedTitleColor = unSelectedTitleColor,
        assert(
          items.length == screens.length,
          '\n\n"items" length must be the same with "children"\n\n',
        );

  final ConvexTabController _controller;
  final List<ConvexBottomAppBarItem> _items;
  final List<Widget> _screens;
  final Color? _backgroundColor;
  final Color? _indicatorColor;
  final Color? _selectedColor;
  final Color? _unselectedColor;
  final double? _convexBottomAppHeight;
  final NotchedShape? _shape;
  final Clip _clipBehavior;
  final double _notchMargin;
  final double? _elevation;
  final Color? _shadowColor;
  final EdgeInsetsGeometry? _padding;
  final Color? _surfaceTintColor;
  final Color? _selectedTitleColor;

  final Color? _unSelectedTitleColor;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        ListenableBuilder(
          listenable: _controller,
          builder: (ctx, widget) {
            return IndexedStack(
              sizing: StackFit.expand,
              index: _controller.index,
              children: _screens
                  .map(
                    (e) => Padding(
                      padding: EdgeInsets.only(
                          bottom: _convexBottomAppHeight ??
                              AppBar().preferredSize.height),
                      child: e,
                    ),
                  )
                  .toList(),
            );
          },
        ),
        Positioned(
          bottom: 0.0,
          width: MediaQuery.of(context).size.width,
          child: ConvexBottomAppBarV2(
            items: _items,
            height: _convexBottomAppHeight,
            controller: _controller,
            unSelectedColor: _unselectedColor,
            selectedColor: _selectedColor,
            indicatorColor: _indicatorColor,
            backgroundColor: _backgroundColor,
            shape: _shape,
            notchMargin: _notchMargin,
            clipBehavior: _clipBehavior,
            elevation: _elevation,
            shadowColor: _shadowColor,
            padding: _padding,
            surfaceTintColor: _surfaceTintColor,
            selectedTitleColor: _selectedTitleColor,
            unSelectedTitleColor: _unSelectedTitleColor,
          ),
        ),
      ],
    );
  }
}
