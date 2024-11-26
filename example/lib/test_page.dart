import 'package:flutter/material.dart';

class TestPage extends StatefulWidget {
  const TestPage(this.name, this.color, {super.key});

  final String name;
  final Color color;

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (_, __) {
        return const SizedBox(height: 8);
      },
      itemCount: 10,
      itemBuilder: (_, __) {
        return Container(
          height: MediaQuery.sizeOf(context).height * 0.2,
          color: widget.color,
          alignment: Alignment.center,
          child: Text(
            widget.name,
            style: const TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        );
      },
    );
  }
}
