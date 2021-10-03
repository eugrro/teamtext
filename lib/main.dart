// ignore_for_file: library_prefixes, prefer_const_constructors

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:teamtext/home_page.dart';
import 'start_page.dart';
import 'constants.dart' as Constants;
import 'constants.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  theme.changeToLightMode();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    runApp(new MyApp());
  });
}

//LOOK INTO THIS https://pub.dev/packages/animated_text_kit

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Constants.theme.background,
      ),
    );
  }
}
