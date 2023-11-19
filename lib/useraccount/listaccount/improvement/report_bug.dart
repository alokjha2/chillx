
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chillx/support/message.dart';
import 'package:chillx/support/showInfo.dart';

class Report extends StatefulWidget {
  const Report({Key? key}) : super(key: key);

  @override
  State<Report> createState() => _ReportState();
}

class _ReportState extends State<Report> {
  final TextEditingController Report = TextEditingController();
  final TextEditingController detail = TextEditingController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final CollectionReference Reportdata =
      FirebaseFirestore.instance.collection('report_bug');
    final user = FirebaseAuth.instance.currentUser!;
    final sizedbox = 
      const SizedBox(height: 12,);
      final reportInfo = "properly define what issues do you faced while using Chirkut & define your device specifications e.g Device model";
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(appBar: AppBar(title: const Text("Report Bugs"),
    actions: [
      IconButton(onPressed: (){
        showInfo(context: context, information: reportInfo);
      }, icon: Icon(Icons.help))
    ],
    ),
    body: Padding(
      padding: const EdgeInsets.fromLTRB(16, 30, 16, 20),
      child: Column(children: [
        TextFormField(
            minLines: 1,
            maxLines: 2,
            decoration: InputDecoration(
              enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                borderSide: BorderSide(color: Colors.grey)
            ),
              focusedBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8),
              ),
                borderSide: BorderSide(color: Colors.grey)
            ),
            filled: true,
            hintText: "Report Bug",
            fillColor: Colors.grey[40],
          ),
            controller: Report,          
          ),

          sizedbox,
        TextFormField(

            minLines: 7,
            maxLines: 8,
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
            hintText: "Explain problem in detail ...",
            fillColor: Colors.grey[40],
          ),
            controller: detail,          
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
                          report_bug();
                        })),
      
      

      ]),
    ),
    
    );
  }
  report_bug()async{
    final doc = FirebaseFirestore.instance.collection('customerServices').doc("Report Bug");
    final feedbackList = [
      "${Report.text},      ${detail.text}    ${user.displayName}",
    ];

    await doc.update({
      "reportBug" : FieldValue.arrayUnion(feedbackList),
      
    }
    
    ).then((value) {
      message(message: "Bug reported", bgcolor: Colors.blue,txtcolor: Colors.white);
      Navigator.of(context).pop();
        
      
    });


  }
}