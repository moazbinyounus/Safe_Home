import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:safe_home/models/DialogWidget.dart';
import 'package:safe_home/models/humidityModel.dart';
import 'package:charts_flutter/flutter.dart' as charts;

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
DateTime dateToday =new DateTime.now();
String currentDate = dateToday.toString().substring(0,10);

class HmdHomePage extends StatefulWidget {
  final String id;
  final String roomName;
  //final num dev_is ;
  HmdHomePage(this.id, this.roomName);
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
        domainFn: (HumidityModel hmd, _) => double.parse(
            hmd.time), //domainFn: (TempModel Temp, _) => Temp.time.toString(),
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
      appBar: AppBar(title: Text(widget.roomName,

      style:  TextStyle(
          color: Colors.deepPurple
      ),),
      centerTitle: true,
      backgroundColor: Colors.white,
      shadowColor: Colors.white,
      elevation: 0,

      automaticallyImplyLeading: false,
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection("finalhmd")
          .orderBy("time", descending: false).where('pdate', isEqualTo: currentDate).where('id', isEqualTo: widget.id)
          .snapshots(),
      //stream: _firestore.collection('finalhmd').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return LinearProgressIndicator();
        } else {
          final streamer=snapshot.data.docs;
          //List<RoomTile> messageList=[];
          for(var reading in streamer ){
            String roomid=reading.get('id');
            String readingDate=reading.get('pdate');
            String roomId= roomid.toString();
            print('roomid'+roomId);
            print('id from fire'+widget.id);
            // DateTime dateToday =new DateTime.now();
            // String currentDate = dateToday.toString().substring(0,10);
            // print(currentDate);
            print(readingDate);


            //if( roomId == widget.id ){

              List<HumidityModel> temp = streamer
                  .map((QueryDocumentSnapshot) =>
                  HumidityModel.fromMap(QueryDocumentSnapshot.data()))
                  .toList();
              return _buildChart(context, temp);

           // else{print('canceled');}

          }
          return DialogWidget('No Data, Check Device');




          //return _buildChart(context, temp);
        }
      },
    );
  }

  Widget _buildChart(BuildContext context, List<HumidityModel> data) {
    mydata = data;
    _generateData(mydata);
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: SizedBox(
        height: 400,
        width: 500,
        child: Container(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Humidity Graph',
                  style: TextStyle(
                    fontSize: 17.0,
                    //fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Expanded(
                  child: charts.LineChart(
                    _seriesBarData,
                    domainAxis: const charts.NumericAxisSpec(
                      tickProviderSpec: charts.BasicNumericTickProviderSpec(zeroBound: false),
                    ),
                    primaryMeasureAxis: new charts.NumericAxisSpec(tickProviderSpec:
                    new charts.BasicNumericTickProviderSpec(zeroBound: false)),
                    animate: true,
                    animationDuration: Duration(seconds: 2),
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
      ),
    );
  }
}
