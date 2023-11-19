


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:chillx/post/postComments-logic.dart';
import 'package:chillx/post/showComments.dart';
import 'package:chillx/support/message.dart';





class comment extends StatefulWidget {
  final String id;
  comment({Key? key,required this.id}) : super(key: key);

  @override
  State<comment> createState() => _commentState();
}

class _commentState extends State<comment> {
  
  final user = FirebaseAuth.instance.currentUser!;
  final TextEditingController comment = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool hasMoreData = true;
  var isLoading1 = false;
  DocumentSnapshot? lastDocument;
  int documentLimit = 8;
  final ScrollController scrollController = ScrollController();
  List itemsData = [];
  List<DocumentSnapshot> _comments = [];

  bool loadingcomments = false;


  Future<void> getComment({required postId})async{

    Query q = _firestore.collection("Post").doc(postId).collection("comments").orderBy("createdOn").limit(8);

    loadingcomments = true;
    QuerySnapshot querySnapshot = await q.get();
    _comments = querySnapshot.docs;
    loadingcomments = false;
  }

  Future<void> getCommentinParts({required postId})async {
    if (lastDocument==null) {
      await _firestore.collection("Post").doc(postId).collection("comments").orderBy("createdOn").limit(documentLimit).get().then((value) {

      isLoading1 = false;
      }
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body : Container(
        child: _comments.length == 0 ? Center() : 
        ListView.builder(itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: 
            Text(_comments.length.toString())
            ,
          );
        })
        )
    );
  }
}





// SingleChildScrollView(
//         child: Column(
//                               //  trailing: Text(""),
//                                children: List<Widget>.generate(
//                                  100,
//                                  (int index) => postComment("loved avtar", "Chirkut", context)
//                                ),
//                               //  title: 
//                               //  Text("comments")
//                               //  Icon(Icons.comment)
//                                ),
//       ),
//       // Container(child: 
//       // List<Widget>.generate(
//       //                          10,
//       //                          (int index) => postComment("loved avtar", "Chirkut", context)
//       //                        ),),
//       //  postComment("alok", "peckish", context),
//       floatingActionButton: Padding(
//         padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
//         child: 
        
//         TextFormField(
//           onSaved: (newValue) {
//             addComment(postId: widget.id, title: comment.text, uid: user.uid, time: DateTime.now().toString(), timeStamp:FieldValue.serverTimestamp(), controller : comment);
//             comment.clear();
//             deactivate();
//           },
//           onTap: (){

//             deactivate();  
//             },
//            maxLines: 1,
//            minLines: 1,
//            decoration: InputDecoration(
//                       enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(30)),
//                           borderSide: BorderSide(color: Colors.white)
//                       ),
//                       focusedBorder: const OutlineInputBorder(
                        
//                           borderRadius: BorderRadius.all(Radius.circular(30)),
//                           // borderSide: BorderSide(color: Colors.grey[300])
//                       ),
//                       filled: true,
//                       fillColor: Colors.grey[200],
//                       hintText: "Write here...", hintStyle: GoogleFonts.lato(textStyle: TextStyle(fontSize: 17))
//         ),
//         controller: comment,
//       ),
//       ),
      
 