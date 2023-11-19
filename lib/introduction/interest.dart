import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:chillx/home/Home.dart';
import 'package:chillx/support/message.dart';

class Interest extends StatefulWidget {
  final name;
  final about;
  final username;
  final location;
  final artist;
  final DOB;


  final String? image;
  Interest({Key? key, required this.name,required this.about, required this.image, this.username, this.location, this.artist, this.DOB }) : super(key: key);

  @override
  State<Interest> createState() => _InterestState();
}

class _InterestState extends State<Interest> {
  late List categoryList = [];
  final doc = FirebaseFirestore.instance.collection('customerServices').doc("Category").snapshots();
  ScrollController mainPage = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
      SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
          child : category1()
        ),
      ) 
    );
  }

Widget category1() => StreamBuilder(
  stream: FirebaseFirestore.instance.collection('customerServices').where("doc", isEqualTo: "category").snapshots(),
  builder : (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    if (!snapshot.hasData) {
      return const Text('');
        } else {
          return ListView.builder(
            controller: mainPage,
            itemCount: snapshot.data!.size,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, index) {
              DocumentSnapshot ds = snapshot.data!.docs[index];
              List all = ds["Category"];
              categoryList = ds["Category"];
              return Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 200,
                    width: 400,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: const DecorationImage(image: AssetImage("assets/images/1024.png"), fit: BoxFit.cover,))
                    ),
                    const SizedBox(height: 20,),

                    RichText(
                      text:  TextSpan(
                        children: [
                          TextSpan(
                            style: GoogleFonts.ubuntu(textStyle: const TextStyle(color: Colors.black,fontSize: 40),),
                            text: "Your ",
                          ),

                          TextSpan(
                            style: GoogleFonts.ubuntu(textStyle: const TextStyle(color: Colors.blue,fontSize: 40),),
                            text: "Feed",
                          ),
                        ]
                      )
                    ),

                    const SizedBox(height: 10,),

                    Text("Select atleast 6 category for your feed, you can edit it later.", style: GoogleFonts.lato(),),

                    const SizedBox(height: 10,),

                    GridView.builder(
                      controller: mainPage,
                      shrinkWrap: true,
                      itemCount: all.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 20,
                        childAspectRatio: 3
                      ),
                      itemBuilder: (context, int index) => container(list: all, index1: index),
                    ),
                  
                    const SizedBox(height: 20,),

                    createAccount()

              ],
            );
          },
        );
      }
    },
  );



createProfilePage({ required feed, })async{
  // final joined = DateFormat.yMMMEd().format(DateTime.now());
  final joined = "";
  final user = FirebaseAuth.instance.currentUser!;
  final userdata = FirebaseFirestore.instance.collection("userData").doc("${user.uid}");
  final String? image;

  final artists = widget.artist.toString();

  final List art = artists.split(",");



  await userdata.set({
    "about" : widget.about,
    "image" : widget.image,
    "isVerified" : false,
    "joined" : joined.toString(),
    "name" : widget.name,
    "userEmail" : user.email,
    "uid" : user.uid,
    "Location" : widget.location,
    "UserName" : widget.username,
    "Dob": widget.DOB.toString(),
    "favouriteArtists" : art, 
    "Feed": yourList,
    "Books" : [],
    "Movie" : [],
    "songs" : [],
    "Followers" : [],
    "Following" : [],
    "Instagram" : "",
    "Youtube" : "",
    "Facebook" : "",
    "Twitter" : "",
  }).then((value) {

    message(message: "Profile created",  bgcolor: Colors.green,txtcolor: Colors.white);
    Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.rightToLeft, child : Home()));
    }).onError((error, stackTrace) => message(message: "error while creating profile", bgcolor: Colors.red,txtcolor: Colors.white));
}


final yourList = [];
Widget container({required list, required int index1}){ 
  return 
  InkWell(
  onTap: (){
    bool found = yourList.contains(categoryList[index1]);


    if(found){
      yourList.remove(categoryList[index1]);
      message(message: "${categoryList[index1]} removed", bgcolor: Colors.red,txtcolor: Colors.white);
      }
      else{
        yourList.add(
        categoryList[index1]
      );

      message(message: "${categoryList[index1]} Added", bgcolor: Colors.green,txtcolor: Colors.white);
    }
  },

  child: Container(
    child : ListTile(
    title: Text(
      list[index1],
        style : GoogleFonts.lato(
          textStyle: const TextStyle(
            color: Colors.lightBlue),
        ),
      )
    ),

    decoration: BoxDecoration(
      border: Border.all(
        color: Colors.lightBlue,              
        width: 1,
      ),
      borderRadius: BorderRadius.circular(4)
        ),
      ),
    );
  }


Widget createAccount()=>
  InkWell(
    onTap: (){
      var count = yourList.length;
        print(yourList);
        int less = 5-count;
        int less1 = count - 6;
          count >= 5 && count <= 7 ? 
        createProfilePage(feed: yourList) : 
        count >= 7 ?
        message(message: "remove $less1 category", bgcolor: Colors.red,txtcolor: Colors.white): message(message: "add $less more", bgcolor: Colors.red, txtcolor: Colors.white);
    },
    child: Container(
      color: Colors.lightBlue,
      width: double.infinity,
      height: 40,
      child: Center(
        child: Text("Next",style: GoogleFonts.lato(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 24),
        ),
      )
    )
  );
}