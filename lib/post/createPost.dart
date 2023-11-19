import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:chillx/support/message.dart';

  final  TextEditingController title = TextEditingController();
  final  TextEditingController description = TextEditingController();
  final  TextEditingController link = TextEditingController();
  final user = FirebaseAuth.instance.currentUser!;
  final _formKey = GlobalKey<FormState>();


sendpost({context}){
    final post1 = FirebaseFirestore.instance.collection('Post').doc(); 
    post1.set({
      "category": [
        user.uid,
        dropdownValue
      ],
      "postId": post1.id,
      "title": title.text,
      "caption":description.text,
      "Link" : link.text,
      "uid" : user.uid,
      "time": DateTime.now().toString(),
      'createdOn': FieldValue.serverTimestamp(),
      "edited": false

    }).then((value) {
      message(message: "post added",  bgcolor: Colors.green,txtcolor: Colors.white);
      title.clear();
      description.clear();
      link.clear();
        }
      );
    }
 String dropdownValue = 'Books';

Widget postBox({required BuildContext context}){
    final _mediaQueryData = MediaQuery.of(context);
    final screenWidth = _mediaQueryData.size.width;
    final screenHeight = _mediaQueryData.size.height;
    final blockSizeHorizontal = screenWidth/1.1;
    final blockSizeVertical = screenHeight/100;

    return
    Form(
      key: _formKey,
      child: Padding(
        padding:const EdgeInsets.only(
          left: 6.0,
           right: 16.0,
            top: 8.0,
    
            ),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 5, 0, 1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: blockSizeHorizontal,
                      height:60,
                      decoration: BoxDecoration(
                        // color: 
                        color: Colors.lightBlue.shade50,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 7, left: 6, right: 6),
                        child: TextFormField(
                          validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  },
                          // minLines: 1,
                          controller: title,
                          maxLength: 120,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "recommend something", 
                  hintStyle: GoogleFonts.lato(fontSize: 14)
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 6.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                      IconButton(onPressed: (){
                        caption(context: context);
                        
                      }, icon: Icon(Icons.closed_caption_off_outlined)),
                      IconButton(onPressed: (){
                        saveLink(context: context);
                      }, icon: Icon(Icons.link)),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: TextButton(
                            onPressed: (){
                              if (_formKey.currentState!.validate()) {
                            sendpost(context: context);
                            Navigator.of(context).pop();
                            }
                          }, child: Text("recommend", textAlign: TextAlign.end,),),
                        )
                    ],),
                    
                        
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );}



// savelink
saveLink({context}){
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) => AlertDialog(
      title: Text("make content easily accessible", style: font,),
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
          hintText: "paste link here",
          hintStyle: font,
          fillColor: Colors.grey[40],
        ),
          controller: link,          
        ),

      actions: <Widget>[
        TextButton(
          onPressed: (){
            // editcomment(id:id);
            Navigator.of(context).pop();
          },
          child: Text("Save"),)
          ]
        )
      );
    }



// final _category ="";
Widget category2()=> StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('Category').snapshots(),
        builder: (context, snapshot){
          if (!snapshot.hasData) return const Center(
            child: const CupertinoActivityIndicator(),
          );
          // var length = snapshot.data!.docs.length;
          // DocumentSnapshot ds = snapshot.data!.docs[length - 1];
          final _queryCat = snapshot.data!.docs;
          return Container(
            padding: EdgeInsets.only(bottom: 16.0),
            // width: screenSize.width*0.9,
            child:  Row(
              children: <Widget>[
                Expanded(
                    flex: 2,
                    child:  Container(
                      padding: EdgeInsets.fromLTRB(12.0,10.0,10.0,10.0),
                      child:  Text("Category",style: font,),
                    )
                ),
                Expanded(
                  flex: 4,
                  child: InputDecorator(
                    decoration: const InputDecoration(
                      //labelText: 'Activity',
                      hintText: 'Choose an category',
                      hintStyle: TextStyle(
                        // color: primaryColor,
                        fontSize: 16.0,
                        // fontFamily: "OpenSans",
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    // isEmpty: _category == null,
                    child:  DropdownButton(
                      value: dropdownValue,
                      isDense: true,
                      items: snapshot.data!.docs.map((DocumentSnapshot document) {
                        return  DropdownMenuItem<String>(
                            value: document.get("Category"),
                            child: Container(
                              decoration:  BoxDecoration(
                                  // color: primaryColor,
                                  borderRadius: new BorderRadius.circular(5.0)
                              ),
                              height: 100.0,
                              padding: EdgeInsets.fromLTRB(10.0, 2.0, 10.0, 0.0),
                              //color: primaryColor,
                              child: Text(
                                "Select"
                              )
                                // document.toString(),style: font),
                            )
                        );
                      }).toList(), onChanged: (String? value) { 

                       },
                    ),
                  ),
                ),
              ],
            ),
          );
        }
    );

final font = GoogleFonts.lato();

// caption box
caption({context}){
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) => AlertDialog(
      title: Text("Description", style: font,),
      content: TextFormField(
          maxLength: 1000,
          minLines: 11,
          maxLines: 13,
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
          hintText: "write description ...",
          hintStyle: font,
          fillColor: Colors.grey[40],
        ),
          controller: description,          
        ),
  
      actions: <Widget>[
        TextButton(
          onPressed: (){
            // editcomment(id:id);
            Navigator.of(context).pop();
          },
          child: Text("Save"),)
          ]
        )
      );
    }

class Upload extends StatefulWidget {
  const Upload({Key? key}) : super(key: key);

  @override
  State<Upload> createState() => _UploadState();
}

class _UploadState extends State<Upload> {

void fetchFirebaseData() async {
  final firestoreInstance = FirebaseFirestore.instance;
  firestoreInstance.collection("customerServices").doc('Category').get().then((value) {
    //do something
  });
}
  final user = FirebaseAuth.instance.currentUser!;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  final CollectionReference post = FirebaseFirestore.instance.collection('Post');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("recommend")),
    body : Column(
      children: [
        postBox( context: context),
        Row(
              children: <Widget>[
                Expanded(
                    flex: 2,
                    child:  Container(
                      // decoration: BoxDecoration,
                      padding: EdgeInsets.fromLTRB(12.0,10.0,10.0,10.0),
                      child:  Text("Category",style: font,),
                    )
                ),
                Expanded(
                  flex: 4,
                    child:  DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      // style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.lightBlue,
      ),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
      },
      items: <String>['Books', 'Articles', 'Courses', 'Movie', "Web-Series", "songs", "Podcast", "Comedy", "Show", "Documentary", "Cartoon", "Animie"]
          .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),

                      );
                    }).toList(),
                  )
                ),
              // ),
            ],
          ),
        ],
      )
    );
  }
}