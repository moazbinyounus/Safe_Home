import 'package:flutter/material.dart';
import 'package:safe_home/constants.dart';
import 'package:safe_home/screens/room_detail.dart';
import '../models/dialod_del.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
bool isSwitched;
getSwitch(String device_id) async {
  DocumentReference documentReference = FirebaseFirestore.instance.collection('Switch').doc(device_id);
  bool state;
  await documentReference.get().then((snapshot) {
    state = snapshot.get('pir');
    isSwitched = state==true;
  });

}

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
           // getSwitch(id);

            Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>RoomDetail(roomName,id)));

          },
          onLongPress: (){
            print(id);
            showDialog(
              context: context,
              builder: (_) => LogoutOverlay(id),
            );
          },

          child: Container(
            color: kThemeColor,
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
