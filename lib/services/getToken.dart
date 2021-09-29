import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

Future<String> getUserToken({String userID}) async {
  return await FirebaseFirestore.instance
      .collection("users")
      .doc(userID)
      .get()
      .then((user) {
    return user.get("deviceToken");

    // return null;
  }).catchError((onError) {
    return "error";
  });
}

Future<String> updateUserTokenInFirebase(
    {String userID, String deviceToken}) async {
  return await FirebaseFirestore.instance
      .collection("users")
      .doc(userID)
      .update({
    "deviceToken": deviceToken,
  }).then((value) {
    return "sucess";
  }).catchError((onError) {
    return "error";
  });
}
