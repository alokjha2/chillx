




import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; 
import 'package:page_transition/page_transition.dart';
import 'package:chillx/useraccount/listaccount/profile/edit_profile.dart';

class profile extends StatefulWidget {

  final String uid;
  final String image;
  final String name;
  final bool isVerified;
  final String joined;
  final String Location;
  final String DOB;
  final String username;
  final List favouriteArtists;
  final String about;
  profile({Key? key, required this.favouriteArtists, required this.uid, required this.image,required this.isVerified, required this.name, required this.joined, required this.about, required this.Location, required this.DOB, required this.username}) : super(key: key);

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> {
  
  final user = FirebaseAuth.instance.currentUser!;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final CollectionReference post = FirebaseFirestore.instance.collection("User-Personal-Data");
  final size = SizedBox(height: 20,);
  final size1 = SizedBox(height: 10,);
  final headingStyle = GoogleFonts.ubuntu(textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w500));
  final style = GoogleFonts.lato(fontSize: 17);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        actions: [

          widget.uid==user.uid?
          PopupMenuButton<int>(
            onSelected: (item)=> postSelect(context, item,),
            itemBuilder: (context) => [


              PopupMenuItem(
                child: Text("Edit",style: style,),
                value: 1,
              ),
            PopupMenuDivider(height: 2,),
            PopupMenuItem(
              child: Text("Share", style: style,),
            value: 2,
            ),
            
          ]
          )
          
           : PopupMenuButton<int>(
            // onSelected: (item)=> onSelected(context, item, ds["postId"],ds),
            itemBuilder: (context) => [
              PopupMenuItem(child: Text("Report",style: style,),
                value: 3,
              ),
            PopupMenuDivider(height: 2,),
              PopupMenuItem(
              child: Text("Share",style: style,),
            value: 4,
            )
          ]),



          ]
        ),


      body: profile(image: widget.image,name: widget.name, description: widget.about, joined: widget.joined, uid: widget.uid, isVerified: widget.isVerified, dob: widget.DOB, location: widget.Location, username: widget.username, )

  );
}
  


Widget profile({required image, required name, required description,required joined,required uid,required isVerified, required location , required dob, required username}) => 
          Stack(
            alignment: Alignment.centerLeft,
            children: <Widget>[
            ListView(
              children: <Widget>[
                Container(
                  height: 200.0,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/banner.jpg"),
                      fit: BoxFit.cover,
                      filterQuality: FilterQuality.high,
                      alignment: Alignment.center
                    ),
                  ),
                ),
              ],
            ),


            // Profile image
            Positioned(
              top: 120.0, // (background container size) - (circle height / 2)
              left: 20,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  InkWell(
                    onTap: (){
                      print("abc");
                    },
                    child: CachedNetworkImage(
                      imageUrl: image,
                      imageBuilder: (context, imageProvider) =>        
                        Container(
                          height: 130,
                          width: 130,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover, 
                              filterQuality: FilterQuality.high,
                              alignment: Alignment.center
                            ),
                              shape: BoxShape.rectangle,
                              border: Border.all(
                                width: 2,
                                color: Colors.white,
                              ),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.lightBlueAccent,
                                  spreadRadius: 3,
                                  blurRadius: 6,
                  
                                ),
                              ],
                            ),
                          ),
                        ),
                  ),

                    size1,

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:  [
                        Text(
                          name,
                          style : GoogleFonts.lato(
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 24
                              ),
                            ),
                          ),

                       
                          
                      size1,


                      isVerified == true? Icon(Icons.verified, color: Colors.blue,size: 29,): Text("")
                    ],
                  ),
                   Text(
                          "@$username",
                          style : GoogleFonts.lato(
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Colors.grey
                              ),
                            ),
                          ),


                  size,

                ],
              ),
            ),

            Positioned(
              top: 340,
              child: Container(
                width: double.maxFinite,
                child: 
                
                Column(
                  children: [
                    t1(title: "Joined on $joined", subtitle: joined, icon1: Icon(Icons.date_range, color: Colors.grey,)),
                    SizedBox(height: 10,),
                    widget.DOB == "" ? Text(""):
                    t1(title: "Born ${widget.DOB}", subtitle: joined, icon1: Icon(Icons.cake, color: Colors.grey,)),

                    SizedBox(height: 10,),
                    widget.Location == "" ? Text(""):
                    t1(title: "${widget.Location}", subtitle: joined, icon1: Icon(Icons.location_on_rounded, color: Colors.grey,)),
                  ],
                ),
                )),
           ],
        );
      }



void postSelect(BuildContext context, int item,){
        switch (item){


          case 1:
          break;


          case 2:
          break;

          case 3:
          break;

          case 4:
          break;

        }
      }


Widget t1({required title, required subtitle, required Icon icon1}) =>
Row(children: [
  Padding(
    padding: const EdgeInsets.only(
      left: 14, right: 4
    ),
    child: icon1,
  ),
 Text(title, style: GoogleFonts.lato(fontWeight: FontWeight.w400, fontSize: 18),),
],);

