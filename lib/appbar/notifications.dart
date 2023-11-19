



import 'package:flutter/material.dart';
import 'package:chillx/home/Home.dart';
import 'package:chillx/main.dart' as main;

class Notifications extends StatefulWidget {
   const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      title: const Text("Notifications"),
    ),
    body: Center(child: Text("Here, New notifications will arrive"),),
    );
  }
}