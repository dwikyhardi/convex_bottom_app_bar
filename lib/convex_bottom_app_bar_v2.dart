import 'package:convex_bottom_app_bar/convex_bottom_app_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A customizable convex bottom app bar widget with support for
/// animated indicator, safe area, haptic feedback, and theming.
///
/// Use this widget to display a convex-shaped bottom navigation bar
/// with animated transitions and optional integration with a
/// FloatingActionButton.
class ConvexBottomAppBarV2 extends StatefulWidget {
  /// Creates a customizable convex bottom app bar widget.
  ///
  /// The [ConvexBottomAppBarV2] constructor requires a [controller] and a list of [items].
  /// Optional parameters allow customization of appearance, behavior, and safe area handling.
  const ConvexBottomAppBarV2({
    required this.controller,
    required this.items,
    super.key,
    this.backgroundColor,
    this.elevation,
    this.shape,
    this.clipBehavior = Clip.none,
    this.notchMargin = 5.0,
    this.padding,
    this.surfaceTintColor,
    this.shadowColor,
    this.height,
    this.indicatorColor,
    this.selectedColor,
    this.unSelectedColor,
    this.unSelectedTitleColor,
    this.selectedTitleColor,
    this.isUseHapticFeedback = false,
    this.isUseSafeArea = true,
    this.bottomSafeArea = true,
    this.safeAreaMinimumInsets = EdgeInsets.zero,
  });

  /// The list of items to display in the ConvexBottomAppBar.
  final List<ConvexBottomAppBarItem> items;

  /// The padding around the content of the bottom app bar.
  final EdgeInsetsGeometry? padding;

  /// The background color of the bottom app bar.
  final Color? backgroundColor;

  /// The color of the selected icon.
  final Color? selectedColor;

  /// The color of the unselected icon.
  final Color? unSelectedColor;

  /// The color of the selected title.
  final Color? selectedTitleColor;

  /// The color of the unselected title.
  final Color? unSelectedTitleColor;

  /// The elevation of the bottom app bar.
  final double? elevation;

  /// The shape of the notch for the FloatingActionButton.
  final NotchedShape? shape;

  /// The clip behavior for the bottom app bar.
  final Clip clipBehavior;

  /// The margin around the notch.
  final double notchMargin;

  /// The surface tint color for Material 3.
  final Color? surfaceTintColor;

  /// The shadow color of the bottom app bar.
  final Color? shadowColor;

  /// The color of the animated indicator.
  final Color? indicatorColor;

  /// The height of the bottom app bar.
  final double? height;

  /// The controller for managing tab selection.
  final ConvexTabController controller;

  /// Whether to use haptic feedback on tab change.
  final bool isUseHapticFeedback;

  /// Whether to use a SafeArea for the bottom app bar.
  final bool isUseSafeArea;

  /// Whether to apply the SafeArea to the bottom.
  final bool bottomSafeArea;

  /// The minimum insets for the SafeArea.
  final EdgeInsets safeAreaMinimumInsets;

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

    widget.controller.addListener(_controlListener);
    super.initState();
  }

  void _controlListener() {
    _updateAnimation();
  }

  @override
  void dispose() {
    _xController.dispose();
    _yController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isMaterial3 = theme.useMaterial3;
    final babTheme = BottomAppBarTheme.of(context);
    final defaults = isMaterial3
        ? _ConvexBottomAppBarDefaultsM3(context)
        : _ConvexBottomAppBarDefaultsM2(context);

    final hasFab = Scaffold.of(context).hasFloatingActionButton;
    final notchedShape = widget.shape ?? babTheme.shape ?? defaults.shape;
    final clipper = notchedShape != null && hasFab
        ? _ConvexBottomAppBarClipper(
            geometry: geometryListenable,
            shape: notchedShape,
            materialKey: materialKey,
            notchMargin: widget.notchMargin,
          )
        : const ShapeBorderClipper(shape: RoundedRectangleBorder());
    final elevation =
        widget.elevation ?? babTheme.elevation ?? defaults.elevation!;
    final height = widget.height ??
        babTheme.height ??
        defaults.height ??
        AppBar().preferredSize.height;
    final color = widget.backgroundColor ??
        babTheme.color ??
        defaults.color ??
        Colors.white;
    final surfaceTintColor = widget.surfaceTintColor ??
        babTheme.surfaceTintColor ??
        defaults.surfaceTintColor!;
    final effectiveColor = isMaterial3
        ? ElevationOverlay.applySurfaceTint(color, surfaceTintColor, elevation)
        : ElevationOverlay.applyOverlay(context, color, elevation);
    final shadowColor =
        widget.shadowColor ?? babTheme.shadowColor ?? defaults.shadowColor!;

    final Widget child = SizedBox(
      height: height,
      child: Padding(
        padding: widget.padding ?? EdgeInsets.zero,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: _populateIcons() ?? [],
        ),
      ),
    );

    final stackChild = Stack(
      children: [
        _buildBackground(),
        child,
      ],
    );

    final material = Material(
      key: materialKey,
      type: MaterialType.transparency,
      child: widget.isUseSafeArea
          ? SafeArea(
              bottom: widget.bottomSafeArea,
              minimum: widget.safeAreaMinimumInsets,
              child: stackChild,
            )
          : stackChild,
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
    final width = MediaQuery.sizeOf(context).width / (widget.items.length);

    // if (isUseCenterFAB == true) {
    //   return width - 56;
    // } else {
    return width;
    // }
  }

  /// Handles the tap event on an item in the ConvexBottomAppBar.
  ///
  /// This method performs several checks before triggering a tab change:
  /// - It first checks if the current Scaffold has a FloatingActionButton. If so,
  ///   it conditionally disables certain items in the ConvexBottomAppBar based on
  ///   the number of items and their respective positions. This is to avoid
  ///   interaction conflicts between the FloatingActionButton and the
  ///   ConvexBottomAppBar items that would occupy the same space.
  /// - If there are 7 items and the tapped item's index is 3, the method returns
  ///   without action, as the item is disabled. This typically corresponds to the
  ///   center item in a bottom app bar with 7 items, where the FloatingActionButton
  ///   would be located.
  /// - Similar checks and returns are performed for bottom app bars with 5 items
  ///   (center item at index 2) and 3 items (center item at index 1).
  /// - If the tapped item's index is the same as the currently active tab, or if
  ///   the animation controller `_xController` is currently animating, the method
  ///   returns without action to prevent unnecessary tab changes.
  /// - Finally, if none of the above conditions are met, the method proceeds to
  ///   change the active tab to the tapped item's index and triggers an update
  ///   to the animation to reflect the change.
  ///
  /// @param index The index of the tapped item in the ConvexBottomAppBar.
  void _handlePressed(int index) {
    if (Scaffold.of(context).hasFloatingActionButton) {
      if (widget.items.length == 7 && index == 3) return;
      if (widget.items.length == 5 && index == 2) return;
      if (widget.items.length == 3 && index == 1) return;
    }

    if (widget.controller.index == index || _xController.isAnimating) return;

    widget.controller.jumpToTab(index);
    if (widget.isUseHapticFeedback) {
      HapticFeedback.mediumImpact();
    }

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
    _yController.animateTo(0, duration: const Duration(milliseconds: 150));
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

    final items = <Widget>[];
    for (var i = 0; i < widget.items.length; i++) {
      final item = widget.items[i];
      items.add(
        SizedBox(
          width: _getButtonContainerWidth(),
          child: ListenableBuilder(
            listenable: widget.controller,
            builder: (context, child) {
              return ConvexItem(
                onTap: _handlePressed,
                index: i,
                isEnable: item.isEnable,
                icon: item.unselectedIcon == null
                    ? item.icon
                    : widget.controller.index == i
                        ? item.icon
                        : item.unselectedIcon,
                itemSize: item.size,
                title: item.title,
                titleTextStyle:
                    item.textStyle?.copyWith(color: getTitleColor(i, item)),
                isNeedIconColorFilter: item.unselectedIcon == null,
                color: widget.controller.index == i
                    ? item.selectedColor ?? widget.selectedColor
                    : item.unSelectedColor ?? widget.unSelectedColor,
              );
            },
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
    final bottomNavigationBarTop = geometry.value.bottomNavigationBarTop;
    if (bottomNavigationBarTop != null) {
      return bottomNavigationBarTop;
    }
    final box = materialKey.currentContext?.findRenderObject() as RenderBox?;
    return box?.localToGlobal(Offset.zero).dy ?? 0;
  }

  @override
  Path getClip(Size size) {
    // button is the floating action button's bounding rectangle in the
    // coordinate system whose origin is at the appBar's top left corner,
    // or null if there is no floating action button.
    final button = geometry.value.floatingActionButtonArea
        ?.translate(0, bottomNavigationBarTop * -1.0);
    return shape.getOuterPath(Offset.zero & size, button?.inflate(notchMargin));
  }

  @override
  bool shouldReclip(_ConvexBottomAppBarClipper oldClipper) {
    return oldClipper.geometry != geometry ||
        oldClipper.shape != shape ||
        oldClipper.notchMargin != notchMargin;
  }
}

class _ConvexBottomAppBarDefaultsM2 extends BottomAppBarThemeData {
  const _ConvexBottomAppBarDefaultsM2(this.context)
      : super(
          elevation: 8,
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

class _ConvexBottomAppBarDefaultsM3 extends BottomAppBarThemeData {
  _ConvexBottomAppBarDefaultsM3(this.context)
      : super(
          elevation: 3,
          height: 80,
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
