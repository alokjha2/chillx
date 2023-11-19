






// theme dialog
import 'package:flutter/material.dart';

void report(BuildContext context, _value){
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) => AlertDialog(
      title: Text("Theme"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(leading: 
            Radio(
              value: 0, 
              groupValue: _value,
              onChanged: (value){
                
              
              Navigator.of(context).pop();
              }),
            title: Text("Light"),),

  
          ListTile(leading: 
          Radio(
            value: 1, 
            groupValue: _value,
            onChanged: (value){
            
          }),
            title: Text("Dark"),),      
        ],
      ),
    )
  );    
}
