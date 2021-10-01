
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
bool isSwitched=false;

class PirSwitch extends StatefulWidget {
  final String deviceId;
  PirSwitch(this.deviceId);
  @override
  _PirSwitchState createState() => _PirSwitchState();
}

class _PirSwitchState extends State<PirSwitch> {
  @override
  void initState(){
    print('initworking');
    super.initState();
    getSwitch(widget.deviceId);


  }


  getSwitch(String device_id) async {
    DocumentReference documentReference = FirebaseFirestore.instance.collection('Switch').doc(device_id);
    bool state;
    await documentReference.get().then((snapshot) {
      state = snapshot.get('pir');
      setState(() {
        isSwitched = state==true;
      });
     // isSwitched = state==true;
    });

  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Motion Sensing'),
      ),
      body: Container(
        child: Center(
          // child: Switch(
          //   value: isSwitched,
          //   onChanged: (value) {
          //     setState(() {
          //       isSwitched = value;
          //       print(isSwitched);
          //       print(value);
          //       FirebaseFirestore.instance
          //           .collection("Switch")
          //           .doc(widget.deviceId)
          //           .update({
          //         "pir": value,
          //
          //       }).then((value) {
          //         return "success updated";
          //       }).catchError((onError) {
          //
          //         print('contact added');
          //         return "error";
          //       });
          //     });
          //
          //   },
          //   activeTrackColor: Colors.lightGreenAccent,
          //   activeColor: Colors.green,
          //
          //
          // ),
        ),
      ),
    );
  }
}
