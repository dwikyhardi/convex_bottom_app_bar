import 'package:convex_bottom_app_bar/convex_bottom_app_bar.dart';
import 'package:convex_bottom_app_bar_example/test_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
  }

  void onBottomIconPressed(int index) {
    setState(() {
      currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Convex Bottom App Bar Example'),
        ),
        extendBody: true,
        resizeToAvoidBottomInset: false,
        extendBodyBehindAppBar: false,
        body: Stack(
          children: [
            SafeArea(
              child: IndexedStack(
                index: currentPage,
                children: <Widget>[
                  TestPage("Home", Colors.red),
                  TestPage("Search", Colors.blue),
                  TestPage("Cart", Colors.green),
                  TestPage("Favorite", Colors.deepOrange),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              child: ConvexBottomAppBar(
                /// onClick for all BottomSheet items
                onClickParent: onBottomIconPressed,
                isUseTitle: true,
                selectedColor: Colors.red,
                unselectedColor: Colors.blue,
                titleTextStyle: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white),
                convexBottomAppBarItems: [
                  ConvexBottomAppBarItem(
                    Icons.home,
                    title: "Home",
                  ),
                  ConvexBottomAppBarItem(
                    Icons.search,
                    title: "Search",
                    titleTextStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.lightGreen,
                    ),
                    selectedColor: Colors.green,
                  ),
                  ConvexBottomAppBarItem(
                    Icons.card_travel,
                  ),
                  ConvexBottomAppBarItem(
                    Icons.favorite_border,
                    title: "Fav",

                    /// override onClick for only one items
                    // overrideOnClick: (index) {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
