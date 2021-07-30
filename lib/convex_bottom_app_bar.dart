import 'package:convex_bottom_app_bar/bottom_curved_painter.dart';
import 'package:convex_bottom_app_bar/convex_bottom_app_bar_item.dart';
import 'package:convex_bottom_app_bar/convex_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

export 'package:convex_bottom_app_bar/bottom_curved_painter.dart';
export 'package:convex_bottom_app_bar/convex_bottom_app_bar_item.dart';
export 'package:convex_bottom_app_bar/convex_item.dart';

class ConvexBottomAppBar extends StatefulWidget {
  final Function(int)? onClickParent;
  final List<ConvexBottomAppBarItem>? convexBottomAppBarItems;
  final TextStyle? titleTextStyle;
  final Color? backgroundColor;
  final bool isUseTitle;
  final Color? selectedColor;
  final Color? unselectedColor;

  ConvexBottomAppBar(
      {Key? key,
      this.onClickParent,
      required this.convexBottomAppBarItems,
      required this.isUseTitle,
      this.titleTextStyle,
      this.backgroundColor,
      this.selectedColor,
      this.unselectedColor})
      : super(key: key);

  @override
  _ConvexBottomAppBarState createState() => _ConvexBottomAppBarState(
      this.onClickParent,
      this.convexBottomAppBarItems,
      this.backgroundColor,
      this.isUseTitle,
      this.titleTextStyle,
      this.selectedColor,
      this.unselectedColor);
}

class _ConvexBottomAppBarState extends State<ConvexBottomAppBar>
    with TickerProviderStateMixin {
  int _selectedIndex = 0;

  late AnimationController _xController;
  late AnimationController _yController;

  final Function(int)? onClickParent;
  final List<ConvexBottomAppBarItem>? convexBottomAppBarItems;
  final TextStyle? titleTextStyle;
  final Color? backgroundColor;
  final bool isUseTitle;
  final Color? selectedColor;
  final Color? unselectedColor;

  _ConvexBottomAppBarState(
      this.onClickParent,
      this.convexBottomAppBarItems,
      this.backgroundColor,
      this.isUseTitle,
      this.titleTextStyle,
      this.selectedColor,
      this.unselectedColor);

  @override
  void initState() {
    _xController = AnimationController(
        vsync: this, animationBehavior: AnimationBehavior.preserve);
    _yController = AnimationController(
        vsync: this, animationBehavior: AnimationBehavior.preserve);

    Listenable.merge([_xController, _yController]).addListener(() {
      setState(() {});
    });

    super.initState();
  }

  @override
  void didChangeDependencies() {

    _xController.value =
        _indexToPosition(_selectedIndex) / MediaQuery.of(context).size.width;
    _yController.value = 1.0;

    super.didChangeDependencies();
  }

  double _indexToPosition(int index) {
    // Calculate button positions based off of their
    // index (works with `MainAxisAlignment.spaceAround`)
    return (_getButtonContainerWidth() * index) + (_getButtonContainerWidth() / 2);
  }

  @override
  void dispose() {
    _xController.dispose();
    _yController.dispose();
    super.dispose();
  }

  Widget _buildBackground() {
    final inCurve = ElasticOutCurve(0.38);
    return CustomPaint(
      painter: BackgroundCurvePainter(
          _xController.value * MediaQuery.of(context).size.width,
          Tween<double>(
            begin: Curves.easeInExpo.transform(_yController.value),
            end: inCurve.transform(_yController.value),
          ).transform(_yController.velocity.sign * 0.5 + 0.5),
          backgroundColor ?? Colors.white),
    );
  }

  double _getButtonContainerWidth() {
    double width = MediaQuery.of(context).size.width / (convexBottomAppBarItems?.length ?? 0);
    // if (width > 400.0) {
    //   width = 400.0;
    // }
    return width;
  }

  void _handlePressed(int index) {
    if (_selectedIndex == index || _xController.isAnimating) return;
    if (onClickParent != null) {
      onClickParent!(index);
    }
    setState(() {
      _selectedIndex = index;
    });

    _yController.value = 1.0;
    _xController.animateTo(
        _indexToPosition(index) / MediaQuery.of(context).size.width,
        duration: Duration(milliseconds: 310));
    Future.delayed(
      Duration(milliseconds: 250),
      () {
        _yController.animateTo(1.5, duration: Duration(milliseconds: 600));
      },
    );
    _yController.animateTo(0.0, duration: Duration(milliseconds: 150));
  }

  @override
  Widget build(BuildContext context) {
    final appSize = MediaQuery.of(context).size;
    final height = 60.0;
    return Container(
      width: appSize.width,
      height: height,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            bottom: 0,
            width: appSize.width,
            height: height - 10,
            child: _buildBackground(),
          ),
          Positioned(
            left: 0,
            top: 0,
            width: appSize.width,
            height: height,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: populateIcons() ?? <Widget>[],
            ),
          ),
        ],
      ),
    );
  }

  List<Container>? populateIcons() {
    List<Container>? items = [];
    double width = MediaQuery.of(context).size.width / (convexBottomAppBarItems?.length ?? 0);
    for (int i = 0; i < (convexBottomAppBarItems?.length ?? 0); i++) {
      var item = convexBottomAppBarItems?[i];
      items.add(
        Container(
          width: width,
          child: ConvexItem(
            item?.icon ?? Icons.error_outline_rounded,
            title: item?.title,
            index: i,
            titleTextStyle: item?.titleTextStyle ?? titleTextStyle,
            isEnable: _selectedIndex == i,
            overrideOnClick: item?.overrideOnClick ?? _handlePressed,
            yController: _yController,
            selectedColor: item?.selectedColor ?? selectedColor,
            unselectedColor: item?.unSelectedColor ?? unselectedColor,
          ),
        ),
      );
    }
    return items;
  }
}
