


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:chillx/support/message.dart';

class pool extends StatefulWidget {
  final String id;
  final String msg;
  final String bgcolour;
  
  pool({Key? key,required this.id, required this.msg, required this.bgcolour}) : super(key: key);

  @override
  State<pool> createState() => _poolState();
}

class _poolState extends State<pool> {
  
  final user = FirebaseAuth.instance.currentUser!;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final TextEditingController sendMessage = TextEditingController();

  
   @override
  void initState() {
    super.initState();
  SystemChrome.setSystemUIOverlayStyle(
   const SystemUiOverlayStyle(
     systemNavigationBarColor: Colors.transparent
      ));
    
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      backgroundColor: Colors.lightBlue,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
        child: 
        
        TextFormField(
          
           maxLines: 1,
           minLines: 1,
           
           decoration: InputDecoration(
             
             suffixIcon: IconButton(onPressed: (){
               sendmsg();

             }, icon: Icon(Icons.send, size: 25,color: Colors.blue,),),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          borderSide: BorderSide(color: Colors.white)
                      ),
                      focusedBorder: const OutlineInputBorder(
                        
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          // borderSide: BorderSide(color: Colors.grey[300])
                      ),
                      filled: true,
                      fillColor: Colors.grey[100],
                      hintText: "Write here...", hintStyle: GoogleFonts.lato(textStyle: TextStyle(fontSize: 17))
        ),
        controller: sendMessage,
      ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
        child: Center(
          child: Container(
            child: ListView(
              children: [
                Text(widget.msg, style: GoogleFonts.lato(textStyle: TextStyle(fontSize: 18, color: Colors.white)),), 
                SizedBox(height: 80,)
              ]),),
        ),
      ),
    );
  }
  void sendmsg()async{

  final post1 = FirebaseFirestore.instance.collection('Pools').doc(widget.id);
  final messageList = [
    sendMessage.text,
  ];
  await post1.update({
    "message": FieldValue.arrayUnion(messageList),
  }).then((value) {
    Navigator.of(context).pop();
    message(message: "message sent", bgcolor: Colors.green,txtcolor: Colors.white);}).onError((error, stackTrace) => message(message: "caught error", bgcolor: Colors.red,txtcolor: Colors.white));

  
    
  }
}