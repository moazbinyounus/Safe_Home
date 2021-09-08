//this file contains the ui of welcome screen as well as navigation to login and registration page. this page uses custom font and 2 buttons.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'login_screen.dart';
import 'registration_screen.dart';
//import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:safe_home/push_nofitications.dart';

class WelcomeScreen extends StatefulWidget {
  static String id  = 'welcome_screen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  // final Firestore _db= Firestore.instance;
  // final FirebaseMessaging _firebasemessaging = FirebaseMessaging();
  //
  // PushNotificationsManager p= PushNotificationsManager();
@override
  void initState() {
    // TODO: implement initState
    super.initState();


  }


  @override
  Widget build(BuildContext context) {

    // _firebasemessaging.setAutoInitEnabled(true);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  //will contain the logo of the app
                  child: Image.asset('images/logo.png'),
                  height: 60.0,
                ),
                Text(
                  'Safe Home',
                  style: TextStyle(
                    // font for the app name
                    fontFamily: 'NunitoSans',
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            //to give sepration between app name and buttons
            SizedBox(
              height: 48.0,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                elevation: 5.0,
                color: Colors.deepPurple,
                borderRadius: BorderRadius.circular(30.0),
                child: MaterialButton(
                  onPressed: () {
                    //navigation to login screen this is done used named routes
                    Navigator.pushNamed(context, LoginScreen.id);

                    //Go to login screen.
                  },
                  minWidth: 200.0,
                  height: 42.0,
                  child: Text(
                    'Log In',
                    style: TextStyle(
                      color: Colors.white
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.circular(30.0),
                elevation: 5.0,
                child: MaterialButton(
                  onPressed: () {
                    //Go to registration screen using names routes
                    Navigator.pushNamed(context, RegistrationScreen.id);
                  },
                  minWidth: 200.0,
                  height: 42.0,
                  child: Text(
                    'Register',
                    style: TextStyle(
                      color: Colors.white
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
