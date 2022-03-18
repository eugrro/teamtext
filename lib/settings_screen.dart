// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:teamtext/start_page.dart';
import 'package:teamtext/suggestion_page.dart';
//import 'package:klip/currentUser.dart' as currentUser;
import 'constants.dart' as Constants;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  double settingsTitleHeight = 40;
  double settingsInfoHeight = 40;
  TextStyle titleStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.w500);
  TextStyle bodyStyle = TextStyle(fontSize: 14, color: Constants.theme.foreground.withOpacity(.7));

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 10),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 25, right: 15),
            child: Text(
              "Settings",
              style: TextStyle(color: Constants.theme.foreground, fontSize: 40),
            ),
          ),
          Container(
            height: 100,
          ),
          title("My Account"),
          bodyInfo("Name", "Eugene Rozental"),
          bodyInfo("Mobile Number", "(xxx) xxx xxxx"),
          bodyInfo("Email", "eugene.rozental@gmail.com"),
          title("Personalization"),
          bodyInfo("Theme", "Light"),
          bodyInfo("Color", "Blue"),
          title("Support"),
          bodyInfo("I Need Help", ""),
          bodyInfo("I Have a Privacy Question", ""),
          title("Feedback"),
          bodyInfo("I Spotted a Bug", ""),
          GestureDetector(
            onTap: () {
              pushNewScreen(
                context,
                screen: SuggestionPage(),
                withNavBar: false,
                pageTransitionAnimation: PageTransitionAnimation.cupertino,
              );
            },
            child: bodyInfo("I Have a Suggestion", ""),
          ),
          bodyInfo("Request a Feature", ""),
          title("Privacy"),
          bodyInfo("Privacy Policy", ""),
          bodyInfo("Terms of Service", ""),
          title("Account Actions"),
          GestureDetector(
            onTap: () {
              FirebaseAuth.instance.signOut();
              while (Navigator.canPop(context)) {
                Navigator.pop(context);
              }
              pushNewScreen(
                context,
                screen: StartPage(),
                withNavBar: false,
                pageTransitionAnimation: PageTransitionAnimation.cupertino,
              );
            },
            child: bodyInfo("Log Out", ""),
          ),
          Container(
            color: Constants.theme.background,
            child: Padding(
              padding: EdgeInsets.only(top: 29, bottom: 20),
              child: Column(
                children: [
                  Text(
                    "Teamtext v0.0.1",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
                  ),
                  Text(
                    "Built in New York",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget title(String title) {
    return Container(
      height: settingsTitleHeight,
      width: MediaQuery.of(context).size.width,
      color: Colors.grey.withOpacity(.3),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: EdgeInsets.only(left: 15),
          child: Text(
            title,
            style: titleStyle,
          ),
        ),
      ),
    );
  }

  Widget bodyInfo(String left, String right) {
    return Container(
      height: settingsInfoHeight,
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              left,
              style: bodyStyle,
            ),
            Text(
              right,
              style: bodyStyle,
            ),
          ],
        ),
      ),
    );
  }
}
