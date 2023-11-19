import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:readmore/readmore.dart';
import 'package:chillx/post/createPost.dart';
import 'package:chillx/post/postComments-logic.dart';
import 'package:chillx/post/showComments.dart';
import 'package:chillx/support/message.dart';
import 'package:chillx/useraccount/listaccount/profile/profile.dart';


final user = FirebaseAuth.instance.currentUser!;
final style = GoogleFonts.lato();
final TextEditingController updatecommentController = TextEditingController();

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


Widget time({required tim}){
  DateTime time1 = DateTime.parse(tim);
  final realTime = convertToAgo(time1); 
  return Text(realTime, style: GoogleFonts.lato(fontSize: 14, color: Colors.grey),);
}
// show post   
Widget buildPosts({required List feed, required controller, required BuildContext context}) {
    final feedList = feed;
    final _mediaQueryData = MediaQuery.of(context);
    final screenWidth = _mediaQueryData.size.width;
    final screenHeight = _mediaQueryData.size.height;
    final blockSizeHorizontal = screenWidth/1.2;
    final showcommentswidth = screenWidth/1.5;
    final blockSizeVertical = screenHeight/100;

  return 
   StreamBuilder(
      stream: FirebaseFirestore.instance.collection('Post').where("category", arrayContainsAny: feedList,)
      // .orderBy('createdOn', descending: true)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ListView.builder(
            controller: controller,
            itemCount: snapshot.data!.size,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (BuildContext context, index) {
              DocumentSnapshot ds = snapshot.data!.docs[index];
              return Padding(
                padding: const EdgeInsets.only(left: 15, top: 10, bottom: 10, right: 15),
                child: Container(
                  padding: const EdgeInsets.fromLTRB(4, 4, 4, 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.grey.shade200
                            : Colors.grey.shade800),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              buildPostdetails(context, ds["uid"]),
                            ],
                          ),

                          
                          Row(
                            children: [

                              time(tim: ds["time"]),

                              ds["uid"] == user.uid?
                              PopupMenuButton<int>(
            onSelected: (item)=> onSelected(context, item, ds["postId"],ds),
            itemBuilder: (context) => [
              PopupMenuItem(child: Text("Edit", style: style,),
                value: 1,
              ),
            PopupMenuDivider(height: 2,),
            PopupMenuItem(
              child: Text("Delete", style: style,),
            value: 2,
            ),
            PopupMenuDivider(height: 2,),
            PopupMenuItem(
              child: Text("caption", style: style,),
            value: 4,
            )
          ]
          )
          
           : PopupMenuButton<int>(
            onSelected: (item)=> onSelected(context, item, ds["postId"],ds),
            itemBuilder: (context) => [
              PopupMenuItem(child: Text("Report", style: style,),
                value: 3,
              ),
            PopupMenuDivider(height: 2,),
              PopupMenuItem(
              child: Text("caption", style: style,),
            value: 4,
            )
            
          ]),

                          ],
                        ),
                      ],
                    ),
                      const SizedBox(height: 10),
                      Text(
                        ds['title'], 
                        style: GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.w400),maxLines: 3,),
                      const SizedBox(height: 14),
                      // Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [

                          Expanded(
                            child: ExpansionTile(
                              expandedCrossAxisAlignment: CrossAxisAlignment.start,
                           trailing: Text(""),
                           children:[
                            

                            Container(
                      width: blockSizeHorizontal,
                      height: 60,
                      decoration: BoxDecoration(
                        // color: 
                        color: Colors.lightBlue.shade50,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 7, left: 6, right: 6),
                        child: TextField(
                          onSubmitted: (value) {
                          addComment(postId: ds["postId"], title: title.text, uid: user.uid, time: DateTime.now().toString(), timeStamp: FieldValue.serverTimestamp(), controller: title);
                          },
                          
                          controller: title,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Write a public comment", 
                  hintStyle: GoogleFonts.lato(fontSize: 14)
                          ),
                        ),
                      ),
                    ),
                    Text("Press enter to post", style: GoogleFonts.lato(color: Colors.grey),),
                    SizedBox(height: 4,),
                            Column(children: 
                            List<Widget>.generate(
                             1,
                             (int index) =>
                              showComments(
                                postId: ds["postId"],
                                width: showcommentswidth
                                )
                           ),),],
                           title: 
                           Text("comments")

                        )
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
  }
);
}



void onSelected(BuildContext context, int item, id, ds ){
        switch (item){

          // edit      
          case 1:
          editpost(context: context, id:  id);
          break;


          // delete
          case 2:
          deletePost(id: id);
          break;

          // report
          case 3:
          reportPost(id:id);

          break;

          case 4:
          modal(context: context, ds: ds, );
          break;

        }
      }


// report post 
void reportPost({required id}) {
    DocumentReference reference =
        FirebaseFirestore.instance.collection('customerServices').doc("reported_post");
      reference.get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
          reference.set({
            'reportedPost': FieldValue.arrayUnion([id])
          }, SetOptions(merge: true)).then((value) => message(message: "post reported", bgcolor: Colors.green,txtcolor: Colors.white));
        }
      // }
       else {
        message(message: "post does not exist.", bgcolor: Colors.red,txtcolor: Colors.white);
      }
    });
  }




// delete post
deletePost({required id})async{
final post = FirebaseFirestore.instance.collection("Post").doc(id);
post.delete().then((value) => message(message: "post deleted", bgcolor: Colors.green,txtcolor: Colors.white));
}


updatePost({required id})async{
final post = FirebaseFirestore.instance.collection("Post").doc(id);

post.update({
  "title": updateposttext.text,
  "edited": true
}).then((value) => message(message: "post updated", bgcolor: Colors.green,txtcolor: Colors.white));
}



final TextEditingController updateposttext = TextEditingController();

editpost({required BuildContext context, required id}){
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) => AlertDialog(
      title: Text("Edit",),
      content: TextFormField(
          // maxLength:,
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
          // hintText: "",
          // hintStyle: font,
          fillColor: Colors.grey[40],
        ),
          controller: updateposttext,          
        ),

      actions: <Widget>[
        TextButton(
          onPressed: (){
            updatePost( id: id);

            Navigator.of(context).pop();
          },
          child: Text("Save"),)
          ]
        )
      );
    }








// show description or caption
modal({required BuildContext context, ds}) async {
    showModalBottomSheet(

      context: context,
      isScrollControlled: true,
      // isDismissible: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: ((context, setState) {
            return DraggableScrollableSheet(
              snap: false,
              expand: true,
              initialChildSize: 0.44,
              minChildSize: 0.2,
              maxChildSize: 0.9,
              builder: (context, scrollController) {
                return Container(
                  // width: 300,
                  decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),color: Colors.white),
                  child: SingleChildScrollView(
                    physics: const ScrollPhysics(),
                    controller: scrollController,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20,),
                          
                          Container(
                            width: MediaQuery.of(context).size.width/.5,
                            decoration: BoxDecoration(
                      color: Colors.lightBlue.shade50,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                ds['title'],
                                style: const TextStyle(
                                    fontWeight: FontWeight.w400, fontSize: 20, color: Colors.black),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          const SizedBox(
                            height: 10,
                          ),

                          Row(children: [
                            Text("Category : "),
                            Text(ds["category"][1])

                          ],),
                          const SizedBox(
                            height: 10,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
                            // mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("Caption : "),
                              ds["caption"] == ""? Text("No caption") : 
                        ReadMoreText(
                              ds["caption"].toString(),
  trimLines: 5,
  colorClickableText: Colors.pink,
  trimMode: TrimMode.Line,
  trimCollapsedText: 'Read more',
  trimExpandedText: 'Show less',
  moreStyle: GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.w400,color: Colors.red),
  lessStyle: GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.w400,color: Colors.red),

),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
Row(children: [
  Text("Link : "),
ds["Link"] == ""? Text("No link available") : Text(ds["Link"].toString(),style: GoogleFonts.lato(color: Colors.blue),)

],)
                          
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }),
        );
      },
    );
  }

  

// post details like image , verification , name , etc
Widget buildPostdetails(BuildContext context, uid)=>
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
                          // child: Center(child: Text(name[0], style: GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.w700),)),
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