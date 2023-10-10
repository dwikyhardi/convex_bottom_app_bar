library convex_bottom_app_bar;

export 'package:convex_bottom_app_bar/bottom_curved_painter.dart';
export 'package:convex_bottom_app_bar/convex_bottom_app_bar_item.dart';
export 'package:convex_bottom_app_bar/convex_item.dart';
export 'package:convex_bottom_app_bar/convex_tab_controller.dart';
export 'package:convex_bottom_app_bar/convex_tab_view.dart';

import 'package:convex_bottom_app_bar/bottom_curved_painter.dart';
import 'package:convex_bottom_app_bar/convex_bottom_app_bar_item.dart';
import 'package:convex_bottom_app_bar/convex_item.dart';
import 'package:convex_bottom_app_bar/convex_tab_controller.dart';
import 'package:flutter/material.dart';

class ConvexBottomAppBar extends StatefulWidget {
  final Function(int)? onTap;
  final ConvexTabController? controller;
  final List<ConvexBottomAppBarItem> items;
  final TextStyle? titleTextStyle;
  final Color? backgroundColor;
  final Color? indicatorColor;
  final Color? selectedColor;
  final Color? unSelectedColor;
  final Color? selectedTitleColor;
  final Color? unSelectedTitleColor;
  final double? convexBottomAppHeight;
  final bool? isUseCenterFAB;
  final Widget? floatingActionButtonCenterWidget;
  final Widget? floatingActionButtonTitle;
  final BoxDecoration? floatingActionButtonDecoration;

  const ConvexBottomAppBar({
    Key? key,
    this.onTap,
    this.controller,
    required this.items,
    this.titleTextStyle,
    this.backgroundColor,
    this.indicatorColor,
    this.selectedColor,
    this.unSelectedColor,
    this.selectedTitleColor,
    this.unSelectedTitleColor,
    this.convexBottomAppHeight,
    this.isUseCenterFAB,
    this.floatingActionButtonCenterWidget,
    this.floatingActionButtonTitle,
    this.floatingActionButtonDecoration,
  })  : assert(items.length > 0),
        assert(
          isUseCenterFAB == true
              ? items.length == 2 || items.length == 4 || items.length == 6
              : true,
          '\n\nIf Using floating action button '
          'you must provide 2, 4 or 6 "convexBottomAppBarItems"\n',
        ),
        super(key: key);

  @override
  State<ConvexBottomAppBar> createState() => _ConvexBottomAppBarState();
}

class _ConvexBottomAppBarState extends State<ConvexBottomAppBar>
    with TickerProviderStateMixin {
  int _selectedIndex = 0;

  late final AnimationController _xController = AnimationController(
      vsync: this, animationBehavior: AnimationBehavior.preserve);
  late final AnimationController _yController = AnimationController(
      vsync: this, animationBehavior: AnimationBehavior.preserve);

  @override
  void initState() {
    Listenable.merge([_xController, _yController]).addListener(() {
      // _updateAnimation();
      setState(() {});
    });

    if (widget.controller != null) {
      widget.controller!.addListener(() {
        _selectedIndex = widget.controller?.index ?? 0;
        setState(() {});
        _updateAnimation();
      });
    }

    super.initState();
  }

  @override
  void didChangeDependencies() {
    // _xController.value =
    //     _indexToPosition(_selectedIndex) / MediaQuery.of(context).size.width;
    // _yController.value = 1.0;
    _updateAnimation();

    super.didChangeDependencies();
  }

  double _indexToPosition(int index) {
    // Calculate button positions based off of their
    // index (works with `MainAxisAlignment.spaceAround`)
    return (_getButtonContainerWidth() * index) +
        (_getButtonContainerWidth() / 2);
  }

  @override
  void dispose() {
    _xController.dispose();
    _yController.dispose();
    super.dispose();
  }

  Widget _buildBackground() {
    const inCurve = ElasticOutCurve(0.38);
    return CustomPaint(
      painter: BackgroundCurvePainter(
        x: _xController.value * MediaQuery.of(context).size.width,
        normalizedY: Tween<double>(
          begin: Curves.easeInExpo.transform(_yController.value),
          end: inCurve.transform(_yController.value),
        ).transform(_yController.velocity.sign * 0.5 + 0.5),
        backgroundColor: widget.backgroundColor ?? Colors.white,
        indicatorColor: widget.indicatorColor ?? Colors.blue,
        indicatorWidth: _getButtonContainerWidth(),
      ),
    );
  }

  double _getButtonContainerWidth() {
    double width = MediaQuery.of(context).size.width / (widget.items.length);

    // if (isUseCenterFAB == true) {
    //   return width - 56;
    // } else {
    return width;
    // }
  }

  void _handlePressed(int index) {
    if (_selectedIndex == index || _xController.isAnimating) return;
    if (widget.onTap != null) {
      widget.onTap!(index);
    }
    setState(() {
      _selectedIndex = index;
      if (widget.controller != null) widget.controller?.jumpToTab(index);
    });

    _updateAnimation();
  }

  void _updateAnimation() {
    _yController.value = 1.0;
    _xController.animateTo(
        _indexToPosition(_selectedIndex) / MediaQuery.of(context).size.width,
        duration: const Duration(milliseconds: 310));
    Future.delayed(
      const Duration(milliseconds: 250),
      () {
        _yController.animateTo(1.5,
            duration: const Duration(milliseconds: 600));
      },
    );
    _yController.animateTo(0.0, duration: const Duration(milliseconds: 150));
  }

  @override
  Widget build(BuildContext context) {
    final appSize = MediaQuery.of(context).size;
    final height =
        widget.convexBottomAppHeight ?? AppBar().preferredSize.height * 1.5;
    return SizedBox(
      width: appSize.width,
      height: height + 32,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 32,
            width: appSize.width,
            height: height,
            child: _buildBackground(),
          ),
          Positioned(
            left: 0,
            top: 32,
            width: appSize.width,
            height: height - 32,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: _populateIcons() ?? [],
            ),
          ),
          if (widget.isUseCenterFAB == true)
            Positioned(
              left: 0,
              top: 0,
              right: 0.0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 52,
                        height: 52,
                        decoration: widget.floatingActionButtonDecoration ??
                            const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.blue,
                            ),
                      ),
                      widget.floatingActionButtonCenterWidget ??
                          const SizedBox(),
                    ],
                  ),
                  if (widget.floatingActionButtonTitle != null) ...[
                    const SizedBox(height: 8),
                    widget.floatingActionButtonTitle ?? const SizedBox(),
                  ],
                ],
              ),
            ),
        ],
      ),
    );
  }

  List<Widget>? _populateIcons() {
    List<Widget>? items = [];
    for (int i = 0; i < widget.items.length; i++) {
      var item = widget.items[i];
      items.add(
        ConvexItem(
          index: i,
          onTap: _handlePressed,
          isEnable: item.isEnable,
          icon: item.icon,
          itemSize: item.size,
          title: item.title,
          controller: widget.controller,
          titleTextStyle: item.textStyle?.copyWith(
                  color: widget.controller?.index == i
                      ? item.selectedTitleColor ?? widget.selectedTitleColor
                      : item.unSelectedTitleColor ??
                          widget.unSelectedTitleColor) ??
              widget.titleTextStyle?.copyWith(
                  color: widget.controller?.index == i
                      ? item.selectedTitleColor ?? widget.selectedTitleColor
                      : item.unSelectedTitleColor ??
                          widget.unSelectedTitleColor),
          color: widget.controller?.index == i
              ? item.selectedColor ?? widget.selectedColor
              : item.unSelectedColor ?? widget.unSelectedColor,
          backgroundColor: widget.backgroundColor ?? Colors.white,
        ),
      );
    }

    if (widget.isUseCenterFAB == true) {
      // items.insert(2, Container(width: 0));
      return items;
    } else {
      return items;
    }
  }
}
