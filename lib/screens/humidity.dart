import 'package:safe_home/main.dart';
import 'package:flutter/material.dart';
import 'room_detail.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

final _firestore = Firestore.instance;

class Humidity extends StatelessWidget {
  const Humidity({Key key}) : super(key: key);
  static String id = 'humidity_screen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Humidity'),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('finaltemp').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    // snapshot.data.documents.forEach((element) { })
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  final messages = snapshot.data.documents.reversed;

                  List<Text> sensordata = [];

                  for (var message in messages) {
                    String temp = message.data['temp'];
                    String time = message.data['time'];

                    double timeInMin = double.parse(time);

                    double tempInDouble = double.parse(temp);

                    SensorData s = SensorData(tempInDouble, timeInMin);

                    // dataa.clear();
                    // dataa2.clear();

                    dataa.add(s);
                  }
                  return SfCartesianChart(
                      zoomPanBehavior: ZoomPanBehavior(
                          enableDoubleTapZooming: true,
                          enablePanning: true,
                          zoomMode: ZoomMode.x),
                      title: ChartTitle(text: "Humidity"),
                      primaryXAxis: NumericAxis(
                          title: AxisTitle(text: 'Time(Hours.minutes)')),
                      primaryYAxis:
                          NumericAxis(title: AxisTitle(text: 'Percentage')),
                      series: <ChartSeries>[
                        ColumnSeries<SensorData, double>(
                          dataSource: getSensorData(),
                          xValueMapper: (SensorData sd, _) => sd.value,
                          yValueMapper: (SensorData sd, _) => sd.time,
                          dataLabelSettings: DataLabelSettings(
                            isVisible: false,
                          ),
                        )
                      ]);
                }),
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
    );
  }
}

class SensorData {
  double time;
  double value;

  SensorData(this.time, this.value);
}

List<SensorData> dataa = <SensorData>[];

List<SensorData> dataa2 = [];

List<SensorData> getSensorData() {
  for (int i = 0; i < dataa.length; i++) {
    double x = dataa[i].time;
    double y = dataa[i].value;
    print(x);
    print(y);
    SensorData s = SensorData(x, y);
    dataa2.add(s);
  }
  return dataa2;
}
