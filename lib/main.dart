// ignore_for_file: library_prefixes, prefer_const_constructors

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:teamtext/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'start_page.dart';
import 'constants.dart' as Constants;
import 'constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  theme.changeToLightMode();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    runApp(new MyApp());
  });
  print(Constants.getRandomString(27));
}

//LOOK INTO THIS https://pub.dev/packages/animated_text_kit

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Constants.theme.background,
      ),
      home: Builder(
        builder: (context) {
          return ScrollConfiguration(
            behavior: NoScrollGlow(),
            child: HomePage(),
          );
        },
      ),
    );
  }
}

class NoScrollGlow extends ScrollBehavior {
  @override
  Widget buildViewportChrome(BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
