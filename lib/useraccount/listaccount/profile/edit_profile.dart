import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:chillx/support/loading_dialog.dart';
import 'package:chillx/support/message.dart';

class edit_profile extends StatefulWidget {
  final String name;
  final String about;
  final String image;
  final String uid;
  edit_profile({Key? key, required this.name, required this.about, required this.image, required this.uid}) : super(key: key);

  @override
  State<edit_profile> createState() => _edit_profileState();
}

class _edit_profileState extends State<edit_profile> {
  final user = FirebaseAuth.instance.currentUser!;
  bool isuploading = false;
  firebase_storage.FirebaseStorage storage = firebase_storage.FirebaseStorage.instance;
  File? _photo;
  final ImagePicker _picker = ImagePicker();
  bool error = false;
  final ScrollController page = ScrollController();
  late String imgurl = "";
  
  @override
  Widget build(BuildContext context) {
  final TextEditingController name = TextEditingController(text: widget.name);
  final TextEditingController description= TextEditingController(text: widget.about);
    return Scaffold(
      appBar: AppBar(title: Text("Edit Profile")),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton : FloatingActionButton.extended(
        shape: const StadiumBorder(),
        backgroundColor: Colors.lightBlueAccent,
        label : isuploading == true ? CircularProgressIndicator() :
           Text("Update", 
           style : GoogleFonts.ubuntu(textStyle:const TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white))),

          onPressed: (){
            isuploading==true ? null:
            print(imgurl);
            updateProfile(name: name, description: description, context: context);
          }
        ),

      body: 
      Padding(
        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
        child: SingleChildScrollView(
          controller: page,
          child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    Stack(
                      children: [

                      isuploading == true ? Container(
                        color: Colors.lightBlue,
                        height: 150,
                        width: 150,
                        child: Center(child: CircularProgressIndicator())) :

                        Container(
                        height: 150,
                        width: 150,  
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(widget.image),
                            fit: BoxFit.cover,
                            filterQuality: FilterQuality.high
                            ),
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
                  ],
                ),


                    const SizedBox(height: 10),

                    TextButton(onPressed: (() => _showPicker(context)), child: Text("Change image", style: GoogleFonts.lato(),)),

                    buildName(controller: name),

                    const SizedBox(height: 20),

                    buildDescription(descriptionCtr: description),

                    const SizedBox(height: 20),

                  ],
                ),
              ),
            )
          );
        }



// name

Widget buildName({required controller}) => Column(
  mainAxisAlignment: MainAxisAlignment.start,
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Text("Name"),

    TextFormField(
      decoration: InputDecoration(
          enabledBorder : const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          filled: true,
          fillColor: Colors.grey[100],
        ),
        controller: controller,
    ),
  ],
);


Widget buildDescription({required descriptionCtr}) => Column(
  mainAxisAlignment: MainAxisAlignment.start,
  crossAxisAlignment: CrossAxisAlignment.start,
  children: [
    Text("About Me"),

    TextFormField(
      maxLines: 10,
      minLines: 5,
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        filled: true,
        fillColor: Colors.grey[100],
    ),
    controller: descriptionCtr,                 
    ),
  ],
);


deleteImage({required String imageUrl}) async {
  Reference photoRef =FirebaseStorage.instance.refFromURL(imageUrl);
  await photoRef.delete().then((value) {
   message(message: "deleted Successfully", bgcolor: Colors.green,txtcolor: Colors.white);

    }
  );
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


  updateProfile({required name, required description, image, required BuildContext context})async{
    final userdata = FirebaseFirestore.instance.collection("userData").doc("${widget.uid}");
      imgurl == ""?

    await userdata.update({
      "name" : name.text,
      "about": description.text
    }).then((value) {
      message(message: "Profile Updated", bgcolor: Colors.green,txtcolor: Colors.white);
      Navigator.of(context).pop();
      Navigator.of(context).pop();

      }).onError((error, stackTrace) => message(message: "Can't update profile", bgcolor: Colors.red,txtcolor: Colors.white))
    : 
    await userdata.update({
      "image": imgurl,
      "name" : name.text,
      "about":description.text,

    }).then((value) {
    deleteImage(imageUrl: widget.image);
      setState(() {
        imgurl=="";
      });
      
      message(message: "Profile Updated", bgcolor: Colors.green,txtcolor: Colors.white);
      Navigator.of(context).pop();
      }).onError((error, stackTrace) => message(message: "Can't update profile", bgcolor: Colors.red,txtcolor: Colors.white));

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


                ListTile(
                  leading: Icon(Icons.photo, color: iconstyle,),
                  title: Text('Gallery', style: textstyle,),
                  onTap: () {
                    imgFromGallery();
                    Navigator.of(context).pop();
                  }),


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
}