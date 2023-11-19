import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:date_time_picker/date_time_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';
import 'package:chillx/home/Home.dart';
import 'package:chillx/introduction/interest.dart';
import 'package:chillx/support/message.dart';
import 'package:chillx/support/loading_dialog.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;




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

class createProfile extends StatefulWidget {
  createProfile({Key? key}) : super(key: key);

  @override
  State<createProfile> createState() => _createProfileState();
}

class _createProfileState extends State<createProfile> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController username = TextEditingController();
  final TextEditingController artist = TextEditingController();
  final TextEditingController DOB = TextEditingController();
  final TextEditingController location = TextEditingController();
  final s1 = const SizedBox(height: 20,);
  final s2 = const SizedBox(height: 10,);
  final s3 = const SizedBox(height: 4,);
  final user = FirebaseAuth.instance.currentUser!;
  bool isuploading = false;
  firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
  File? _photo;
  final ImagePicker _picker = ImagePicker();
  bool error = false;
  final ScrollController page = ScrollController();
  late String imgurl = "";
  bool loadingFeed = false;
  final style = GoogleFonts.ubuntu(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.black);
  final changeImage = GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.lightBlue);
  late String dob = "";
  final List favouriteArtists = [];



  @override
  Widget build(BuildContext context) {
  final TextEditingController name = TextEditingController(text: user.displayName);
  final TextEditingController description= TextEditingController(text: "At chirkut");
    return Container(
      decoration: BoxDecoration(
        color: Colors.lightBlue.shade400,
        // image: DecorationImage(image: AssetImage("assets/images/bubble.jpg",), fit: BoxFit.cover)
        ),

      child: Scaffold(
      backgroundColor: Colors.transparent,

      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 50,),
                  Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                      // image: DecorationImage(
                      //   image: NetworkImage(""),fit: BoxFit.cover, filterQuality: FilterQuality.high),
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
                        ),

                    s2,

                    Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: TextButton(onPressed: (){
                        _showPicker(context);
                      }, child:Text("select photo", style: changeImage,)),
                    ),


                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Name", style: style,),

                        s3,

                        field(controllerName: name, hinttext: "Profile's Name", error: "Name"),
                
                        s2,
                
                        Text("username", style: style,),

                        s3,

                        TextFormField(
                          controller: username,
                          decoration: InputDecoration(
                          hintText: "e.g @chirkut",
                            enabledBorder:const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(8)),
                            ),
                            focusedBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(8)),
                            ),
                          filled: true,
                          fillColor: Colors.grey[100],
                        ),

                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Please enter unqiue username';
                          }
                          return null;
                        },
                      ),
                      s2,

                      
                      Text("About you", style: style,),

                      s3,
                
                      TextFormField(
                        minLines: 2,
                        maxLines: 4,
                        controller: description,
                        decoration: InputDecoration(
                        hintText: "About you",
                          enabledBorder:const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                          focusedBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                          ),
                        filled: true,
                        fillColor: Colors.grey[100],
                      ),
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return 'Please enter description about you';
                          }
                          return null;
                        },
                      ),
                      s2,


                      Text("Favourite artists", style: style,),
                      s3,
                      TextField(
                        minLines: 2,
                        maxLines: 4,
                          controller: artist,
                          decoration: InputDecoration(
                          hintText: "e.g Justin bieber, Johhny depp",
                            enabledBorder:const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(8)),
                            ),
                            focusedBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(8)),
                            ),
                          filled: true,
                          fillColor: Colors.grey[100],
                        ),

                      ),
                      Text("use comma to seprate", style: TextStyle(color: Colors.black54),),
                      
                      s2,
                      Text("Location", style: style,),
                      s3,
                      TextField(
                          controller: location,
                          decoration: InputDecoration(
                          hintText: "Meerut, India",
                            enabledBorder:const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(8)),
                            ),
                            focusedBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(8)),
                            ),
                          filled: true,
                          fillColor: Colors.grey[100],
                        ),

                      ),
                      // s1,
                      
                      s2,
                      // DateTimePicker(
                      //   icon: Icon(Icons.date_range, color: Colors.black,),
                      //   decoration: InputDecoration(disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(8)))),
                      //   type: DateTimePickerType.date,
                      //   controller: DOB,
                      //   initialValue: '2005-03-26',
                      //   firstDate: DateTime(1980),
                      //   lastDate: DateTime(2017),
                      //   dateLabelText: 'Date Of Birth',
                      //   onChanged: (val) => print(val),
                      //   validator: (val) {
                      //     print(val);
                      //     return null;
                      //   },
                      //   onSaved: (val) {
                      //     setState(() {
                      //       dob = val!;
                      //     });
                      //   },
                      // ),


                      
                    ],
                  ),
            
            
                    s1,
                  
            
                    Container(
                      width: 200,
                      height: 40,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          // shape: StadiumBorder(),
                          backgroundColor: Colors.white, 
                          textStyle: TextStyle(color: Colors.lightBlue)
                          // textStyle: changeImage
                        ),

                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                        setState(() {
                          loadingFeed = true;
                        });
                        }

                      await Future.delayed(const Duration(seconds: 2));
                      Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.rightToLeft, child : Interest(
                        name: name.text,
                        about: description.text,
                        username: username.text,
                        DOB: DOB.text,
                        location: location.text,
                        artist: artist.text,
                        image: imgurl==""?
                        user.photoURL:imgurl)));
                        setState(() {
                          loadingFeed = false;
                        });
                      },
                      child: (loadingFeed)
                          ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(
                                color: Colors.blue,
                                strokeWidth: 1.5,
                              ))
                          :  Text('Create Profile',style: changeImage,),
                              ),
                            ),


                      s2,


                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }



addArtists({required BuildContext context,}){
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
          controller: artist,          
        ),

      actions: <Widget>[
        TextButton(
          onPressed: (){
            favouriteArtists.add(artist.text);
            print(favouriteArtists);
            // updatePost( id: id);

            Navigator.of(context).pop();
          },
          child: Text("Save"),)
          ]
        )
      );
    }

createProfilePage({required BuildContext context, required description, required name})async{
  // final joined = DateFormat.yMMMEd().format(DateTime.now());
  final joined = "";
  final user = FirebaseAuth.instance.currentUser!;
  final userdata = FirebaseFirestore.instance.collection("userData").doc("${user.uid}");
  final String? image;
  imgurl == "" ? image = user.photoURL : image=imgurl;
  final String? userImage = user.photoURL;
  await userdata.set({
    "about" : description,
    "image" : userImage,
    "isVerified" : false,
    "joined" : joined.toString(),
    "name" : name,
    "userEmail" : user.email,
    "uid" : user.uid,
    "favouriteArtists" : []
  }).then((value) {
    message(message: "Profile created", bgcolor: Colors.green,txtcolor: Colors.white);
    Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.rightToLeft, child : Home()));
    }).onError((error, stackTrace) => message(message: "error while creating profile", bgcolor: Colors.red,txtcolor: Colors.white));
}




Future imgFromGallery() async {
  final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
  setState(() {
    if (pickedFile != null) {
      _photo = File(pickedFile.path);
      uploadFile();
    } else {
      print('No image selected');
      }
    }
  );
}

Future imgFromCamera() async {
  final pickedFile = await _picker.pickImage(source: ImageSource.camera);
  setState(() {
    if (pickedFile != null) {
      _photo = File(pickedFile.path);
      uploadFile();
    } else {
      print('No image selected.');
      }
    }
  );
}

Future uploadFile() async {
  if (_photo == null) return;
  final fileName = basename(_photo!.path);
  final destination = '$fileName';
  try {
    final ref = firebase_storage.FirebaseStorage.instance.ref(destination);
    loading(text: "uploading image",);
    setState(() {
      isuploading = true;
    });

    await ref.putFile(_photo!).then((p0) => message(message: "upload sucessful", bgcolor: Colors.green,txtcolor: Colors.white));

    String  urlString = await ref.getDownloadURL();

    setState(() {
      imgurl = urlString;
      isuploading = false;
    });
    return urlString;
    } catch (e) {
      setState(() {
        error = true;
      }
    );
  }
}


void _showPicker(context) {
  final iconstyle = Colors.grey.shade600;
  final textstyle = GoogleFonts.roboto();

  showModalBottomSheet(
    context: context,
    builder: (BuildContext bc) {
      return SafeArea(
        child: Container(
          child: Wrap(
            children: <Widget>[

              // ListTile(
              //   leading: Container(
              //     height: 25,
              //     width: 25,
              //     child: Center(child: Image.asset("assets/images/profile.png",fit: BoxFit.cover, ))),
              //   // leading: Icon(Icons., color: iconstyle,),
              //   title: Text('Avtar', style: textstyle,),
              //   onTap: () {
              //     // imgFromGallery();
              //     Navigator.of(context).pop();
              //   }
              // ),

              ListTile(
                leading: Icon(Icons.photo, color: iconstyle,),
                title: Text('Gallery', style: textstyle,),
                onTap: () {
                  imgFromGallery();
                  Navigator.of(context).pop();
                }
              ),

              ListTile(
                leading:  Icon(Icons.camera, color: iconstyle),
                title:  Text('Camera', style: textstyle,),
                onTap: () {
                  imgFromCamera();
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      );
    }
  );
}

  
Widget field({required controllerName, required hinttext, required error,}) =>
  TextFormField(
    controller: controllerName,
    decoration: InputDecoration(
    hintText: hinttext,
    enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
    ),

    focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
    filled: true,
    fillColor: Colors.grey[100],
  ),
    validator: (String? value) {
      if (value!.isEmpty) {
        return 'Please enter $error';
      }
      return null;
    },
  );            
}