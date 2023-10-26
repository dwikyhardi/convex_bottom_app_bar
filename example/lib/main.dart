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
  late ConvexTabController tabController = ConvexTabController(
    initialIndex: 0,
    length: _items().length,
  );

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
          onPressed: () {},
        ),
        body: ConvexBody(
          controller: tabController,
          children: [
            TestPage('Home', Colors.red),
            TestPage('Search', Colors.blue),
            TestPage('Scan QR', Colors.blue),
            TestPage('Cart', Colors.green),
            TestPage('Favorite', Colors.deepOrange),
          ],
        ),
        bottomNavigationBar: ConvexBottomAppBarV2(
          controller: tabController,
          notchMargin: 5,
          shape: CircularNotchedRectangle(),
          backgroundColor: Colors.white,
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
        icon: Icon(Icons.home),
        title: 'Home',
      ),
      ConvexBottomAppBarItem(
        icon: Icon(Icons.search),
        title: 'Search',
        textStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.lightGreen,
        ),
        selectedColor: Colors.green,
      ),
      ConvexBottomAppBarItem(
          title: 'Scan QR',
          textStyle: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 11,
              color: Color(0xFFA6A6A6))),
      ConvexBottomAppBarItem(
        icon: Icon(Icons.card_travel),
      ),
      ConvexBottomAppBarItem(
        icon: Icon(Icons.favorite_border),
        title: 'Fav',
      ),
    ];
  }
}
