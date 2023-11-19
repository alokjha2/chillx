

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chillx/support/message.dart';
import 'package:chillx/support/showInfo.dart';



class RequestFeature extends StatefulWidget {
  const RequestFeature({Key? key}) : super(key: key);

  @override
  State<RequestFeature> createState() => _RequestFeatureState();
}

class _RequestFeatureState extends State<RequestFeature> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final CollectionReference request_feature = FirebaseFirestore.instance.collection('Request_feature');
  final user = FirebaseAuth.instance.currentUser!;
  final TextEditingController feature = TextEditingController();
  final TextEditingController subject = TextEditingController();
  final sizedbox = const SizedBox(height: 14,);
  final requestFeature = "define what features do you want in upcoming updates & how those features improve user's experience";
  
  
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text("Request feature"),
    actions: [
      IconButton(onPressed: (){
        showInfo(context: context, information: requestFeature);
      }, icon: Icon(Icons.help))
    ],
    ),
    body: Padding(
      padding: const EdgeInsets.fromLTRB(16, 30, 16, 20),
      child: Column(
        
        children: [
        TextFormField(
            minLines: 1,
            maxLines: 2,
            decoration: InputDecoration(
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                borderSide: BorderSide(color: Colors.grey)
                // borderSide: BorderSide(color: Colors.grey)
            ),
              focusedBorder:  OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8),
              ),
                borderSide: BorderSide(color: Colors.grey)
            ),
            filled: true,
            hintText: "Feature's name",
            fillColor: Colors.grey[40],
          ),
            controller: subject,          
          ),
          sizedbox,
    
          TextFormField(
            // decoration: InputDecoration(
             
            //  ),
          
            minLines: 7,
            maxLines: 8,
            decoration: const InputDecoration(

              enabledBorder:  OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                borderSide: BorderSide(color: Colors.grey)
                // borderSide: BorderSide(color: Colors.grey)
            ),
              focusedBorder:  OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)
              ),
                borderSide: BorderSide(color: Colors.grey)
            ),
            filled: true,
            hintText: "More detail about requested features...",
            // fillColor: Colors.grey[100],
          ),
            controller: feature,          
          ),
          sizedbox,

          Container(
          decoration : const BoxDecoration(
            color: Colors.lightBlueAccent,
            ),
              width: double.infinity,
              child: TextButton(
              child: Text("SUBMIT", style: TextStyle(color: Colors.white),),
              onPressed: ()async{
                
                await Future.delayed(Duration(seconds: 1));
                request();
              }
            )
          ),  
        ]
      ),
    )
  );
}
request()async{
  final doc = FirebaseFirestore.instance.collection('customerServices').doc("request Feature");
    final feedbackList = [
      "${subject.text},       ${feature.text},    ${user.displayName}",
      
    ];

    await doc.update({
      "Feature" : FieldValue.arrayUnion(feedbackList),
    }
    
    ).then((value) {
       message(message: "Thanks for request", bgcolor: Colors.blue,txtcolor: Colors.white);
       Navigator.of(context).pop();
       });

      
  }
}