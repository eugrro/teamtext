// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, library_prefixes

import 'package:flutter/material.dart';
import 'package:teamtext/add_manually.dart';
import 'package:teamtext/messenger_page.dart';
import 'package:teamtext/qr_preview.dart';
import 'package:teamtext/requests.dart';
//import 'package:klip/currentUser.dart' as currentUser;
import 'constants.dart' as Constants;
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({Key? key}) : super(key: key);

  @override
  _MessagesScreenState createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  List<String> peopleList = ["John Smith", "George Johnson", "Amelia Earhart"];
  //List<String> peopleList = [];
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
    return Container(
      color: Constants.theme.background,
      child: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 10),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 25, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Messages",
                    style: TextStyle(color: Constants.theme.foreground, fontSize: 40),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      children: [
                        GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => QRPreview()),
                            );
                          },
                          child: Image.asset(
                            "lib/assets/images/QR_sample.png",
                            width: 30,
                            height: 30,
                          ),
                        ),
                        Container(
                          width: 10,
                        ),
                        GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => AddManually()),
                            );
                            createUser("012345", "Eugene", "Rozental", "eugene.rozental@gmail.com", "1234567890");
                          },
                          child: Icon(
                            Icons.add,
                            size: 35,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 100,
            ),
            peopleList.isEmpty
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 75, right: 75),
                      child: Text(
                        "No team members found!\nPress the QR code at the top right hand corner to generate an invitation or press '+' to add them manually",
                        style: TextStyle(fontSize: 15, color: Colors.grey),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                : buildMessageList(),
          ],
        ),
      ),
    );
  }

  String getInitials(String name) {
    var namesSplit = name.split(" ");
    if (namesSplit.length == 1) {
      return namesSplit[0].toUpperCase();
    }
    return namesSplit[0][0].toUpperCase() + namesSplit[1][0].toUpperCase();
  }

  Widget buildMessageList() {
    return Expanded(
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: peopleList.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              pushNewScreen(
                context,
                screen: MessengerPage(),
                withNavBar: false,
                pageTransitionAnimation: PageTransitionAnimation.cupertino,
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: SizedBox(
                height: 70,
                child: Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.all(Radius.circular(25)),
                      ),
                      child: Center(
                        child: Text(
                          getInitials(peopleList[index]),
                          style: TextStyle(color: Constants.theme.background, fontSize: 17),
                        ),
                      ),
                    ),
                    Container(
                      width: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          peopleList[index],
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400, color: Constants.theme.foreground),
                        ),
                        Text(
                          "This is a sample message",
                          style: TextStyle(color: Colors.grey, fontSize: 15),
                        ),
                        Text(
                          "Oct 3",
                          style: TextStyle(color: Colors.grey.withOpacity(.7)),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
