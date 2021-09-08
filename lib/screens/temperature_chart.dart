

import 'package:safe_home/main.dart';
import 'package:flutter/material.dart';
import 'room_detail.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';


final FirebaseFirestore _firestore = FirebaseFirestore.instance;



class Temp extends StatelessWidget {
  //const Temp({Key key}) : super(key: key);
  final  String id;
  Temp(this.id);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('Temperature'),
      ),
      body: SafeArea(
        child: Column(children: <Widget>[




          StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('finaltemp').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(

                      child: CircularProgressIndicator(),
                    );
                  }

                  final messages = snapshot.data.docs.reversed;

                  List<Text> sensordata = [];
                  dataa.clear();
                  dataa2.clear();

                  for (var message in messages) {



                    String temp = message.get('temp');
                    String time = message.get('time');
                    int userId=message.get('id');
                    String useridstring=userId.toString();

                    double timeInMin = double.parse(time);

                    double tempInDouble =  double.parse(temp);
                    if(useridstring==id) {
                    SensorData s = SensorData(tempInDouble , timeInMin);

                    // dataa.clear();
                    // dataa2.clear();
                    print(id);
                    print(userId.toString());

                      print('in loop temp');
                      print(id);
                      print(userId.toString());
                      dataa.add(s);
                    }

                  }
                  return

                     SfCartesianChart(
                       //backgroundColor: Colors.deepPurple,
                       //borderColor: Colors.deepOrange,
                       //plotAreaBackgroundColor: Colors.deepOrange,
                       //plotAreaBorderColor: Colors.deepOrange,





                        zoomPanBehavior: ZoomPanBehavior(
                            enableDoubleTapZooming: true,
                            enablePanning: true,
                            zoomMode: ZoomMode.x
                        ) ,

                        title: ChartTitle(text: "Temperature"),
                        primaryXAxis: NumericAxis(title: AxisTitle(text: 'Time(Hours.minutes)')),
                        primaryYAxis: NumericAxis(title: AxisTitle(text: 'Celcius')),
                        series: <ChartSeries>[
                          ColumnSeries<SensorData, double>(
                            dataSource: getSensorData(),
                            xValueMapper: (SensorData sd, _) => sd.value,
                            yValueMapper: (SensorData sd, _) => sd.time,
                            dataLabelSettings: DataLabelSettings(
                              isVisible: false,
                            ),
                          )]
                  );

                }),

           SizedBox(height: 20,
            ),















          

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
    //print(x);
    //print(y);
    SensorData s = SensorData(x, y);
    dataa2.add(s);
    }
    return dataa2;
    }




