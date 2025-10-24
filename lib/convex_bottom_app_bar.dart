import 'package:convex_bottom_app_bar/bottom_curved_painter.dart';
import 'package:convex_bottom_app_bar/convex_bottom_app_bar_item.dart';
import 'package:convex_bottom_app_bar/convex_item.dart';
import 'package:convex_bottom_app_bar/convex_tab_controller.dart';
import 'package:flutter/material.dart';

export 'package:convex_bottom_app_bar/bottom_curved_painter.dart';
export 'package:convex_bottom_app_bar/convex_body.dart';
export 'package:convex_bottom_app_bar/convex_bottom_app_bar_item.dart';
export 'package:convex_bottom_app_bar/convex_bottom_app_bar_v2.dart';
export 'package:convex_bottom_app_bar/convex_item.dart';
export 'package:convex_bottom_app_bar/convex_tab_controller.dart';
export 'package:convex_bottom_app_bar/convex_tab_view.dart';

/// A custom bottom app bar widget with a convex shape and optional center FAB.
///
/// Displays a list of [ConvexBottomAppBarItem]s and supports animated transitions,
/// custom styles, and a floating action button in the center.
///
/// The number of items must be greater than zero. If [isUseCenterFAB] is true,
/// the number of items must be 2, 4, or 6.
///
/// See also:
///  - [ConvexBottomAppBarItem]
///  - [ConvexTabController]
class ConvexBottomAppBar extends StatefulWidget {
  /// Creates a [ConvexBottomAppBar] widget.
  ///
  /// [items] is required and must contain at least one item.
  /// [onTap] is called when an item is tapped.
  /// [controller] manages the selected tab index.
  /// [titleTextStyle] customizes the style of item titles.
  /// [backgroundColor] sets the background color of the app bar.
  /// [indicatorColor] sets the color of the indicator.
  /// [selectedColor] and [unSelectedColor] set the colors for selected and unselected items.
  /// [selectedTitleColor] and [unSelectedTitleColor] set the colors for selected and unselected titles.
  /// [convexBottomAppHeight] sets the height of the app bar.
  /// [isUseCenterFAB] enables a center floating action button.
  /// [floatingActionButtonCenterWidget] is the widget displayed in the center FAB.
  /// [floatingActionButtonTitle] is the title below the center FAB.
  /// [floatingActionButtonDecoration] customizes the FAB's decoration.
  const ConvexBottomAppBar({
    required this.items,
    this.onTap,
    this.controller,
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
    super.key,
  })  : assert(items.length > 0),
        assert(
          isUseCenterFAB != true ||
              (items.length == 2 || items.length == 4 || items.length == 6),
          '\n\nIf Using floating action button '
          'you must provide 2, 4 or 6 "convexBottomAppBarItems"\n',
        );

  /// Called when an item is tapped, passing the index of the tapped item.
  final void Function(int)? onTap;

  /// Controller to manage the selected tab index.
  final ConvexTabController? controller;

  /// List of items to display in the bottom app bar.
  final List<ConvexBottomAppBarItem> items;

  /// Custom style for item titles.
  final TextStyle? titleTextStyle;

  /// Background color of the app bar.
  final Color? backgroundColor;

  /// Color of the indicator below the selected item.
  final Color? indicatorColor;

  /// Color for selected items.
  final Color? selectedColor;

  /// Color for unselected items.
  final Color? unSelectedColor;

  /// Color for selected item titles.
  final Color? selectedTitleColor;

  /// Color for unselected item titles.
  final Color? unSelectedTitleColor;

  /// Height of the convex bottom app bar.
  final double? convexBottomAppHeight;

  /// Whether to use a center floating action button.
  final bool? isUseCenterFAB;

  /// Widget to display in the center floating action button.
  final Widget? floatingActionButtonCenterWidget;

  /// Title widget below the center floating action button.
  final Widget? floatingActionButtonTitle;

  /// Decoration for the center floating action button.
  final BoxDecoration? floatingActionButtonDecoration;

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
      size: Size(MediaQuery.of(context).size.width, 10),
      painter: BackgroundCurvePainter(
        x: _xController.value * MediaQuery.of(context).size.width,
        normalizedY: Tween<double>(
          begin: Curves.easeInExpo.transform(_yController.value),
          end: inCurve.transform(_yController.value),
        ).transform(_yController.velocity.sign * 0.5 + 0.5),
        backgroundColor: widget.backgroundColor ?? Colors.white,
        indicatorColor: widget.indicatorColor ?? Colors.blue,
        indicatorWidth: _getButtonContainerWidth(),
        isJustIndicator: false,
      ),
    );
  }

  double _getButtonContainerWidth() {
    final width = MediaQuery.of(context).size.width / (widget.items.length);

    // if (isUseCenterFAB == true) {
    //   return width - 56;
    // } else {
    return width;
    // }
  }

  void _handlePressed(int index) {
    if (_selectedIndex == index || _xController.isAnimating) return;
    if (widget.onTap != null) {
      widget.onTap?.call(index);
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
    _yController.animateTo(0, duration: const Duration(milliseconds: 150));
  }

  @override
  Widget build(BuildContext context) {
    final appSize = MediaQuery.of(context).size;
    final height =
        widget.convexBottomAppHeight ?? AppBar().preferredSize.height;
    return SizedBox(
      width: appSize.width,
      height: height,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            width: appSize.width,
            height: height,
            child: _buildBackground(),
          ),
          Positioned(
            left: 0,
            top: 0,
            width: appSize.width,
            height: height,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: _populateIcons() ?? [],
            ),
          ),
          if (widget.isUseCenterFAB ?? false)
            Positioned(
              left: 0,
              top: 0,
              right: 0,
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
    final items = <Widget>[];
    for (var i = 0; i < widget.items.length; i++) {
      final item = widget.items[i];
      items.add(
        ListenableBuilder(
            listenable: widget.controller!,
            builder: (context, child) {
              return ConvexItem(
                index: i,
                onTap: _handlePressed,
                isEnable: item.isEnable,
                icon: item.icon,
                itemSize: item.size,
                title: item.title,
                titleTextStyle: item.textStyle?.copyWith(
                        color: widget.controller?.index == i
                            ? item.selectedTitleColor ??
                                widget.selectedTitleColor
                            : item.unSelectedTitleColor ??
                                widget.unSelectedTitleColor) ??
                    widget.titleTextStyle?.copyWith(
                        color: widget.controller?.index == i
                            ? item.selectedTitleColor ??
                                widget.selectedTitleColor
                            : item.unSelectedTitleColor ??
                                widget.unSelectedTitleColor),
                color: widget.controller?.index == i
                    ? item.selectedColor ?? widget.selectedColor
                    : item.unSelectedColor ?? widget.unSelectedColor,
              );
            }),
      );
    }

    if (widget.isUseCenterFAB ?? false) {
      // items.insert(2, Container(width: 0));
      return items;
    } else {
      return items;
    }
  }
}
