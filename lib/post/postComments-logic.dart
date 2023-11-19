




import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:chillx/support/message.dart';


// making comment
addComment({required postId, required title, required uid, required time, required timeStamp, required controller})async{
  
  final comment = FirebaseFirestore.instance.collection('Post').doc(postId).collection("comments").doc();
  await comment.set({
    "comment": title,
    "commentUID": uid,
    "commentID": comment.id,
    "postID":postId,
    "like":[],
    "dislike":[],
    "reply" : [],
    "time": DateTime.now().toString(),
    'createdOn': FieldValue.serverTimestamp(),
      
  }).then((value) {
    
    message(message: 
    "comment added",bgcolor: Colors.green,txtcolor: Colors.white);
    controller.clear();
    // controller.deactivate();
    }).onError((error, stackTrace) => message(message: "Sorry, Error", bgcolor: Colors.red,txtcolor: Colors.white));
}


// deleting comment
deleteComment({required postId, required commentId})async{
  final comment = FirebaseFirestore.instance.collection('Post').doc(postId).collection("comments").doc(commentId);
  await comment.delete().then((value) => message(message: "comment deleted", bgcolor: Colors.green,txtcolor: Colors.white)).onError((error, stackTrace) => message(message: "Sorry, Error", bgcolor: Colors.red,txtcolor: Colors.white));
}


// updating comment
updateComment({required postId, required commentId, required updatedComment})async{
  final comment = FirebaseFirestore.instance.collection('Post').doc(postId).collection("comments").doc(commentId);
  await comment.update({
    "comment":updatedComment,

  }).then((value) => message(message: "comment edited", bgcolor: Colors.green,txtcolor: Colors.white)).onError((error, stackTrace) => message(message: "Sorry, Error", bgcolor: Colors.red,txtcolor: Colors.white));

}