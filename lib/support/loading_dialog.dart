

import 'package:flutter/material.dart';

class loading extends StatefulWidget {
  final String text; 
  loading({Key? key, required this.text}) : super(key: key);

  @override
  State<loading> createState() => _loadingState();
}

class _loadingState extends State<loading> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:[
          CircularProgressIndicator.adaptive(),
          // SizedBox(height: 10,),
          Text(widget.text),
        ],
      ),
    );
  }
}