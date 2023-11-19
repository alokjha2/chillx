



import 'package:flutter/material.dart';



showInfo({required BuildContext context,required information}){
  showDialog(
  context: context,
  barrierDismissible: true,
  builder: (context) => AlertDialog(
    title: Text("Info"),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(information)
      ],
    ),
    actions: <Widget>[
      TextButton(
        onPressed: (){
          Navigator.of(context).pop();
        },
      child: Text("Close"),)
      ]
    )
  );
}
