// // EXPECTATIONS PAGE



// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:recommendation/support/message.dart';

// class Expectations extends StatefulWidget {
//   Expectations({Key? key}) : super(key: key);
//   @override
//   State<Expectations> createState() => _ExpectationsState();
// }

// class _ExpectationsState extends State<Expectations> {
//   final content = "What is your motivation to download this software?";
//   final TextEditingController expectations = TextEditingController();
//   final textstyle = GoogleFonts.lato(textStyle: TextStyle(color: Colors.lightBlue,fontSize: 22, fontWeight: FontWeight.w400, ));

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Text(content),
//               SizedBox(height: 10,),
//               TextFormField(
//                     minLines: 7,
//                     maxLines: 8,
//                     decoration: InputDecoration(
//                       enabledBorder:  OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(8)),
//                         borderSide: BorderSide(color: Colors.grey)
//                     ),
//                       focusedBorder:  OutlineInputBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(8)
//                       ),
//                         borderSide: BorderSide(color: Colors.grey)
//                     ),
//                     filled: true,
//                     hintText: "Write here...",
//                     hintStyle: GoogleFonts.lato()
//                   ),
//                     controller: expectations,          
//                   ),
//                   const SizedBox(height: 20,),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Expanded(
//                         child: Padding(
//                           padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
//                           child: InkWell(
//                             onTap: (){

//                             },
//                             child: Container(
//                               height: 50,
                              
//                               decoration: BoxDecoration(
//                                 border: Border.all(
//                                   color: Colors.lightBlueAccent),
//                                 ),
//                                 width: double.infinity,
//                                 child: Center(child: Text("SKIP", style: textstyle,)),
//                               ),
//                           ),
//                           ),
//                         ),
      
//                       Expanded(
//                         child: Padding(
//                           padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
//                           child: InkWell(
//                             onTap: (){
                              
//                             },
//                             child: Container(
//                               height: 50,
                              
//                               decoration: BoxDecoration(
//                                 border: Border.all(
//                                   color: Colors.lightBlueAccent),
//                                 ),
//                                 width: double.infinity,
//                                 child: Center(child: Text("SUBMIT", style: textstyle,)),
//                               ),
//                           ),
//                     ),          
//                   ),
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }


//   // send expectations message
//   sendExpectations()async{
//     final doc = FirebaseFirestore.instance.collection('customerServices').doc("Expectations");
//     await doc.update({
//       "Expectations" : FieldValue.arrayUnion([expectations.text]),
//     }).then((value) {
//       message(message: "successful");
//       expectations.clear();
//       }).onError((error, stackTrace) => message(message: "sorry! Try later"));
//   }
// }