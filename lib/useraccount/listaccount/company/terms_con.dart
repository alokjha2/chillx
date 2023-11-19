


import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Termsandcondition extends StatefulWidget {
  const Termsandcondition({Key? key}) : super(key: key);

  @override
  State<Termsandcondition> createState() => _TermsandconditionState();
}

class _TermsandconditionState extends State<Termsandcondition> {
  @override
  
  int position = 1 ;
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text("Terms & Condition")
    ),
    body:
    
    IndexedStack(
      index: position,
      children: <Widget>[
 
      // WebView(
      //   initialUrl: 'https://pages.flycricket.io/chirkut-user/terms.html',
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
       
    //    initialUrl: 'https://pages.flycricket.io/chirkut-user/terms.html',
    //  )
     );
   }
   }