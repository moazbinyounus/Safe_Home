import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:safe_home/models/tempModel.dart';
import 'package:charts_flutter/flutter.dart' as charts;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;
class TempHomePage extends StatefulWidget {
  final  String id;
  final String roomName;
  TempHomePage(this.id,this.roomName);
  @override
  _TempHomePageState createState() {
    return _TempHomePageState();
  }
}

class _TempHomePageState extends State<TempHomePage> {
  List<charts.Series<TempModel, double>> _seriesBarData;
  List<TempModel> mydata;
  _generateData(mydata) {
    _seriesBarData = List<charts.Series<TempModel, double>>();
    _seriesBarData.add(
      charts.Series(

        //domainFn: (TempModel temps, _) => temps.time.toString(),
        domainFn: (TempModel temps, _) => double.parse(temps.time),//domainFn: (TempModel Temp, _) => Temp.time.toString(),
        measureFn: (TempModel temps, _) => double.parse(temps.temp),
        id: 'Temperature',
        data: mydata,
       labelAccessorFn: (TempModel row, _) => "${row.time}",
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.roomName,

      style: TextStyle(
          color: Colors.deepPurple
      ),),
      automaticallyImplyLeading: false,
      centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.
        collection("finaltemp")
        .orderBy("time", descending: false)
        .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return LinearProgressIndicator();
        } else {
          List<TempModel> temp = snapshot.data.docs
              .map((QueryDocumentSnapshot) => TempModel.fromMap(QueryDocumentSnapshot.data()))
              .toList();
          return _buildChart(context, temp);
        }
      },
    );
  }
  Widget _buildChart(BuildContext context, List<TempModel> data) {
    mydata = data;
    _generateData(mydata);
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: SizedBox(
        height: 400,
        width: 500,
        child: Container(
          child: Center(
            child: Column(
              children: <Widget>[
                Text(
                  'Temperature Graph',
                  style: TextStyle(fontSize: 17.0,
                      //fontWeight: FontWeight.bold
                  ),
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
                      new charts.LinePointHighlighter(
                          showHorizontalFollowLine:
                          charts.LinePointHighlighterFollowLineType.none,
                          showVerticalFollowLine:
                          charts.LinePointHighlighterFollowLineType.nearest),
                      // Optional - By default, select nearest is configured to trigger
                      // with tap so that a user can have pan/zoom behavior and line point
                      // highlighter. Changing the trigger to tap and drag allows the
                      // highlighter to follow the dragging gesture but it is not
                      // recommended to be used when pan/zoom behavior is enabled.
                      new charts.SelectNearest(eventTrigger: charts.SelectionTrigger.tapAndDrag)


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