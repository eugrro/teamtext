// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, library_prefixes, unused_import

import 'package:flutter/material.dart';
//import 'package:klip/currentUser.dart' as currentUser;
import 'constants.dart' as Constants;

class MessengerPage extends StatefulWidget {
  const MessengerPage({Key? key}) : super(key: key);

  @override
  _MessengerPageState createState() => _MessengerPageState();
}

class _MessengerPageState extends State<MessengerPage> {
  late TextEditingController messageController;

  @override
  void initState() {
    super.initState();
    messageController = TextEditingController(text: "");
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: Scaffold(
        body: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: 65,
              decoration: BoxDecoration(
                color: Constants.theme.background,
                border: Border(
                  bottom: BorderSide(width: .2, color: Colors.grey),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 15, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.arrow_back_ios_new_rounded),
                        ),
                        Container(
                          width: 10,
                        ),
                        Text(
                          "John Smith",
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.phone,
                        ),
                        Container(
                          width: 20,
                        ),
                        Icon(Icons.settings)
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                child: SizedBox(
                  height: 100,
                  //color: Colors.blue,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Center(
                        child: Text(
                          "Your messages will appear here",
                          style: TextStyle(color: Colors.grey.withOpacity(.5)),
                        ),
                      ),
                      Container(
                        height: 30,
                      )
                    ],
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 7.5 / 10,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    border: Border.all(width: 1.0, color: Colors.black),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: 5,
                      bottom: 5,
                      left: 20,
                      right: 10,
                    ),
                    child: ExpandingTextField(
                      maxHeightPx: 150, // px value after which textbox won't expand
                      width: MediaQuery.of(context).size.width * 6.5 / 10, // width of your textfield
                      child: TextField(
                        controller: messageController,
                        keyboardType: TextInputType.multiline,
                        minLines: 1, // number of lines your textfield start with
                        maxLines: null,
                        textAlignVertical: TextAlignVertical.center,
                        cursorColor: Constants.theme.foreground,
                        cursorWidth: 1.5,
                        decoration: InputDecoration(
                          isDense: true,
                          border: InputBorder.none,
                          hintText: "Send a message...",
                          hintStyle: TextStyle(
                            color: Constants.theme.foreground.withOpacity(.6),
                            fontSize: 14 + Constants.textChange,
                          ),
                        ),
                        style: TextStyle(
                          color: Constants.theme.foreground.withOpacity(.9),
                          fontSize: 14 + Constants.textChange,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 20,
                ),
                GestureDetector(
                  onTap: () {
                    if (messageController.text.isNotEmpty) {
                      String currTime = (DateTime.now().millisecondsSinceEpoch / 1000).round().toString();

                      /*setState(() {
                          comments.add([currentUser.uid, currentUser.uName, currentUser.avatarLink, commentController.text, currTime]);
                          FocusScope.of(context).requestFocus(new FocusNode());
                          });*/
                      //addComment(pid, commentController.text, currTime);
                      //commentController.text = "";
                    }
                  },
                  child: Container(
                    width: 50,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      border: Border.all(width: 1.0, color: Colors.black),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 3),
                      child: Icon(Icons.send),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: 5,
            )
          ],
        ),
      ),
    );
  }
}

class ExpandingTextField extends StatelessWidget {
  const ExpandingTextField({
    required this.maxHeightPx,
    required this.child,
    required this.width,
  });

  final TextField child;
  final double maxHeightPx; // height after which textfield won't expand to fit text but will be scrollable
  final double width;
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: maxHeightPx,
      ),
      child: SizedBox(
        width: width,
        child: child,
      ),
    );
  }
}
