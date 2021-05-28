import 'package:flutter/material.dart';
import 'package:safe_home/screens/room_detail.dart';


class RoomTile extends StatelessWidget {
  static String line='room_tile';
  final String id;
  final String roomName;
  final String owner;
  final List sender=[];
  RoomTile(this.id, this.roomName, this.owner);
  @override
  Widget build(BuildContext context) {

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>RoomDetail(roomName,id)));
           // Navigator.pushNamed(context, RoomDetail.id,
              //arguments: {
              // 'roomName' : roomName,
             // }

           // );


          },
          child: Container(
            color: Colors.deepPurple,
            child: Center(
              child: Text(
                '$roomName',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                    fontWeight: FontWeight.bold,
                ),
              ),
            ),

          ),
        ),

      ),
    );
  }
}
