// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:teamtext/phone_login.dart';
import 'constants.dart' as Constants;
import 'theme.dart';

class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  /*void setUpPreferences() async {
    await pullUserFromSharedPreferences();
    //ThemeProvider.controllerOf(context).setTheme(currentUser.themePreference);
  }*/

  @override
  void initState() {
    //setUpPreferences();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return startScreen();
    /*FutureBuilder<dynamic>(
      future: _memoizer.runOnce(() async {
        return await checkIfUserIsSignedIn();
      }), // checkIfUserIsSignedIn(),
      // a previously-obtained Future<String> or null
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data == "UserSignedIn") {
            //setUpCurrentUser(uid);
            return Navigation();
          } else {
            print("DATA " + snapshot.data.toString());
            return startScreen();
          }
        } else {
          return Center(
            child: Container(),
          );
        }
      },
    );*/
  }

  Widget startScreen() {
    Constants.statusBarHeight = MediaQuery.of(context).padding.top;
    return Padding(
      padding: EdgeInsets.only(
        top: Constants.statusBarHeight,
      ),
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.bottomLeft,
              child: ShaderMask(
                shaderCallback: (rect) {
                  return LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    stops: const [0.1, 0.4, 0.6],
                    colors: [Colors.blue, Colors.blue.withOpacity(.4), Colors.transparent],
                  ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
                },
                blendMode: BlendMode.srcIn,
                child: Image.asset(
                  "lib/assets/images/geometricLines2.png",
                  width: MediaQuery.of(context).size.width * .9,
                  height: MediaQuery.of(context).size.height / 2.5,
                  fit: BoxFit.fill,
                  //color: Colors.grey,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height / 3),
              child: Center(
                child: Text(
                  "TeamText",
                  style: TextStyle(
                    fontSize: 60,
                    color: Constants.theme.foreground,
                  ),
                ),
              ),
            ),
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PhoneLogin()),
                );
              },
              child: Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height / 3 - 150,
                ),
                child: Center(
                  child: Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width / 4 * 3,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(
                        Radius.circular(50),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Log In or Sign Up",
                        style: TextStyle(color: Constants.theme.background, fontSize: 25),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
