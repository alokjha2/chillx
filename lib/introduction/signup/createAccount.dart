




import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class createAcc extends StatefulWidget {
  createAcc({Key? key}) : super(key: key);

  @override
  State<createAcc> createState() => _createAccState();
}

class _createAccState extends State<createAcc> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController name = TextEditingController();
  final TextEditingController description= TextEditingController();
  final s1 = SizedBox(height: 20,);
  final s2 = SizedBox(height: 10,);
  bool _isObscure = true;
bool? _success;
String? _userEmail;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,

          children: <Widget>[
            RichText(
                        text:  TextSpan(
                          children: [
                            TextSpan(
                              style: GoogleFonts.ubuntu(textStyle: const TextStyle(color: Colors.black,fontSize: 30),),
                              text: "Let's Create ",
                            ),
                            TextSpan(
                              style: GoogleFonts.ubuntu(textStyle: const TextStyle(color: Colors.blue,fontSize: 30),),
                              text: "Profile",
                            ),
                          ]
                        )
                      ),

            // field(controllerName: _emailController, hinttext: "Email", error: "email"),
//             TextFormField(
//               obscureText: _isObscure,
//   controller: _passwordController,
//   decoration: InputDecoration(
//     suffixIcon: IconButton(icon: _isObscure ==true?Icon(Icons.visibility) :Icon( Icons.visibility_off,),onPressed: (){
//       setState(() {
//         _isObscure = !_isObscure;
//       });
//     },),
//   hintText: "password",
//     enabledBorder:const OutlineInputBorder(
//         borderRadius: BorderRadius.all(Radius.circular(8)),
//     ),
//     focusedBorder: const OutlineInputBorder(
//         borderRadius: BorderRadius.all(Radius.circular(8)),
//     ),
//   filled: true,
//   fillColor: Colors.grey[100],
// ),

  //   validator: (String? value) {
  //     if (value!.isEmpty) {
  //       return 'Please enter password';
  //     }
  //     return null;
  //   },
  // ),  
            s1,
            field(controllerName: description, hinttext: "Description", error: "description"),
            field(controllerName: name, hinttext: "Profile's Name", error: "Name"), 
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _register();
                  }
                },
                child: const Text('Submit'),
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Text(_success == null
                  ? ''
                  : (_success!
                      ? 'Successfully registered ' + _userEmail!
                      : 'Registration failed')),
                    )
                  ],
                ),
              ),
            ),
          );
        }


  void _register() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
  
  final  user = (
    await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      )
  ).user;
  if (user != null) {
    setState(() {
      _success = true;
      _userEmail = user.email!;
    });
  } else {
    setState(() {
      _success = true;
    });
  }
}


Widget field({required controllerName, required hinttext, required error,})=>
TextFormField(
  controller: controllerName,
  decoration: InputDecoration(
  hintText: hinttext,
  
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
        return 'Please enter $error';
      }
      return null;
    },
  );            
}