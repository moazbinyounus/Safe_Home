import 'package:flutter/material.dart';
import 'package:safe_home/screens/login_screen.dart';
import 'package:safe_home/screens/registration_screen.dart';
import 'package:safe_home/screens/rooms_screen.dart';
import 'package:safe_home/screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp().then((value) {
    runApp(MyApp());
    // return null;
  });

}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

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
    super.initState();
    var initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOs = IOSInitializationSettings();
    var initSetttings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOs,
    );

    flutterLocalNotificationsPlugin.initialize(initSetttings,
        onSelectNotification: onSelectNotification);

    FirebaseMessaging.onMessage.listen((RemoteMessage event) async {
      print("message recieved");
      print("Notification data is ${event.data}");
      print(event.notification.body);
      await flutterLocalNotificationsPlugin.show(
        1,
        "${event.notification.title}",
        "${event.notification.body}",
        NotificationDetails(
          android: AndroidNotificationDetails(
            'repeatDailyAtTime channel id',
            'repeatDailyAtTime channel name',
            'repeatDailyAtßime description',
            importance: Importance.max,
            ledColor: Colors.green,
            ledOffMs: 1000,
            ledOnMs: 1000,
            enableLights: true,
          ),
          iOS: IOSNotificationDetails(
              threadIdentifier: 'thread_id',

          ),
        ),
      );
    });
  }//init end
  Future onSelectNotification(String payload) {
    return Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return WelcomeScreen();
    }));
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      initialRoute: FirebaseAuth.instance.currentUser == null
          ? WelcomeScreen.id
          : RoomScreen.id,
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
