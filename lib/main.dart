import 'package:flutter/material.dart';
import 'package:safe_home/screens/login_screen.dart';
import 'package:safe_home/screens/registration_screen.dart';
import 'package:safe_home/screens/rooms_screen.dart';
import 'package:safe_home/screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  //function to initialize flutter
  void initializeFlutterFire() async {
    try {
      await Firebase.initializeApp();
    } catch(e) {
      print('error connecting to firebase');
    }
  }
  @override
  // init is called for running firebase initialization function first.
  void initState() {
    // calling firebase initializing function
    initializeFlutterFire();
    super.initState();
  }

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
        //Temp.id: (context) => Temp(),
        //Humidity.id: (context) => Humidity(),

        //RoomDetail.id : (context) => RoomDetail(),
      },
    );
  }
}
