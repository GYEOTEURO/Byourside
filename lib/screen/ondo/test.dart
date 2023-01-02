import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  const Test({Key? key, required this.value}) : super(key: key);

  final String value;

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Text(widget.value));
}
}