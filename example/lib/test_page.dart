import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  final String name;
  final Color color;

  const TestPage(this.name, this.color, {Key? key}) : super(key: key);

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: Colors.black12,
      alignment: Alignment.center,
      child: Text(widget.name,style: TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.bold
      ),),
    );
  }
}
