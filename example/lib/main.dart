import 'package:convex_bottom_app_bar/convex_bottom_app_bar.dart';
import 'package:convex_bottom_app_bar_example/test_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int currentPage = 0;
  late ConvexTabController tabController = ConvexTabController(initialIndex: 0);

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
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          shape: const CircleBorder(),
          onPressed: () {
            tabController.jumpToTab(3);
          },
        ),
        body: ConvexBody(
          controller: tabController,
          children: const [
            TestPage('Home', Colors.red),
            TestPage('Search', Colors.blue),
            TestPage('Scan QR', Colors.blue),
            TestPage('Cart', Colors.green),
            TestPage('Favorite', Colors.deepOrange),
          ],
        ),
        bottomNavigationBar: ConvexBottomAppBarV2(
          controller: tabController,
          backgroundColor: Colors.white,
          selectedColor: CupertinoColors.activeBlue,
          unSelectedColor: CupertinoColors.inactiveGray,
          indicatorColor: CupertinoColors.activeBlue,
          items: _items(),
        ),
        // body: ConvexTabView(
        //   controller: tabController,
        //   screens: [
        //     TestPage('Home', Colors.red),
        //     TestPage('Search', Colors.blue),
        //     TestPage('Search', Colors.blue),
        //     TestPage('Cart', Colors.green),
        //     TestPage('Favorite', Colors.deepOrange),
        //   ],
        //   items: _items(),
        // ),
      ),
    );
  }

  List<ConvexBottomAppBarItem> _items() {
    return [
      ConvexBottomAppBarItem(
        icon: const Icon(Icons.home),
        title: 'Home',
      ),
      ConvexBottomAppBarItem(
        icon: const Icon(Icons.search),
        title: 'Search',
      ),
      ConvexBottomAppBarItem(
          title: 'Scan QR',
          textStyle: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 11,
              color: Color(0xFFA6A6A6))),
      ConvexBottomAppBarItem(
        icon: const Icon(Icons.card_travel),
        title: 'Travel',
      ),
      ConvexBottomAppBarItem(
        icon: const Icon(Icons.favorite_border),
        title: 'Fav',
      ),
    ];
  }
}
