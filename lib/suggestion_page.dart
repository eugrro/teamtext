// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, library_prefixes, unused_import

import 'package:flutter/material.dart';
//import 'package:klip/currentUser.dart' as currentUser;
import 'constants.dart' as Constants;

class SuggestionPage extends StatefulWidget {
  const SuggestionPage({Key? key}) : super(key: key);

  @override
  _SuggestionPageState createState() => _SuggestionPageState();
}

class _SuggestionPageState extends State<SuggestionPage> {
  TextEditingController suggestionController = TextEditingController();
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
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: Scaffold(
          body: Column(
            children: [
              SizedBox(
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Icon(
                              Icons.arrow_back_ios,
                              size: 25,
                            ),
                          ),
                          Text(
                            "Submit a Suggestion",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                          )
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Icon(
                          Icons.check,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: suggestionController,
                  cursorColor: Colors.black,
                  autofocus: true,
                  style: TextStyle(fontSize: 16),
                  decoration: InputDecoration(
                    hintText: "Type your suggestion here",
                    labelStyle: TextStyle(fontSize: 16),
                    fillColor: Colors.white,
                    focusColor: Colors.black,
                    focusedBorder: InputBorder.none,
                    border: InputBorder.none,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
