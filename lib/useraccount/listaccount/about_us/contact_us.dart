


// import 'dart:io';

import 'dart:io';

import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:chillx/support/message.dart';
import 'package:chillx/useraccount/listaccount/profile/profile.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Contact extends StatefulWidget {
  final String title;
  final String link;
  const Contact({Key? key, required this.title, required this.link}) : super(key: key);

  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  bool isloading= true;
  // double webProgress = 0;
  
  late final ScrollController page = ScrollController();
  @override
   void initState() {
     super.initState();
    //  if (Platform.isAndroid) WebView.platform = AndroidWebView();
  
   }

  int position = 1 ;
   @override
   Widget build(BuildContext context) {
     return 
     Scaffold(appBar: AppBar(title: Text(widget.title),),
     body: 
     IndexedStack(
      index: position,
      children: <Widget>[
 
      // WebView(
      //   initialUrl: widget.link,
      //   javascriptMode: JavascriptMode.unrestricted,
      //   onPageStarted: (value){setState(() {
      //                     position = 1;
      //                   });},
      //   onPageFinished: (value){setState(() {
      //                     position = 0;
      //                   });},
      //   ),
 
       Container(
        child: Center(
          child: CircularProgressIndicator()),
        ),
        
      ])
      // webProgress==100?
      //         WebView(
           
      //  initialUrl:widget.link,
     
      //         )
     
     );
   }
}