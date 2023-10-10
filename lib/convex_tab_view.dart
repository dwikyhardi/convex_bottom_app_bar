import 'package:flutter/material.dart';

import 'convex_bottom_app_bar.dart';

class ConvexTabView extends StatelessWidget {
  const ConvexTabView({
    super.key,
    Function(int)? onTap,
    required ConvexTabController controller,
    required List<ConvexBottomAppBarItem> items,
    required List<Widget> screens,
    TextStyle? titleTextStyle,
    Color? backgroundColor,
    Color? indicatorColor,
    Color? selectedColor,
    Color? unselectedColor,
    double? convexBottomAppHeight,
    bool? isUseCenterFAB,
    Widget? floatingActionButtonCenterWidget,
    Widget? floatingActionButtonTitle,
    BoxDecoration? floatingActionButtonDecoration,
  })  : _onTap = onTap,
        _controller = controller,
        _items = items,
        _screens = screens,
        _titleTextStyle = titleTextStyle,
        _backgroundColor = backgroundColor,
        _indicatorColor = indicatorColor,
        _selectedColor = selectedColor,
        _unselectedColor = unselectedColor,
        _convexBottomAppHeight = convexBottomAppHeight,
        _isUseCenterFAB = isUseCenterFAB,
        _floatingActionButtonCenterWidget = floatingActionButtonCenterWidget,
        _floatingActionButtonTitle = floatingActionButtonTitle,
        _floatingActionButtonDecoration = floatingActionButtonDecoration,
        assert(
          items.length == screens.length,
          '\n\n"items" length must be the same with "children"\n\n',
        );

  final Function(int)? _onTap;
  final ConvexTabController _controller;
  final List<ConvexBottomAppBarItem> _items;
  final List<Widget> _screens;
  final TextStyle? _titleTextStyle;
  final Color? _backgroundColor;
  final Color? _indicatorColor;
  final Color? _selectedColor;
  final Color? _unselectedColor;
  final double? _convexBottomAppHeight;
  final bool? _isUseCenterFAB;
  final Widget? _floatingActionButtonCenterWidget;
  final Widget? _floatingActionButtonTitle;
  final BoxDecoration? _floatingActionButtonDecoration;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // SizedBox.expand(
        //   child: TabBarView(
        //     physics: const NeverScrollableScrollPhysics(),
        //     controller: _controller,
        //     children: _screens
        //         .map(
        //           (e) => Padding(
        //             padding: EdgeInsets.only(
        //                 bottom: _convexBottomAppHeight ??
        //                     AppBar().preferredSize.height * 1.5),
        //             child: e,
        //           ),
        //         )
        //         .toList(),
        //   ),
        // ),
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
                              AppBar().preferredSize.height * 1.5),
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
          child: ConvexBottomAppBar(
            items: _items,
            onTap: _onTap,
            controller: _controller,
            unSelectedColor: _unselectedColor,
            selectedColor: _selectedColor,
            isUseCenterFAB: _isUseCenterFAB,
            floatingActionButtonDecoration: _floatingActionButtonDecoration,
            floatingActionButtonTitle: _floatingActionButtonTitle,
            indicatorColor: _indicatorColor,
            backgroundColor: _backgroundColor,
            convexBottomAppHeight: _convexBottomAppHeight,
            floatingActionButtonCenterWidget: _floatingActionButtonCenterWidget,
            titleTextStyle: _titleTextStyle,
          ),
        ),
      ],
    );
  }
}
