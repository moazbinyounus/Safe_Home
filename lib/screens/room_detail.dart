import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'
    show Firestore, QuerySnapshot;
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/room_tile.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart'
    show Firestore, QuerySnapshot;

class RoomDetail extends StatelessWidget {

  static String id='room_detail';
  final String roomName;
  final String roomid;

  RoomDetail(this.roomName,this.roomid);

  final _firestore = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    //final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
   // final Map args = ModalRoute.of(context).settings.arguments;




    return
      Scaffold(
        body: Column(children: <Widget>[
          StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('test1').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final messages = snapshot.data.documents.reversed;

                List<Text> sensordata = [];

                for (var message in messages) {
                  final humidity1 = message.data['humidity'];
                  final id1= message.data['id'];
                  final temp1 = message.data['temp'];
                  // final temp = message.data['Temperature'];
                  // final oxygen = message.data['Oxygen'];
                  // final temp = message.data['Temperature'];
                  // addSensorData("humidity", humidity);
                  // addSensorData("methane", methane);
                  // addSensorData("humidity", oxygen);
                  // addSensorData("oxygen", temp);
                  SensorData s1 = SensorData("Humidity", humidity1);
                  SensorData s2 = SensorData("id", id1);
                  SensorData s3 = SensorData("Oxygen", temp1);
                  // SensorData s4 = SensorData("Temperature", temp);


                  // final messageWidget =
                  //     Text('$humidity $ $');
                  // sensordata.add(messageWidget);

                  dataa.clear();
                  dataa2.clear();

                  dataa.add(s1);
                  dataa.add(s2);
                  dataa.add(s3);
                  // dataa.add(s4);


                }
                return SfCircularChart(
                  legend: Legend(
                      overflowMode: LegendItemOverflowMode.wrap,
                      isVisible: true,
                      position: LegendPosition.bottom),
                  series: <RadialBarSeries>[
                    RadialBarSeries<SensorData, String>(
                        dataSource: getSensorData() ,
                        xValueMapper: (SensorData sd, _) => sd.sensorName,
                        yValueMapper: (SensorData sd, _) => sd.value,
                        dataLabelSettings:
                        DataLabelSettings(isVisible: true)),
                  ],
                );
              }),
          Container(
            child: FloatingActionButton(
              onPressed: () {
                getSensorData();
              },
            ),
          ),
        ]),
      );

  }
}

class SensorData {
  String sensorName;
  int value;

  SensorData(this.sensorName, this.value);
}

List<SensorData> dataa = <SensorData>[];

// void addSensorData(String Sen_name, int valu) {
//   SensorData s = SensorData(Sen_name, valu);
//   dataa.add(s);
//   for (int i = 0; i < 2; i++) {
//     print(dataa[i]);
//   }
// }

List<SensorData> dataa2 = [];

List<SensorData> getSensorData() {
  for (int i = 0; i < dataa.length; i++) {
    if (i < 3){
      String x = dataa[i].sensorName;
      int y = dataa[i].value;
      print(x);
      print (y);
      SensorData s = SensorData(x, y);
      dataa2.add(s);}
  }
  return dataa2;
}

// dynamic getSensorData() {
//   List<SensorData> dataa2 = <SensorData>[];
//   for (int i=0; i < dataa.length; i++){
//     dataa2[i] = dataa[i];
//     print(dataa[i]);
//   }
//   return dataa2;
// }

//
// class SensorData {
//   String sensorName;
//   double value;
//
//   SensorData(this.sensorName, this.value);
// }
//
// dynamic getSensorData(double temp, double methane, double humid, double
// Oxy) {
//   List<SensorData> dataa = <SensorData>[
//     SensorData("Temperature level", temp),
//     SensorData("Methane level", methane),
//     SensorData("Humidity level", humid),
//     SensorData("Oxygen level", Oxy),
//   ];
//
//   return dataa;
// }

////// code for chart

