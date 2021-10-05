import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:safe_home/models/humidityModel.dart';
import 'package:charts_flutter/flutter.dart' as charts;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
class HmdHomePage extends StatefulWidget {
  final  String id;
  HmdHomePage(this.id);
  @override
  _HmdHomePageState createState() {
    return _HmdHomePageState();
  }
}

class _HmdHomePageState extends State<HmdHomePage> {
  List<charts.Series<HumidityModel, double>> _seriesBarData;
  List<HumidityModel> mydata;
  _generateData(mydata) {
    _seriesBarData = List<charts.Series<HumidityModel, double>>();
    _seriesBarData.add(
      charts.Series(

        //domainFn: (TempModel temps, _) => temps.time.toString(),
        domainFn: (HumidityModel hmd, _) => double.parse(hmd.time),//domainFn: (TempModel Temp, _) => Temp.time.toString(),
        measureFn: (HumidityModel hmd, _) => double.parse(hmd.humidity),
        id: 'Temperature',
        data: mydata,
        labelAccessorFn: (HumidityModel row, _) => "${row.time}",
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Temperature')),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.
      collection("finalhmd")
          .orderBy("time", descending: false)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return LinearProgressIndicator();
        } else {
          List<HumidityModel> temp = snapshot.data.docs
              .map((QueryDocumentSnapshot) => HumidityModel.fromMap(QueryDocumentSnapshot.data()))
              .toList();
          return _buildChart(context, temp);
        }
      },
    );
  }
  Widget _buildChart(BuildContext context, List<HumidityModel> data) {
    mydata = data;
    _generateData(mydata);
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Text(
                'Temperature',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10.0,
              ),
              Expanded(
                child: charts.LineChart(_seriesBarData,
                  animate: true,
                  animationDuration: Duration(seconds:2),
                  behaviors: [
                    new charts.PanAndZoomBehavior(),
                    // new charts.DatumLegend(
                    //   entryTextStyle: charts.TextStyleSpec(
                    //       color: charts.MaterialPalette.purple.shadeDefault,
                    //       fontFamily: 'Georgia',
                    //       fontSize: 10),
                    // )


                  ],

                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}