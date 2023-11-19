

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

message({required message, required Color bgcolor, required Color txtcolor}){
  Fluttertoast.showToast(msg: message, backgroundColor: bgcolor, textColor: txtcolor);
}




