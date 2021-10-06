// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

import 'theme.dart';

///Constants file throughout the app
///widgets will be in global_widgets
var theme = MyTheme();
double textChange = 0;
Widget tempAvatar = Image.asset("lib/assets/images/tempAvatar.png");

double statusBarHeight = 0;
const String StripePKey = "pk_test_51IOnY5Hau82X1Y1fc6l4P6QUfpK6euFX8ULZ3PLpCAG0rObkmlwt7g5k20eFCJzmdFUtZl18wF8kFVZYrqsMuYKa002zcUpSaa";
//testing

//String nodeURL = "https://teamtext.app/"; //Hosted Server in the Cloud
//String nodeURL = "http://10.0.2.2:3000/";   //Local Server for emulator
String nodeURL = "http://192.168.1.150:3000/"; //Local Server for physical device (your ip)

//DO NOT MODIFY THIS VARIABLE IN THE CODE
bool checkedProfileImage = false;

int maxBioLength = 100;
