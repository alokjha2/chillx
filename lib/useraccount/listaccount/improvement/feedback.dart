

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:chillx/support/message.dart';
import 'package:chillx/support/showInfo.dart';

class Feedback extends StatefulWidget {
  const Feedback({Key? key}) : super(key: key);

  @override
  State<Feedback> createState() => _FeedbackState();
}

class _FeedbackState extends State<Feedback> {
  final TextEditingController feedback = TextEditingController();
  final TextEditingController subject = TextEditingController();
  final sizedbox = const SizedBox(height: 14,);
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final CollectionReference Feedbacknow = FirebaseFirestore.instance.collection('Feedback');
  final user = FirebaseAuth.instance.currentUser!;
  final information = "Clearly define what do you want us to improve in Chirkut in order to improve the user's experience";
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text("Feedback"),
    actions: [
      IconButton(onPressed: (){
        showInfo(context: context, information: information);
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
            hintText: "Subject",
            fillColor: Colors.grey[40],
          ),
            controller: subject,          
          ),
          sizedbox,
    
          TextFormField(
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
            hintText: "Write your feedback...",
            // fillColor: Colors.grey[100],
          ),
            controller: feedback,          
          ),
          sizedbox,
          Container(
          decoration : const BoxDecoration(
            color: Colors.lightBlueAccent,
            
            ),
               
                        width: double.infinity,
                        child: TextButton(
                        
                        child: Text("SUBMIT", style: GoogleFonts.lato(color: Colors.white),),
                        onPressed: ()async{
                          await Future.delayed(Duration(seconds: 1));
                          Feedbackapp();
                        })),
      ]),
    ),
    );
  }
  // ignore: non_constant_identifier_names
  Feedbackapp()async{
    final doc = FirebaseFirestore.instance.collection('customerServices').doc("Feedback");
    final feedbackList = [
      "${subject.text},       ${feedback.text}    ${user.displayName}",
      
    ];

    await doc.update({
      "FeedBack" : FieldValue.arrayUnion(feedbackList),
      
    }
    
    ).then((value) {
      message(message: "Thanks for feedback", bgcolor: Colors.blue, txtcolor: Colors.white);
      Navigator.of(context).pop();
      
      }
    );
  }
}