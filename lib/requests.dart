import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'constants.dart' as Constants;
import 'package:dio/dio.dart';

import 'package:firebase_auth/firebase_auth.dart';

late Response response;
Dio dio = Dio();
Future<String> getToken() async {
  User? firebaseUser = FirebaseAuth.instance.currentUser;
  final tokenID = await firebaseUser!.getIdToken();
  final tokenString = tokenID.toString();
  return tokenString;
}

Future<String> createUser(String fName, String lName, String email, String pNumber) async {
  Response response;
  try {
    Map<String, String> params = {
      "fName": fName,
      "lName": lName,
      "email": email,
      "pNumber": pNumber,
    };

    String reqString = Constants.nodeURL + "api/createUser";
    print("Sending Request To: " + reqString);
    response = await dio.post(reqString, data: params);

    if (response.statusCode == 200) {
      return response.data["insertedId"];
    } else {
      print("Returned error " + response.statusCode.toString());
      return "FailedToCreateUser";
    }
  } catch (err) {
    print("Ran Into Error! createUser => " + err.toString());
  }
  return "FailedToCreatedUser";
}

Future<dynamic> removeUser(String mid) async {
  //mid is the unique mongo id
  //removes user from the user list (deletes them completely) in the server
  Response response;
  try {
    Map<String, String> params = {
      "mid": mid,
    };

    String reqString = Constants.nodeURL + "api/removeUser";
    print("Sending Request To: " + reqString);
    response = await dio.post(reqString, data: params);

    if (response.statusCode == 200) {
      print(response.data);
      return response.data;
    } else {
      print("Returned error " + response.statusCode.toString());
      return "FailedToRemoveUser";
    }
  } catch (err) {
    print("Ran Into Error! removeUser => " + err.toString());
  }
  return "FailedToRemoveUser";
}

Future<dynamic> joinTeam(String tid, String mid) async {
  //tid is the team id
  //mid is the unique mongo id that mongo provides
  //Adds the mid specified (usually gotten when just added using /createUser) to the memebers list of the team with tid
  Response response;
  try {
    Map<String, String> params = {
      "tid": tid,
      "mid": mid,
    };

    String reqString = Constants.nodeURL + "api/joinTeam";
    print("Sending Request To: " + reqString);
    response = await dio.post(reqString, data: params);

    if (response.statusCode == 200) {
      return "JoinedTeam";
    } else {
      print("Returned error " + response.statusCode.toString());
      return "FailedToJoinTeam";
    }
  } catch (err) {
    print("Ran Into Error! joinTeam => " + err.toString());
  }
  return "FailedToJoinTeam";
}

Future<dynamic> getTeamMembers(String tid) async {
  //tid is the team id
  //mid is the unique mongo id that mongo provides
  //Function adds the mid specified (usually gotten when just added using /createUser) to the memebers list of the team with tid
  Response response;
  try {
    Map<String, String> params = {
      "tid": tid,
    };

    String reqString = Constants.nodeURL + "api/getTeamMembers";
    print("Sending Request To: " + reqString);
    response = await dio.post(reqString, data: params);

    if (response.statusCode == 200) {
      return response.data;
    } else {
      print("Returned error " + response.statusCode.toString());
      return "FailedToGetTeamMembers";
    }
  } catch (err) {
    print("Ran Into Error! getTeamMembers => " + err.toString());
  }
  return "FailedToGetTeamMembers";
}
