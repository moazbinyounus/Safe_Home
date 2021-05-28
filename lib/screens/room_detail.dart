import 'package:flutter/material.dart';

import '../models/room_tile.dart';

class RoomDetail extends StatelessWidget {

  static String id='room_detail';
  final String roomName;

  RoomDetail(this.roomName);



  @override
  Widget build(BuildContext context) {
    //final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
   // final Map args = ModalRoute.of(context).settings.arguments;

    return
       Scaffold(
        appBar: AppBar(
          title: Text('$roomName'),
        ),
      );


  }
}


