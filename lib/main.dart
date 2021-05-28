import 'package:flutter/material.dart';
import 'package:safe_home/models/room_tile.dart';
import 'package:safe_home/screens/login_screen.dart';
import 'package:safe_home/screens/registration_screen.dart';
import 'package:safe_home/screens/room_detail.dart';
import 'package:safe_home/screens/rooms_screen.dart';
import 'package:safe_home/screens/welcome_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      theme: ThemeData(

        primarySwatch: Colors.deepPurple,
      ),
      initialRoute: WelcomeScreen.id,

      routes: {
        WelcomeScreen.id : (context)=> WelcomeScreen(),
        LoginScreen.id : (context)=> LoginScreen(),
        RegistrationScreen.id : (context)=> RegistrationScreen(),
        RoomScreen.id : (context)=> RoomScreen(),


        //RoomDetail.id : (context) => RoomDetail(),

      },

    );
  }
}

