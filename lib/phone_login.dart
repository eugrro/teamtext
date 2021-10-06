// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:teamtext/home_page.dart';
//import 'package:klip/currentUser.dart' as currentUser;
import 'constants.dart' as Constants;
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

FirebaseAuth auth = FirebaseAuth.instance;

class PhoneLogin extends StatefulWidget {
  const PhoneLogin({Key? key}) : super(key: key);

  @override
  _PhoneLoginState createState() => _PhoneLoginState();
}

class _PhoneLoginState extends State<PhoneLogin> {
  int currentBox = 0;
  bool isVerifying = false;
  List<String> textList = ["", "", "", "", "", "", "", "", "", ""];
  String verificationId = "";
  late User signedInUser;
  late String inputNumber;
  bool isUserSignedIn = false;
  int lastPressed = DateTime.now().millisecondsSinceEpoch;
  @override
  void initState() {
    super.initState();
    TextField(
      // REQUIRED to open the number keyboard
      focusNode: FocusNode(),
      autofocus: true,
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly], // Only numbers can be entered
    );
    SystemChannels.textInput.invokeMethod('TextInput.show');
  }

  @override
  void dispose() {
    super.dispose();
  }

  void moveBackOne() {
    setState(() {
      if (currentBox != 0) {
        currentBox -= 1;
      }
    });
  }

  void moveForwardOne() {
    setState(() {
      if ((isVerifying && currentBox != 9) || (!isVerifying && currentBox != 9)) {
        currentBox += 1;
      } else {
        SystemChannels.textInput.invokeMethod('TextInput.hide');
        currentBox = -1;
      }
    });
  }

  String getNumber(int len) {
    String ret = "";
    for (int i = 0; i < len; i++) {
      ret += textList[i];
    }
    return ret;
  }

  void clearNumbers(int len) {
    for (int i = 0; i < len; i++) {
      textList[i] = "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          SystemChannels.textInput.invokeMethod('TextInput.hide');
          currentBox = -1;
        },
        child: Scaffold(
          body: Container(
            color: Constants.theme.background,
            child: Column(
              children: [
                isVerifying ? buildInput(6) : buildInput(10),
                Text(
                  "Enter your phone number",
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
                Container(
                  height: 75,
                ),
                GestureDetector(
                  onTap: () async {
                    if (!isVerifying) {
                      SystemChannels.textInput.invokeMethod('TextInput.hide');
                      setState(() {
                        inputNumber = "+1" + getNumber(10);
                        clearNumbers(10);
                        isVerifying = true;
                      });
                      await verifyPhoneNumber(inputNumber);
                      if (isUserSignedIn) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                        );
                      } else {
                        SystemChannels.textInput.invokeMethod('TextInput.show');
                      }
                    } else {
                      if (verificationId == "") {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Verification ID is null"),
                        ));
                      } else {
                        SystemChannels.textInput.invokeMethod('TextInput.hide');
                        await verifyCode(verificationId, getNumber(6));
                        if (isUserSignedIn) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                          );
                        }
                      }
                    }
                  },
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
                        isVerifying ? "Verify" : "Submit",
                        style: TextStyle(color: Constants.theme.background, fontSize: 25),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildInput(int numFields) {
    double boxWidth = (MediaQuery.of(context).size.width) / (numFields * 1.5);
    double spacing = 5;
    return Padding(
      padding: const EdgeInsets.only(top: 200),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: boxWidth * 1.4,
        child: Center(
          child: RawKeyboardListener(
            onKey: (event) {
              if (DateTime.now().millisecondsSinceEpoch - lastPressed > 100) {
                lastPressed = DateTime.now().millisecondsSinceEpoch;
                if (event.logicalKey == LogicalKeyboardKey.backspace) {
                  if (textList[currentBox] == "") {
                    moveBackOne();
                    setState(() {
                      textList[currentBox] = "";
                    });
                  } else {
                    setState(() {
                      textList[currentBox] = "";
                    });
                  }
                } else if (num.tryParse(event.character.toString()) != null) {
                  setState(() {
                    textList[currentBox] = num.tryParse(event.character.toString()).toString();
                  });
                  moveForwardOne();
                }
              }
            },
            autofocus: true,
            focusNode: FocusNode(),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: numFields * 2 - 1,
              itemBuilder: (context, index) {
                if (index % 2 == 0) {
                  return GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      setState(() {
                        currentBox = index ~/ 2;
                        SystemChannels.textInput.invokeMethod('TextInput.show');
                      });
                    },
                    child: Container(
                        width: boxWidth,
                        height: boxWidth,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(.4),
                          border: Border(
                            bottom: BorderSide(width: 2.0, color: currentBox == index ~/ 2 ? Colors.blue : Constants.theme.foreground),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            textList[index ~/ 2],
                            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                          ),
                        )),
                  );
                } else {
                  return SizedBox(
                    width: spacing,
                    height: spacing,
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Future<void> verifyPhoneNumber(String number) async {
    await auth.verifyPhoneNumber(
      phoneNumber: number,
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          print('The provided phone number is not valid.');
        }
      },
      codeSent: (String _verificationId, int? resendToken) async {
        setState(() {
          verificationId = _verificationId;
        });
      },
      timeout: const Duration(seconds: 60),
      codeAutoRetrievalTimeout: (String verificationId) {
        // Auto-resolution timed out...
      },
      verificationCompleted: (PhoneAuthCredential credential) async {
        // ANDROID ONLY!
        final User? user = (await auth.signInWithCredential(credential)).user;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Successfully signed in UID: ${user?.uid}'),
        ));
        setState(() {
          isUserSignedIn = true;
        });
      },
    );
  }

  Future<void> verifyCode(String verificationID, String code) async {
    print(verificationID);
    print(code);
    try {
      final PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationID,
        smsCode: code,
      );
      final User? user = (await auth.signInWithCredential(credential)).user;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Successfully signed in UID: ${user?.uid}'),
      ));
      setState(() {
        isUserSignedIn = true;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to sign in'),
      ));
    }
  }
}
