// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:teamtext/home_page.dart';
//import 'package:klip/currentUser.dart' as currentUser;
import 'constants.dart' as Constants;

class PhoneLogin extends StatefulWidget {
  const PhoneLogin({Key? key}) : super(key: key);

  @override
  _PhoneLoginState createState() => _PhoneLoginState();
}

class _PhoneLoginState extends State<PhoneLogin> {
  int currentBox = 0;
  bool isVerifying = false;
  List<String> textList = ["", "", "", "", "", "", "", "", "", ""];
  int lastPressed = DateTime.now().millisecondsSinceEpoch;
  @override
  void initState() {
    super.initState();
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
                buildInput(10),
                Text(
                  "Enter your phone number",
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                ),
                Container(
                  height: 75,
                ),
                GestureDetector(
                  onTap: () {
                    if (!isVerifying) {
                      setState(() {
                        isVerifying = true;
                      });
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
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
}
