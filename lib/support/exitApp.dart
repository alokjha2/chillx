



import 'dart:io';

import 'package:flutter/material.dart';
import 'package:chillx/support/custom_alert.dart';

showExitDialog(BuildContext context){
  showDialog(context: context, 
  barrierDismissible: true,
  // barrierColor: Colors.lightBlue,
  builder: (context) =>AlertDialog(
    // title: Text("Exit"),
    content: Text("Do you want to exit"),
    actions: [
      TextButton(onPressed: (){
        Navigator.pop(context);
      }, child: Text("no")),
      TextButton(onPressed: (){
        exit(0);
      }, child: Text("yes")),
    ],
  ));
}


// showExitDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (context) => CustomAlert(
//         child: Padding(
//           padding: EdgeInsets.all(20.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               SizedBox(height: 15.0),
//               Text("Chirkut",
//                 // Constants.appName,
//                 style: TextStyle(
//                   fontWeight: FontWeight.bold,
//                   fontSize: 16.0,
//                 ),
//               ),
//               SizedBox(height: 25.0),
//               Text(
//                 'Are you sure you want to quit?',
//                 style: TextStyle(
//                   fontWeight: FontWeight.w500,
//                   fontSize: 14.0,
//                 ),
//               ),
//               SizedBox(height: 40.0),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: <Widget>[

//                   Container(
//                     height: 40.0,
//                     width: 130.0,
//                     child: TextButton(
//                       child: Text(
//                         'No',
//                         style: TextStyle(
//                           color: Theme.of(context).colorScheme.secondary,
//                         ),
//                       ),
//                       onPressed: () => Navigator.pop(context),
//                     ),
//                   ),
//                   Container(
//                     height: 40.0,
//                     width: 130.0,
//                     child: ElevatedButton(
//                       // shape: RoundedRectangleBorder(
//                       //   borderRadius: BorderRadius.circular(5.0),
//                       // ),
//                       child: Text(
//                         'Yes',
//                         style: TextStyle(
//                           color: Colors.white,
//                         ),
//                       ),
//                       onPressed: () => exit(0),
//                       // color: Theme.of(context).colorScheme.secondary,
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 20.0),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
