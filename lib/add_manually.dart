// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:teamtext/requests.dart';
//import 'package:klip/currentUser.dart' as currentUser;
import 'constants.dart' as Constants;
import './current_user.dart' as currentUser;

class AddManually extends StatefulWidget {
  const AddManually({Key? key}) : super(key: key);

  @override
  _AddManuallyState createState() => _AddManuallyState();
}

class _AddManuallyState extends State<AddManually> {
  late TextEditingController fName;
  late TextEditingController lName;
  late TextEditingController phone;
  @override
  void initState() {
    super.initState();
    fName = TextEditingController();
    lName = TextEditingController();
    phone = TextEditingController();
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
      child: Scaffold(
        body: Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 10, left: 25, right: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 100),
                  child: Text(
                    "Add a Contact",
                    style: TextStyle(color: Constants.theme.foreground, fontSize: 32),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 2.5,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: TextField(
                        controller: fName,
                        decoration: InputDecoration(
                          labelText: "First Name",
                          labelStyle: TextStyle(fontSize: 13),
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.blue, width: 2.0),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey, width: 2.0),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 2.5,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: TextField(
                        controller: lName,
                        decoration: InputDecoration(
                          labelText: "Last Name",
                          labelStyle: TextStyle(fontSize: 13),
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.blue, width: 2.0),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey, width: 2.0),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 2.5,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: "Phone Number",
                          labelStyle: TextStyle(fontSize: 13),
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.blue, width: 2.0),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.grey, width: 2.0),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        dynamic insertedId = await createUser(fName.text.trim(), lName.text.trim(), "", phone.text.trim());
                        print(await joinTeam("12345", insertedId));
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2.5,
                          height: 45,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Center(
                            child: Text(
                              "Submit",
                              style: TextStyle(color: Constants.theme.background, fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )),
      ),
    );
  }
}
