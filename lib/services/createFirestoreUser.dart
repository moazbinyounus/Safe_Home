import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> createFirestoreUser() async {
  User user = FirebaseAuth.instance.currentUser;
  if (user == null) {
    // TODO: Implement null user Popup
  } else {
    await FirebaseFirestore.instance.collection("users").doc(user.uid).set({
      "displayName": user.displayName,
      "uid": user.uid,
    }).catchError((onError) {
      // TODO: FireStore User creation
    });
  }
}
