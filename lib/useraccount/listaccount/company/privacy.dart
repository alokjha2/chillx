

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/routes/circular_reveal_clipper.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
//https://pages.flycricket.io/chirkut/privacy.html

class Privacy extends StatefulWidget {
  const Privacy({Key? key}) : super(key: key);

  @override
  State<Privacy> createState() => _PrivacyState();
}

class _PrivacyState extends State<Privacy> {
  @override
   void initState() {
     super.initState();
    //  if (Platform.isAndroid) WebView.platform = AndroidWebView();
   
   }

  int position = 1 ;
   @override
   Widget build(BuildContext context) {
     return 
     Scaffold(appBar: AppBar(title: Text("Privacy Policy"),),
     body: 
     IndexedStack(
      index: position,
      children: <Widget>[
 
      // WebView(
      //   initialUrl: 'https://pages.flycricket.io/chirkut-user/privacy.html',
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
    //  WebView(
    //   //  onProgress: load(),
       
    //    initialUrl: 'https://pages.flycricket.io/chirkut-user/privacy.html',
    //  )
     );
   }
 }