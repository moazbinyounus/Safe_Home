import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'
    show Firestore, QuerySnapshot;
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:safe_home/screens/Voice_training.dart';
import 'package:safe_home/screens/emergency_contacts.dart';
import 'package:safe_home/screens/humidity.dart';
import 'package:safe_home/screens/pirSensor.dart';
import 'package:safe_home/screens/pir_switch.dart';
import 'package:safe_home/screens/welcome_screen.dart';
import '../models/room_tile.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:safe_home/screens/temperature_chart.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart'
    show Firestore, QuerySnapshot;
import 'package:firebase_auth/firebase_auth.dart';

final _auth = FirebaseAuth.instance;
String report ='Calculating';

class RoomDetail extends StatefulWidget {
  static String id = 'room_detail';
  //String report ='High Humidity, opening a window might help';
  final String roomId;
  final String roomName;
   //bool isSwitched;


  RoomDetail(this.roomName,this.roomId);

  @override
  _RoomDetailState createState() => _RoomDetailState();
}

class _RoomDetailState extends State<RoomDetail> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool isSwitched=false;



  @override
  void initState(){
    //report='calculating';
    print('initworking');
    super.initState();
    getSwitch(widget.roomId);


  }


  getSwitch(String device_id) async {
    DocumentReference documentReference = FirebaseFirestore.instance.collection('Switch').doc(device_id);
    bool state;
    await documentReference.get().then((snapshot) {
      state = snapshot.get('pir');
      setState(() {
        isSwitched = state==true;
      });

    });

  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //automaticallyImplyLeading: false,

        iconTheme: IconThemeData(color: Colors.deepPurple),
        elevation: 0,
        backgroundColor: Colors.white,
        title: Container(
          padding: EdgeInsets.only(left: 70),
          child: Text(widget.roomName,
          style: TextStyle(
            color: Colors.deepPurple
          ),),
        ),
      ),
      drawer: Column(
        children: [
          Expanded(
            child: Drawer(
              // Add a ListView to the drawer. This ensures the user can scroll
              // through the options in the drawer if there isn't enough vertical
              // space to fit everything.
              child: ListView(
                // Important: Remove any padding from the ListView.
                padding: EdgeInsets.zero,
                children: <Widget>[
                  Container(
                    height: 100,
                    child: DrawerHeader(
                      decoration: BoxDecoration(
                        color: Colors.deepPurple,
                      ),
                      child: Center(
                        child: Text('Safe Home',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),),
                      ),
                    ),
                  ),
                  ListTile(

                    title: Text('Emergency Contacts'),
                    onTap: () {
                      // Update the state of the app.
                      Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>EmergencyContacts(widget.roomId)));

                    },
                  ),
                  ListTile(
                    leading: Text('Activate Motion Detection',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.normal
                    ),),
                    trailing: Switch(
                      value: isSwitched,
                      onChanged: (value) {
                        setState(() {
                          isSwitched = value;
                          print(isSwitched);
                          print(value);
                          FirebaseFirestore.instance
                              .collection("Switch")
                              .doc(widget.roomId)
                              .set({
                            "dev_id": widget.roomId,
                            "pir" : value,

                          }).then((value) {
                            return "success updated";
                          }).catchError((onError) {

                            print('contact added');
                            return "error";
                          });
                        });

                      },
                      activeTrackColor: Colors.lightGreenAccent,
                      activeColor: Colors.green,


                    ),
                    onTap: () {
                      // Update the state of the app.
                      //Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>PirSwitch(widget.roomId)));


                      // ...
                    },
                  ),
                  ListTile(
                    title: Text('voice training'),
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>VoiceTraining(widget.roomId)));
                    },
                  ),
                  ListTile(
                    title: Text('Sign out'),
                    onTap: () {
                      // Update the state of the app.
                      // ...
                      _auth.signOut();
                      //Navigator.of(context)push();
                      //Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>WelcomeScreen.id));
                      Navigator.pushNamed(context, WelcomeScreen.id);

                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
        body: Column(

      children: <Widget>[
        Container(child: Text(report,
          style: TextStyle(
            //fontWeight: FontWeight.bold,
              fontSize: 17,
              color: Colors.black87
          ),
        )),


        StreamBuilder<QuerySnapshot> (
            stream: _firestore.collection('test1').orderBy('time', descending: true).limit(1).snapshots(),
            // todo: check for other rooms

            builder: (context, snapshot) {
              if (!snapshot.hasData) {


                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              final messages = snapshot.data.docs;

              //List<Text> sensordata = [];

              for (var message in messages) {
                final humidity1 = message.get('humidity');
                final id1= message.get('id');
                final temp1 = message.get('temp');

                SensorData s1 = SensorData("Humidity", humidity1);
                // SensorData s2 = SensorData("id", id1);
                SensorData s3 = SensorData("Temperature", temp1);

                dataa.clear();
                dataa2.clear();
                print(widget.roomId);
                //report='no data';


                if(id1.toString() == widget.roomId){
                  print(widget.roomId);
                  print(id1.toString());
                  print('in loop');


                  if( temp1 < 40 && humidity1 < 70){
                    report= 'Temperature and Humidity are at Optimum Levels';
                  }
                  else if (temp1 > 40){
                    report = 'Temprature is High';
                  }
                  else if (humidity1 > 70){
                    report = 'Humidity High Chance of Fungus';
                  }
                dataa.add(s1);
                dataa.add(s3);
                }
                if(id1.toString() != widget.roomId){
                  report='No data for this device';
                  print (report);
                }

                print(humidity1);

              }
              return Expanded(
                child: SfCircularChart(


                  //palette: [Colors.green,Colors.red],


                  legend: Legend(
                      overflowMode: LegendItemOverflowMode.wrap,
                      isVisible: true,
                      position: LegendPosition.bottom),
                  series: <RadialBarSeries>[
                    RadialBarSeries<SensorData, String>(
                        dataSource: getSensorData(),

                        xValueMapper: (SensorData sd, _) => sd.sensorName,
                        yValueMapper: (SensorData sd, _) => sd.value,
                        dataLabelSettings: DataLabelSettings(isVisible: true)),
                  ],
                ),
              );
            }),
        //SummaryGenerator(widget.roomId),
        Row(
          children: <Widget>[
            Expanded(
              child: OutlinedButton(
                  child: Text("Temperature"),
                  onPressed: () {
                    //Navigator.pushNamed(context, roomId);
                    Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>Temp(widget.roomId)));

                  }),
              //flex: 1,
            ),
            Expanded(
              child: OutlinedButton(
                  child: Text("Humidity"),
                  onPressed: () {
                    //Navigator.pushNamed(context, Humidity.id);
                    Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>Humidity(widget.roomId)));
                  }),
              //flex: 1,
            ),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        )
      ],
    ));
  }
}

class SensorData {
  String sensorName;
  int value;

  SensorData(this.sensorName, this.value);
}

List<SensorData> dataa = <SensorData>[];

List<SensorData> dataa2 = [];

List<SensorData> getSensorData() {
  for (int i = 0; i < dataa.length; i++) {
    if (i < 3) {
      String x = dataa[i].sensorName;
      int y = dataa[i].value;
      //print(x);
      //print(y);
      SensorData s = SensorData(x, y);
      dataa2.add(s);
    }
  }
  return dataa2;
}
