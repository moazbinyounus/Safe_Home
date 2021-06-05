import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'

    show Firestore, QuerySnapshot;
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:safe_home/screens/humidity.dart';
import 'package:safe_home/screens/pirSensor.dart';
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

class RoomDetail extends StatelessWidget {
  static String id = 'room_detail';
  final String roomId;
  final String roomName;

  RoomDetail(this.roomName,this.roomId);

  final _firestore = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Room Detail'),
      ),
      drawer: Drawer(
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
                // ...
              },
            ),
            ListTile(
              title: Text('Activate Motion Detection'),
              onTap: () {
                // Update the state of the app.
                Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>PirSensor(roomId)));


                // ...
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
        body: Column(
      children: <Widget>[
        StreamBuilder<QuerySnapshot>(
            stream: _firestore.collection('test1').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              final messages = snapshot.data.documents;

              List<Text> sensordata = [];

              for (var message in messages) {
                final humidity1 = message.data['humidity'];
                final id1= message.data['id'];
                final temp1 = message.data['temp'];

                SensorData s1 = SensorData("Humidity", humidity1);
                // SensorData s2 = SensorData("id", id1);
                SensorData s3 = SensorData("Temperature", temp1);

                dataa.clear();
                dataa2.clear();
                print(roomId);


                if(id1.toString() == roomId){
                  print(roomId);
                  print(id1.toString());
                  print('in loop');

                dataa.add(s1);
                //dataa.add(s2);
                dataa.add(s3);}
              }
              return Expanded(
                child: SfCircularChart(
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
        Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20),
              child: Expanded(
                child: OutlinedButton(
                    child: Text("Temperature"),
                    onPressed: () {
                      //Navigator.pushNamed(context, roomId);
                      Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>Temp(roomId)));

                    }),
                flex: 1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Expanded(
                child: OutlinedButton(
                    child: Text("Humidity"),
                    onPressed: () {
                      //Navigator.pushNamed(context, Humidity.id);
                      Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>Humidity(roomId)));
                    }),
                flex: 1,
              ),
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
