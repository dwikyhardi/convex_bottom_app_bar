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
        body: IndexedStack(
          index: currentPage,
          children: <Widget>[
            TestPage('Home', Colors.red),
            TestPage('Search', Colors.blue),
            TestPage('Cart', Colors.green),
            TestPage('Favorite', Colors.deepOrange),
          ],
        ),
        // floatingActionButton: FloatingActionButton(onPressed: (){}),
        // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: ConvexBottomAppBar(
          /// onClick for all BottomSheet items
          onTap: onBottomIconPressed,
          isUseCenterFAB: true,
          floatingActionButtonTitle: Text(
            'Scan QR',
            style: TextStyle(
              fontSize: 11,
            ),
          ),
          floatingActionButtonCenterWidget: Icon(
            Icons.qr_code_scanner_rounded,
            color: Colors.white,
          ),
          selectedColor: Colors.red,
          unSelectedColor: Colors.blue,
          titleTextStyle:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          items: [
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
              icon: Icon(Icons.card_travel),
            ),
            ConvexBottomAppBarItem(
              icon: Icon(Icons.favorite_border),
              title: 'Fav',
            ),
          ],
        ),
      ),
    );
  }
}
