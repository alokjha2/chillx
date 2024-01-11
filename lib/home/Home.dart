
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:comment_tree/comment_tree.dart';
// import 'package:comment_tree/widgets/comment_tree_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:page_transition/page_transition.dart';
// import 'package:paginate_firestore/paginate_firestore.dart';
import 'package:chillx/appbar/notifications.dart';
import 'package:chillx/appbar/search.dart';
import 'package:chillx/home/showPools.dart';
import 'package:chillx/home/showPost.dart';
import 'package:chillx/introduction/createProfile.dart';
import 'package:chillx/introduction/signup.dart';
import 'package:chillx/pool/poolPage.dart';
import 'package:chillx/post/createPost.dart';
import 'package:chillx/post/postComments-logic.dart';
import 'package:chillx/post/showComments.dart';
import 'package:chillx/support/exitApp.dart';
import 'package:chillx/support/message.dart';
import 'package:chillx/useraccount/Account.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  // final user = FirebaseAuth.instance.currentUser!;
  ScrollController controller = ScrollController();
  final _restaurants = [];
  var _nomore = false;
  var _isFetching = false;
  late DocumentSnapshot _lastDocument;

  // @override
  // void initState() {
  //   getDoc(context);
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.width / .2;
    return WillPopScope(
      onWillPop: () { return showExitDialog(context); },
      child: Scaffold(
        appBar: AppBar(
          title: Text("chillx", style: GoogleFonts.ubuntu(textStyle: TextStyle(fontSize: 26)),),
          actions: [

            IconButton(
              iconSize: 25,
              onPressed: (){
              }, icon: Icon(Icons.search)),


            IconButton(
              iconSize: 25,
              onPressed: (){
              Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, alignment: Alignment.bottomCenter, child: const Notifications(),));
            }, icon: const Icon(Icons.notifications)),


            // IconButton(
            //   iconSize: 35 ,
            //   onPressed: (){
            //   Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft, alignment: Alignment.bottomCenter, child: const AccountPage(),));
            // }, icon: Icon(Icons.account_circle_rounded)),
        ],
      ),



      body : RefreshIndicator(
        triggerMode: RefreshIndicatorTriggerMode.onEdge,  
        displacement: 200,
        backgroundColor: Colors.white,
        color: Color(0xFF03A9F4),
        onRefresh: 
          () async {
    await Future.delayed(Duration(milliseconds: 1500));
    setState(() {
    });
        },
        child: 

        SingleChildScrollView(
          child: Column(children: [
            buildPools(),
            // userInterest()
          ],),
        )
        
      ),




       
      // add recommendations // post 
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Colors.lightBlueAccent,
      //   onPressed: () {
      //     Navigator.push(context, PageTransition(type: PageTransitionType.rightToLeft,child: const Upload()));
      //   },
      //   child : const Icon(Icons.add, size: 30),
      //   ),
        ),
    );
  }


// Widget paginatePost({required feedList})=>
//   PaginateFirestore(
//     physics: NeverScrollableScrollPhysics(),//add this line
//     shrinkWrap: true,
//           itemBuilderType:
//         PaginateBuilderType.listView, //Change types accordingly
//           itemBuilder: (context, documentSnapshots, index) {
//             final data = documentSnapshots[index].data() as Map?;
//             return 
//             post(ds: data);
//           },
//           // orderBy is compulsory to enable pagination
//           query: FirebaseFirestore.instance.collection('Post').where("category", arrayContainsAny: feedList,).orderBy("createdOn",descending: true),
//           // .where("category", arrayContainsAny: ["Books","songs","Podcast"],),
//           itemsPerPage: 5,
//           // to fetch real-time data
//           isLive: true,
//         );


Widget userInterest(){
  return 
StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('userData')
              .doc(user.uid)
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Text("");
            }
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
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

            return 
            Text("hello");
            // paginatePost(feedList: Feed);
      });
}


// check wheter profile exists or not
  Future getDoc(BuildContext context) async{
  final user = FirebaseAuth.instance.currentUser!;
   var a = await FirebaseFirestore.instance.collection('userData').doc(user.uid).get();
   if(a.exists){

   }

   if(!a.exists){
    
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=> createProfile()));
    // createProfile();
     }
  }






// post widget
post({required ds}){
  final _mediaQueryData = MediaQuery.of(context);
    final screenWidth = _mediaQueryData.size.width;
    final screenHeight = _mediaQueryData.size.height;
    final blockSizeHorizontal = screenWidth/1.2;
    final showcommentswidth = screenWidth/1.5;
    final blockSizeVertical = screenHeight/100;

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
                    ]
                  ),
                ],
              ),
            ],
          ),

            const SizedBox(height: 10),

            Text(
              ds['title'], 
              style: GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.w400),maxLines: 3,),

            const SizedBox(height: 14),

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
}

}
  
  