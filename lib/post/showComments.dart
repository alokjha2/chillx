

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:readmore/readmore.dart';
import 'package:chillx/home/showPost.dart';
import 'package:chillx/support/message.dart';
import 'package:chillx/useraccount/listaccount/profile/profile.dart';


void onSelectedComment(BuildContext context, int item, id,commentId ){
        switch (item){

          // edit      
          case 1:
          final post = FirebaseFirestore.instance.collection("Post").doc(id).collection("comments").doc(commentId);
          post.delete().then((value) => message(message: "comment deleted!", bgcolor: Colors.green, txtcolor: Colors.white));
          break;

          case 2:
          message(message: "comment reported!", bgcolor: Colors.green, txtcolor: Colors.white);

          break;
        }}

 String convertToAgo(DateTime input){
  Duration diff = DateTime.now().difference(input);
  if(diff.inDays >= 1){
    return '${diff.inDays} days ago';
  } else if(diff.inHours >= 1){
    return '${diff.inHours} hrs ago';
  } else if(diff.inMinutes >= 1){
    return '${diff.inMinutes} mins ago';
  } else if (diff.inSeconds >= 10){
    return '${diff.inSeconds} secs ago';
  } else {
    return 'just now';
  }
}




Widget time1({required tim}){
  DateTime time1 = DateTime.parse(tim);
  final realTime = convertToAgo(time1); 
  return Text(realTime, style: GoogleFonts.lato(fontSize: 14, color: Colors.grey),);
}




// comment UI - show comment box 
Widget postComment({required String postComment,required  String profileName,required  BuildContext context,required  blockSizeHorizontal,required uid, required time,required postID,required commentId}) {
    return Padding(
      padding:const EdgeInsets.only(
        left: 6.0,
        right: 8.0,
        top: 6.0
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              buildCommentdetails(context, uid),
              Row(
                children: [
                  time1(tim: time),
                  uid==user.uid? PopupMenuButton<int>(
            onSelected: (item)=> onSelectedComment(context, item, postID,commentId),
            itemBuilder: (context) => [
              PopupMenuItem(child: Text("Delete", style: style,),
                value: 1,
              ),
            ]
          ) :
          
          PopupMenuButton<int>(
            onSelected: (item)=> onSelectedComment(context, item, postID,commentId),
            itemBuilder: (context) => [
              PopupMenuItem(child: Text("Report", style: style,),
                value: 2,
              ),
            ]
          ) 
          //  PopupMenuItem(child: Text("", style: style,),
          //       value: 2,
          //     ),
                ],
              ),
            ],
          ),


          // InkWell(
          //             onTap: (){
          //                 // Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft,child: profile(uid: uid, name: name, image: image, joined: joined, isVerified: isVerified, about: about, favouriteArtists: favouriteArtists,)));
          //             },
          //             child: 
          //             Padding(
          //               padding: const EdgeInsets.only(left: 0, right: 0),
          //               child :

          //                Container(
          //                 height: 34,
          //                 width: 34,
          //                   decoration: BoxDecoration(
          //                     image: DecorationImage(image: AssetImage("assets/images/1024.png")),
          //                     shape: BoxShape.circle,
          //                     color: Colors.blue.shade300,
          //                     boxShadow: [
          //                       BoxShadow(
          //                         color: Colors.grey.withOpacity(0.4),
          //                         spreadRadius: 3,
          //                         blurRadius: 6,
          //                         ),
          //                       ],
                          
          //                   ),
          //                   // color: Colors.blue.shade300,


                          //  child:
                          //   CachedNetworkImage(
                          //           imageUrl: image,
                          //           imageBuilder: (context, imageProvider) =>
                          //  Container(
                          //   height: 34,
                          //   width: 34,
                          //   decoration: BoxDecoration(
                          //     shape: BoxShape.circle,
                          //     color: Colors.blue.shade300,
                          //     image: DecorationImage(
                          //                 image: imageProvider,
                          //                 fit: BoxFit.cover,
                          //               ),
                          //     boxShadow: [
                          //       BoxShadow(
                          //         color: Colors.grey.withOpacity(0.4),
                          //         spreadRadius: 3,
                          //         blurRadius: 6,
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // ),
                    //     ),
                    //   )
                    // ),

          const SizedBox(width: 8.0),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: blockSizeHorizontal,
                // width: 200,
                decoration: BoxDecoration( 
                  color: Colors.lightBlue.shade50,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        // height: 40,
                        width: 2070,
                        child:
                        
                        ReadMoreText(
                          postComment,
  // 'Flutter is Google’s mobile UI open source framework to build high-quality native (super fast) interfaces for iOS and Android apps with the unified codebase.',
  trimLines: 3,
  colorClickableText: Colors.pink,
  trimMode: TrimMode.Line,
  trimCollapsedText: 'Read more',
  trimExpandedText: 'Show less',

  moreStyle: GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.w400,color: Colors.red),
  lessStyle: GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.w400,color: Colors.red),
),
                        //  Text(
                        //   postComment,
                        //   maxLines: 3,
                        //   style:GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.w400),
                        // ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12.0),
              // Row(
              //   children: [
              //     Text("12:30", style: TextStyle(fontWeight: FontWeight.w600)),
              //     SizedBox(
              //       width: MediaQuery.of(context).size.width * 0.1,
              //     ),
              //     Text('Like', style: TextStyle(fontWeight: FontWeight.w600)),
              //     SizedBox(
              //       width: MediaQuery.of(context).size.width * 0.1,
              //     ),
              //     InkWell(
              //       onTap: () {},
              //       child: Text(
              //         'Reply',
              //         style: TextStyle(fontWeight: FontWeight.w600),
              //       ),
              //     ),
              //     // SizedBox(
              //       // width: MediaQuery.of(context).size.width * 0.24,
                  
              //     InkWell(
              //         onTap: () {
              //           // _incrementCommentLikeCount();
              //         },
              //         child: Text("10")),
              //     SizedBox(
              //       width: MediaQuery.of(context).size.width * 0.02,
              //     ),
              //   ]
              // )
          ],
        )
      ],
    ),
  );
}



// retrieve comments
Widget showComments({required postId,required width}){
  final docnumber = FirebaseFirestore.instance.collection('Post').doc(postId).collection("comments");
  // final size = snapshot.data!.size;
  return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('Post').doc(postId).collection("comments").limit(12).orderBy('createdOn', descending: true)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("Error"));
          }

          if(snapshot.connectionState == ConnectionState.waiting) {
            return  Padding(
              padding: const EdgeInsets.only(top: 6,bottom: 6),
              child: Center(child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                
                children: [
                  SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(color: Colors.lightBlue,)),

                    SizedBox(width: 6,),
                  Text("Loading", style: GoogleFonts.lato(fontSize: 14, fontWeight: FontWeight.w400)),

                ],
              )),
            );
          }      
          if(snapshot.data!.docs.isNotEmpty){
          
          return ListView.builder(
            itemCount: snapshot.data!.size,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (BuildContext context, index) {
            DocumentSnapshot ds = snapshot.data!.docs[index];
              return 
              postComment(postComment: ds["comment"], profileName: "Alok", context: context, blockSizeHorizontal: width, uid: ds["commentUID"], time: ds["time"], postID: ds["postID"],commentId: ds["commentID"]);
          }
        );
      }else{
            return Center(
              child: Container(
                padding: const EdgeInsets.fromLTRB(0, 6, 0, 6),
                child: Text("No comments yet!", style: GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.w400)),
              ),
            );
          }
    }
  ); 
}


// build comment details
Widget buildCommentdetails(BuildContext context, uid)=>
  StreamBuilder(
  stream: FirebaseFirestore.instance.collection('userData').where("uid",isEqualTo: uid).snapshots(),
  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    if (!snapshot.hasData) {
      return const Center(
        child: Text(""),
      );
    } else {
      return    Row(
      children: snapshot.data!.docs.map(
      (DocumentSnapshot document){
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                String name = data["name"];
                String about = data["about"];
                String image = data["image"];
                String joined = data["joined"];
                String Location = data["Location"];
                String UserName = data["UserName"];
                String Dob = data["Dob"];
                String uid = data["uid"];
                List Artists = data["favouriteArtists"];
                List Feed = data["Feed"];
                bool isVerified = data["isVerified"];
            return Row(
              children: [
                Column(
                  crossAxisAlignment : CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: (){
                          Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft,child: profile(
                            uid: uid,
                            name: name,
                            image: image,
                            joined: joined,
                            isVerified: isVerified,
                            about: about,
                            favouriteArtists: Artists, DOB: Dob,
                            Location: Location,
                            username: UserName,
                            
                            )));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 4, right: 4),
                        child :

                        image==""?Container(
                          height: 34,
                          width: 34,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.blue.shade300,
                            image: DecorationImage(
                                        image: AssetImage("assets/images/splash.png"),
                                        fit: BoxFit.cover,
                                      ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.4),
                                spreadRadius: 3,
                                blurRadius: 6,
                              ),
                            ],
                          ),
                          
                        ):

                         Container(
                          height: 34,
                            width: 34,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.blue.shade300,
                            ),
                            // color: Colors.blue.shade300,


                           child: CachedNetworkImage(
                                    imageUrl: image,
                                    imageBuilder: (context, imageProvider) =>
                           Container(
                            height: 34,
                            width: 34,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.blue.shade300,
                              image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover,
                                        ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.4),
                                  spreadRadius: 3,
                                  blurRadius: 6,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                    ),
                  ],
                ),
                SizedBox(height: 4,),
                Text(name,
                  style: GoogleFonts.lato(textStyle:  TextStyle(fontWeight: FontWeight.w500))),
                  Padding(
                    padding: const EdgeInsets.only(left: 2),
                    child: isVerified== true ?
                    const Icon(Icons.verified, color: Colors.blue,size: 26,) : const Text(""),
                  )
              ],
            );
          }
        ).toList()
      ); 
    }
  }
);