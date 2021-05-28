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

  RoomDetail(this.roomName);

  final _firestore = Firestore.instance;

  @override
  Widget build(BuildContext context) {



    return
      Scaffold(
        body: Column(children: <Widget>[
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
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
                    // final id1= message.data['id'];
                    final temp1 = message.data['temp'];

                    SensorData s1 = SensorData("Humidity", humidity1);
                    // SensorData s2 = SensorData("id", id1);
                    SensorData s3 = SensorData("Oxygen", temp1);


                    dataa.clear();
                    dataa2.clear();

                    dataa.add(s1);
                    // dataa.add(s2);
                    dataa.add(s3);


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
