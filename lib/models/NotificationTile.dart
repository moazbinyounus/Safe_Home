import 'package:flutter/material.dart';
import 'package:safe_home/models/delNotification.dart';
import 'package:safe_home/screens/room_detail.dart';
import '../models/dialod_del.dart';


class NotificationTile extends StatelessWidget {

  static String line='noti_tile';
  //final String deviceId;
  final String id;
  final String title;
  final String content;


  NotificationTile(//this.deviceId,
      this.id,
      this.title,
      this.content,
      );


  @override
  Widget build(BuildContext context) {

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(


        child: GestureDetector(



          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Flexible(
                child: Container(
                  //color: Colors.deepPurple,


                  decoration: BoxDecoration(

                    border: Border(
                      bottom: BorderSide(
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  child: ListTile(
                    onLongPress: (){
                      //DelNotification(id);
                    },
                    leading: Text(title),
                    title: Text(
                      '$content',
                      style: TextStyle(
                        //color: Colors.deepPurple,
                        //fontSize: 20,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
              ),



            ],
          ),
        ),

      ),
    );
  }
}
