import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:chillx/home/Home.dart';
import 'package:chillx/introduction/signup.dart';
import 'package:chillx/support/loading_dialog.dart';
import 'package:chillx/useraccount/listaccount/about_us/contact_us.dart';
import 'package:chillx/useraccount/listaccount/company/privacy.dart';
import 'package:chillx/useraccount/listaccount/company/terms_con.dart';
import 'package:chillx/useraccount/listaccount/improvement/feedback.dart' as a;
import 'package:chillx/useraccount/listaccount/improvement/report_bug.dart';
import 'package:chillx/useraccount/listaccount/improvement/request_feature.dart';
import 'package:chillx/useraccount/listaccount/profile/profile.dart';
import 'package:share_plus/share_plus.dart';
// import 'package:store_redirect/store_redirect.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {

  final horizontalspace = const SizedBox(height: 8,);
  final line = const  Divider();
  final user = FirebaseAuth.instance.currentUser!;
  // ignore: non_constant_identifier_names
  final SubCategoryStyle = GoogleFonts.lato();
  final headingStyle = GoogleFonts.roboto();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Account")
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [

          horizontalspace,
          buildImage(),
          horizontalspace,
          horizontalspace,
          
          Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              children:  [
                // Heading
                heading1(text: "IMPROVEMENT"),

                // subcategory
                Column(
                  children: [
                    // feedback
                    subcategory(text: "Feedback", icon: const Icon(Icons.feedback), ontap: const a.Feedback()),
                    line,
                    // request a feature
                    subcategory(text: "Request A Feature", icon: const Icon(Icons.face_retouching_natural_outlined), ontap: const RequestFeature()),
                    line,
                    // report bugs
                    subcategory(text: "Report Bug", icon: const Icon(Icons.bug_report_outlined), ontap: const Report()),
                  ],
                )
              ],
            ),
          ),
          horizontalspace,
          
          Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              children:  [
              heading1(text: "Help"),

                Column(
                  children: [
                    ontap_subcategory(icon: const Icon(Icons.share_rounded), text: "Tell Friend", ontap: ()=> Share.share("Hey, I am using chirkut, join it & share your recommendations related to movies, books, songs, documentary to other", subject: "chirkut is available on play store")),
                    line,
                    // ontap_subcategory(icon: const Icon(Icons.star_rate_rounded), text: "Rate Us", ontap: ()=>StoreRedirect.redirect(androidAppId : "com.chirkut.community"),
                  // ),
                ],
              )
            ],
          ),
        ),


          horizontalspace,
          
          Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              children:  [
                // Heading
                heading1(text: "COMPANY"),
                
                // subcategory
                Column(
                  children: [
                    // Terms & Conditions
                    subcategory(text: "Terms & Condition", icon: const Icon(Icons.privacy_tip_sharp), ontap: Termsandcondition()),
                    line,
                    // Privacy policy
                    subcategory(text: "Privacy Policy", icon: const Icon(Icons.policy_outlined), ontap: Privacy()),
                    
                  ],
                )
              ],
            ),
          ),

          horizontalspace,

          Card(
            clipBehavior: Clip.antiAlias,
            child: Column(
              children:  [
                // Heading
                heading1(text: "ABOUT US"),
                
                // subcategory
                Column(
                  children: [
                    // About App
                    subcategory(text: "About App", icon: const Icon(Icons.app_settings_alt_rounded), ontap: Contact(title: "About App", link: "https://alokj4702.wixsite.com/chirkutcom")),
                    line,
                    // Contact Us
                    subcategory(text: "Contact Us", icon: const Icon(Icons.contact_page_sharp), ontap: Contact(title: "Contact Us", link: "https://alokj4702.wixsite.com/chirkutcom")),
                  ],
                )
              ],
            ),
          ),
          horizontalspace,

          Text("App Version 1.0.2", style: SubCategoryStyle,),


        // logout widget
        Align(
          alignment: Alignment.bottomCenter,
          child: 
          TextButton.icon(icon: const Icon(Icons.login, color: Colors.redAccent,),onPressed: (){
            Navigator.of(context).pop();
              logout();
            },label: Text("Sign out" , style:GoogleFonts.ubuntu(textStyle: TextStyle(color: Colors.redAccent),)
          ),
          )
          ),    
          horizontalspace,
        ]
      ),
    );
  }


// common widget for heading
Widget heading1({required text}) => ListTile(title: Text(text, style: headingStyle,));


// common widget for subcategory 
Widget subcategory({required text, required icon, required ontap})=> ListTile(
  leading: icon,
  title:Text(text, style: SubCategoryStyle,),
  onTap: (){
    Navigator.push(context, PageTransition(type: PageTransitionType.fade, alignment: Alignment.bottomCenter, child : ontap));
  },
);



// commmon widget for one click subcategory
Widget ontap_subcategory({required icon, required text, required ontap}) => ListTile(
  leading: icon,
  title:Text(text, style: SubCategoryStyle,),
  onTap: ontap
);



Widget buildImage()=> StreamBuilder<DocumentSnapshot>(
  stream: FirebaseFirestore.instance.collection('userData').doc(user.uid).snapshots(),
  builder : (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
    if (!snapshot.hasData) {
      return Container(
        height: 170,
        width: 170,
        child: Center(child: CircularProgressIndicator(color: Colors.blue)));
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
            return Column(
              children: [
                Container(
                  height: 170,
                  width: 170,
                  decoration: BoxDecoration(
                  shape: BoxShape.circle,
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

                child: CachedNetworkImage(
                  imageUrl: image,
                  imageBuilder: (context, imageProvider) =>
                    CircleAvatar(
                      backgroundImage: imageProvider,
                      // NetworkImage(image),
                        radius: 80,
                        backgroundColor: Colors.lightBlueAccent,
                      ),
                    ),
                  ),

                horizontalspace,

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      name,style:GoogleFonts.lato(textStyle:const TextStyle(fontWeight: FontWeight.w500, fontSize: 24)),),

                    Padding(
                      padding: const EdgeInsets.only(left: 3),
                      child: isVerified == true ? Icon(Icons.verified, color: Colors.blue, size: 32,): Text(""),
                    )
                  ],
                ),

                Padding(
                    padding: const EdgeInsets.fromLTRB(110, 0, 110, 0),
                  child: TextButton(
                    child: Text("View Profile",style: GoogleFonts.ubuntu(color: Colors.blue,textStyle: const TextStyle(),),),
                    onPressed: (){
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
                  ),
                ),
              ],
            );
          }
        );



// confirmation before logout 

void logout(){
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) => 
      CupertinoAlertDialog(  
        title:  Text("Logout", style: SubCategoryStyle,),
        content: Text("Are you sure you want to Logout ??", style: SubCategoryStyle,), 
        actions: [
          CupertinoDialogAction(
            child: Text("No", style: SubCategoryStyle,),
            onPressed: (){
              Navigator.of(context).pop();
                }
              ),
          CupertinoDialogAction(
            child: Text("Yes", style: SubCategoryStyle,),
            onPressed: (){
              Navigator.of(context).pop(Home());
              showDialog(
            context: context,
            builder: (context) {
              Future.delayed(
                Duration(seconds: 1), () {
                    Navigator.of(context).pop(true);
                    googleSignOut(context);
                  });
                  return loading(text: "Logging out..",);
                }
              );
            }
          )
        ],  
      )
    );
  }
}