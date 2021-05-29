import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:safe_home/models/room_tile.dart';
import 'package:safe_home/screens/humidity.dart';
import 'package:safe_home/screens/login_screen.dart';
import 'package:safe_home/screens/registration_screen.dart';
import 'package:safe_home/screens/room_detail.dart';
import 'package:safe_home/screens/rooms_screen.dart';
import 'package:safe_home/screens/welcome_screen.dart';
import 'package:safe_home/screens/temperature_chart.dart';
import 'package:safe_home/screens/humidity.dart';
import 'push_nofitications.dart';

import 'package:firebase_messaging/firebase_messaging.dart';

final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

void main() {
  runApp(MyApp());

}




class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {








  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        RoomScreen.id: (context) => RoomScreen(),
        Temp.id: (context) => Temp(),
        Humidity.id: (context) => Humidity(),

        //RoomDetail.id : (context) => RoomDetail(),
      },
    );
  }
}
