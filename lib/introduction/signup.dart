import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:page_transition/page_transition.dart';
import 'package:chillx/home/Home.dart';
import 'package:chillx/introduction/createProfile.dart';
import 'package:chillx/support/message.dart';
import 'package:url_launcher/url_launcher.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final subtitle = "Recommend your favourite content with others";
  late var loading = false;
  final buttonStyle = GoogleFonts.ubuntu(fontSize: 26, fontWeight: FontWeight.w400);
  final s1 = const SizedBox(height: 10,);
  final s2 = const SizedBox(height: 4,);
  
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
      )
    );  
  }


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: Colors.lightBlue,
        body: SafeArea(
          bottom: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: 230,
                height: 230,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/splash.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              const SizedBox(
                height: 75,
              ),

              Container(
                width: double.infinity,
                height: 400,
                  padding: const EdgeInsets.fromLTRB(2, 40, 2, 6),
                  decoration: const BoxDecoration(
                      color: Color(0xffffffff),
                      borderRadius: BorderRadiusDirectional.only(
                          topStart: Radius.circular(45),
                          topEnd: Radius.circular(45))),
                  child: signInModal(context,size)),
        ],
      ),
    )
  );
}



Column signInModal(BuildContext context, size) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      
      RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: "Welcome ",
              style: GoogleFonts.ubuntu(
                textStyle:  const TextStyle(
                  color: Colors.black,
                  fontSize: 38,
                  fontWeight: FontWeight.w400
                  ))),

                          
            TextSpan(
              text: "To ",
              style : GoogleFonts.ubuntu(
              textStyle:  const TextStyle(
                color: Colors.black,
                fontSize: 32,
                fontWeight: FontWeight.w400))),


            TextSpan(
              text: "Chirkut",
              style : GoogleFonts.ubuntu(
              textStyle: const TextStyle(
                color: Colors.lightBlue,
                fontSize: 32,
                fontWeight: FontWeight.w600
                ))),
                ])),
      
      
            Text("Recommend your Favourite content with others", style: GoogleFonts.lato(color: Colors.grey),),

            const SizedBox(height: 30,),

            Container(
              height: 50,

              width: 350,

              color: Colors.transparent,

              child: ElevatedButton(
                style: ElevatedButton.styleFrom(shape: const StadiumBorder(), backgroundColor: Colors.lightBlue),

              onPressed: () async {
                setState(() {
                  loading = true;
                });
                googleSignIn(context).then((value) {setState(() {
                  loading==false;
                }); }).onError((error, stackTrace) => message(message: "Try again", bgcolor: Colors.red,txtcolor: Colors.white));
                await Future.delayed(const Duration(seconds: 20));
              },

              child: (loading)
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 1.5,
                          ))
                      : Text('Sign up with Google', style: buttonStyle,),
              ),
            ),

            const SizedBox(height: 10,),


            RichText(
              text:  TextSpan(
                children: [
                  TextSpan(
                    style: GoogleFonts.ubuntu(textStyle: const TextStyle(color: Colors.grey,fontSize: 16),),
                    text: "       By Continuing You Agree To Our",
                  ),
                  
                  TextSpan(
                    style: GoogleFonts.ubuntu(textStyle:const  TextStyle(color: Colors.blueAccent,fontSize: 18),),
                    text: "\n Terms of Services",
                    recognizer:  TapGestureRecognizer()..onTap = () {
                      _launchURL(url: "https://pages.flycricket.io/chirkut-user/terms.html");
                      },
                  ),

                  TextSpan(
                    style: GoogleFonts.ubuntu(textStyle:  const TextStyle(color: Colors.grey,fontSize: 16),),
                      text: " & ",
                  ),

                  TextSpan(
                    style: GoogleFonts.ubuntu(textStyle: const TextStyle(color: Colors.blue,fontSize: 18),),
                      text: "Privacy Policy",
                      recognizer:  TapGestureRecognizer()..onTap = () {
                      _launchURL(url: "https://pages.flycricket.io/chirkut-user/privacy.html");
                    },
                  ),
                ]
              )
            ),
          ],
        );
      }

    
    
    
  
void _launchURL({required  url}) async {
  String _url = url;

   // ignore: deprecated_member_use
   if (await canLaunch(_url)) {
      // ignore: deprecated_member_use
      await launch(_url);
    } else {
      throw 'Could not launch $_url';
    }     
}


void showloading(){
  showDialog(
    context: context,
    builder: (BuildContext context) => const CupertinoActivityIndicator(
      color: Colors.white,
      animating: true,
      radius: 16
      )
    );
  }
}

Future getDoc(BuildContext context) async{
  final user = FirebaseAuth.instance.currentUser!;
  var a = await FirebaseFirestore.instance.collection('userData').doc(user.uid).get();

  if(a.exists){
  message(message: "Profile fetched", bgcolor: Colors.black, txtcolor: Colors.white);
  Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.rightToLeft, child : Home()));
}

  if(!a.exists){
  Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.rightToLeft, child : createProfile()));
    }
}

Future googleSignIn(BuildContext context) async{
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  GoogleSignInAccount? _googleSignInAccount = await _googleSignIn.signIn();
  var _authentication = await _googleSignInAccount?.authentication;
  var _credential = GoogleAuthProvider.credential(
    idToken: _authentication!.idToken,
    accessToken: _authentication.accessToken
  );
  User user = (await _auth.signInWithCredential(_credential)).user!;
  getDoc(context);
  return user;
}



// signout
Future googleSignOut(BuildContext context) async{
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  await _googleSignIn.signOut().then((value) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const Signup()));  
  }).then((value) => message(message: "Logout successful", bgcolor: Colors.green, txtcolor: Colors.white)).onError((error, stackTrace) => message(message: "Logout Failed", bgcolor: Colors.red, txtcolor: Colors.white));
}




class Customshape extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    double height = size.height;
    double width = size.width;
  
    var path = Path();
    path.lineTo(0, height-50);
    path.quadraticBezierTo(width/2, height, width, height-50);
    path.lineTo(width, 0);
    path.close();
    return path;
  }
  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }  
}


class shape extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    double height = size.height;
    double width = size.width;
  
    var path = Path();
    path.lineTo(0, height-60);
    path.quadraticBezierTo(width/2, height-120, width, height-50);
    path.lineTo(width,0);
    path.close();
    return path;
  }
  
  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
