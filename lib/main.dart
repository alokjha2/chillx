// flycricket
import 'dart:io';
import 'package:flutter/material.dart';


//package
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:chillx/home/Home.dart';
import 'package:chillx/introduction/createProfile.dart';
import 'package:chillx/introduction/interest.dart';
import 'package:chillx/introduction/signup.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


bool? theme;
int? isviewed;

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter(); 
  Directory directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  isviewed = prefs.getInt('onBoard');
  theme = prefs.getBool("color");
  ErrorWidget.withDetails(message: "Error",);
  runApp(const Main());
}




class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);
  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
  }


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(appBarTheme: AppBarTheme(
        color: Colors.lightBlue,
          elevation: 2,
          titleTextStyle : GoogleFonts.lato(textStyle: const TextStyle(fontSize: 22, fontWeight: FontWeight.w400)
        ),
      ),
    ),

      title: "Chirkut",
      debugShowCheckedModeBanner: false,
      home : 
      
      HomePage()
      
      //  FirebaseAuth.instance.currentUser == null ? const Signup() :  const Home()
    );
  }
}

// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('My App'),
//       ),
//       body: Center(
//         child: Text(
//           'Hello!',
//           style: TextStyle(
//             fontSize: 24,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//     );
//   }
// }