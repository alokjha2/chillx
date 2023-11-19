



import 'package:flutter/material.dart';

class YourChirkut extends StatefulWidget {
  const YourChirkut({Key? key}) : super(key: key);

  @override
  State<YourChirkut> createState() => _YourChirkutState();
}

class _YourChirkutState extends State<YourChirkut> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text("Your Recommendations")),);
  }
}