import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'convex_bottom_app_bar.dart';

class ConvexBottomAppBarV2 extends StatefulWidget {
  final List<ConvexBottomAppBarItem> items;

  final EdgeInsetsGeometry? padding;

  final Color? backgroundColor;

  final Color? selectedColor;

  final Color? unSelectedColor;

  final Color? selectedTitleColor;

  final Color? unSelectedTitleColor;

  final double? elevation;

  final NotchedShape? shape;

  final Clip clipBehavior;

  final double notchMargin;

  final Color? surfaceTintColor;

  final Color? shadowColor;

  final Color? indicatorColor;

  final double? height;

  final ConvexTabController controller;

  const ConvexBottomAppBarV2({
    super.key,
    required this.controller,
    this.backgroundColor,
    this.elevation,
    this.shape,
    this.clipBehavior = Clip.none,
    this.notchMargin = 5.0,
    required this.items,
    this.padding,
    this.surfaceTintColor,
    this.shadowColor,
    this.height,
    this.indicatorColor,
    this.selectedColor,
    this.unSelectedColor,
    this.unSelectedTitleColor,
    this.selectedTitleColor,
  });

  @override
  State createState() => _ConvexBottomAppBarV2();
}

class _ConvexBottomAppBarV2 extends State<ConvexBottomAppBarV2>
    with TickerProviderStateMixin {
  late ValueListenable<ScaffoldGeometry> geometryListenable;
  final GlobalKey materialKey = GlobalKey();

  late final AnimationController _xController = AnimationController(
      vsync: this, animationBehavior: AnimationBehavior.preserve);
  late final AnimationController _yController = AnimationController(
      vsync: this, animationBehavior: AnimationBehavior.preserve);

  @override
  void didChangeDependencies() {
    geometryListenable = Scaffold.geometryOf(context);

    _updateAnimation();
    super.didChangeDependencies();
  }

  @override
  void initState() {
    Listenable.merge([_xController, _yController]).addListener(() {
      // _updateAnimation();
      setState(() {});
    });

    widget.controller.addListener(_updateAnimation);
    super.initState();
  }

  @override
  void dispose() {
    _xController.dispose();
    _yController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isMaterial3 = theme.useMaterial3;
    final BottomAppBarTheme babTheme = BottomAppBarTheme.of(context);
    final BottomAppBarTheme defaults = isMaterial3
        ? _ConvexBottomAppBarDefaultsM3(context)
        : _ConvexBottomAppBarDefaultsM2(context);

    final bool hasFab = Scaffold.of(context).hasFloatingActionButton;
    final NotchedShape? notchedShape =
        widget.shape ?? babTheme.shape ?? defaults.shape;
    final CustomClipper<Path> clipper = notchedShape != null && hasFab
        ? _ConvexBottomAppBarClipper(
            geometry: geometryListenable,
            shape: notchedShape,
            materialKey: materialKey,
            notchMargin: widget.notchMargin,
          )
        : const ShapeBorderClipper(shape: RoundedRectangleBorder());
    final double elevation =
        widget.elevation ?? babTheme.elevation ?? defaults.elevation!;
    final double height = widget.height ??
        babTheme.height ??
        defaults.height ??
        AppBar().preferredSize.height;
    final Color color = widget.backgroundColor ??
        babTheme.color ??
        defaults.color ??
        Colors.white;
    final Color surfaceTintColor = widget.surfaceTintColor ??
        babTheme.surfaceTintColor ??
        defaults.surfaceTintColor!;
    final Color effectiveColor = isMaterial3
        ? ElevationOverlay.applySurfaceTint(color, surfaceTintColor, elevation)
        : ElevationOverlay.applyOverlay(context, color, elevation);
    final Color shadowColor =
        widget.shadowColor ?? babTheme.shadowColor ?? defaults.shadowColor!;

    final Widget child = SizedBox(
      height: height,
      child: Padding(
        padding: widget.padding ??
            babTheme.padding ??
            (isMaterial3
                ? const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0)
                : EdgeInsets.zero),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: _populateIcons() ?? [],
        ),
      ),
    );

    final Material material = Material(
      key: materialKey,
      type: MaterialType.transparency,
      child: SafeArea(
          child: Stack(
        children: [
          _buildBackground(),
          child,
        ],
      )),
    );

    return PhysicalShape(
      clipper: clipper,
      elevation: elevation,
      shadowColor: shadowColor,
      color: effectiveColor,
      clipBehavior: widget.clipBehavior,
      child: material,
    );
  }

  Widget _buildBackground() {
    const inCurve = ElasticOutCurve(0.38);
    return CustomPaint(
      size: Size(MediaQuery.sizeOf(context).width, 10),
      painter: BackgroundCurvePainter(
        x: _xController.value * MediaQuery.sizeOf(context).width,
        normalizedY: Tween<double>(
          begin: Curves.easeInExpo.transform(_yController.value),
          end: inCurve.transform(_yController.value),
        ).transform(_yController.velocity.sign * 0.5 + 0.5),
        backgroundColor: widget.backgroundColor ?? Colors.white,
        indicatorColor: widget.indicatorColor ?? Colors.blue,
        indicatorWidth: _getButtonContainerWidth(),
        isJustIndicator: true,
      ),
    );
  }

  double _getButtonContainerWidth() {
    double width = MediaQuery.sizeOf(context).width / (widget.items.length);

    // if (isUseCenterFAB == true) {
    //   return width - 56;
    // } else {
    return width;
    // }
  }

  void _handlePressed(int index) {
    if (widget.items.length == 5 && index == 2) return;

    if (widget.controller.index == index || _xController.isAnimating) return;

    widget.controller.jumpToTab(index);

    _updateAnimation();
  }

  double _indexToPosition() {
    // Calculate button positions based off of their
    // index (works with `MainAxisAlignment.spaceAround`)
    return (_getButtonContainerWidth() * widget.controller.index) +
        (_getButtonContainerWidth() / 2);
  }

  void _updateAnimation() {
    _yController.value = 1.0;
    _xController.animateTo(
        _indexToPosition() / MediaQuery.sizeOf(context).width,
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

  List<Widget>? _populateIcons() {
    Color? getTitleColor(int i, ConvexBottomAppBarItem item) {
      if (widget.controller.index == i) {
        return item.selectedTitleColor ??
            widget.selectedTitleColor ??
            widget.selectedColor;
      } else {
        return item.unSelectedTitleColor ??
            widget.unSelectedTitleColor ??
            widget.unSelectedColor;
      }
    }

    List<Widget>? items = [];
    for (int i = 0; i < widget.items.length; i++) {
      var item = widget.items[i];
      items.add(
        SizedBox(
          width: _getButtonContainerWidth(),
          child: ConvexItem(
            onTap: _handlePressed,
            index: i,
            isEnable: item.isEnable,
            icon: item.icon,
            itemSize: item.size,
            title: item.title,
            controller: widget.controller,
            titleTextStyle:
                item.textStyle?.copyWith(color: getTitleColor(i, item)),
            color: widget.controller.index == i
                ? item.selectedColor ?? widget.selectedColor
                : item.unSelectedColor ?? widget.unSelectedColor,
          ),
        ),
      );
    }

    return items;
  }
}

class _ConvexBottomAppBarClipper extends CustomClipper<Path> {
  const _ConvexBottomAppBarClipper({
    required this.geometry,
    required this.shape,
    required this.materialKey,
    required this.notchMargin,
  }) : super(reclip: geometry);

  final ValueListenable<ScaffoldGeometry> geometry;
  final NotchedShape shape;
  final GlobalKey materialKey;
  final double notchMargin;

  // Returns the top of the BottomAppBar in global coordinates.
  //
  // If the Scaffold's bottomNavigationBar was specified, then we can use its
  // geometry value, otherwise we compute the location based on the AppBar's
  // Material widget.
  double get bottomNavigationBarTop {
    final double? bottomNavigationBarTop =
        geometry.value.bottomNavigationBarTop;
    if (bottomNavigationBarTop != null) {
      return bottomNavigationBarTop;
    }
    final RenderBox? box =
        materialKey.currentContext?.findRenderObject() as RenderBox?;
    return box?.localToGlobal(Offset.zero).dy ?? 0;
  }

  @override
  Path getClip(Size size) {
    // button is the floating action button's bounding rectangle in the
    // coordinate system whose origin is at the appBar's top left corner,
    // or null if there is no floating action button.
    final Rect? button = geometry.value.floatingActionButtonArea
        ?.translate(0.0, bottomNavigationBarTop * -1.0);
    return shape.getOuterPath(Offset.zero & size, button?.inflate(notchMargin));
  }

  @override
  bool shouldReclip(_ConvexBottomAppBarClipper oldClipper) {
    return oldClipper.geometry != geometry ||
        oldClipper.shape != shape ||
        oldClipper.notchMargin != notchMargin;
  }
}

class _ConvexBottomAppBarDefaultsM2 extends BottomAppBarTheme {
  const _ConvexBottomAppBarDefaultsM2(this.context)
      : super(
          elevation: 8.0,
        );

  final BuildContext context;

  @override
  Color? get color => BottomAppBarTheme.of(context).color;

  @override
  Color? get surfaceTintColor => Theme.of(context).colorScheme.surfaceTint;

  @override
  Color get shadowColor => const Color(0xFF000000);
}

// BEGIN GENERATED TOKEN PROPERTIES - BottomAppBar

// Do not edit by hand. The code between the "BEGIN GENERATED" and
// "END GENERATED" comments are generated from data in the Material
// Design token database by the script:
//   dev/tools/gen_defaults/bin/gen_defaults.dart.

class _ConvexBottomAppBarDefaultsM3 extends BottomAppBarTheme {
  _ConvexBottomAppBarDefaultsM3(this.context)
      : super(
          elevation: 3.0,
          height: 80.0,
          shape: const AutomaticNotchedShape(RoundedRectangleBorder()),
        );

  final BuildContext context;
  late final ColorScheme _colors = Theme.of(context).colorScheme;

  @override
  Color? get color => _colors.surface;

  @override
  Color? get surfaceTintColor => _colors.surfaceTint;

  @override
  Color? get shadowColor => Colors.transparent;
}

// END GENERATED TOKEN PROPERTIES - BottomAppBar
