

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/room_tile.dart';

FirebaseUser currentUser;
Firestore _firestore= Firestore.instance;
class RoomScreen extends StatefulWidget {
  static  String id='rooms_screen';
  @override
  _RoomScreenState createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  final _auth=FirebaseAuth.instance;


  @override
void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser()async{
    try{
    final user= await _auth.currentUser();

    if(user != null){
      currentUser = user;
  }}
  catch (e){
      print(e);
  }
  }
  Widget build(BuildContext context) {
    return
       Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          shadowColor: Colors.white,

          title: Center(
            child: Text('Room Management',
            style: TextStyle(
              color: Colors.deepPurple
            ),),
          ),
        ),
        body: Column(
          children: [
            RoomStream(),
          ],
        ),
      );
  }
}

//class RoomTile extends StatelessWidget {
 // RoomTile(this.id,this.name,this.owner);
  //final String id;
 // final String owner;
 // final String name;

 // @override
 // Widget build(BuildContext context) {
 //   return Padding(
   //   padding: EdgeInsets.all(10.0),
   //   child: Column(
     //   crossAxisAlignment: CrossAxisAlignment.start,
    //    children: [
     //     Padding(
     //       padding: const EdgeInsets.all(5.0),
     //       child: Container(
      //        color: Colors.deepPurple,
      //        child: Text('$name',
      //          style: TextStyle(
       //           color: Colors.white,

       //         ),
                
      //        ),
        //    ),
        //  ),

     //   ],
    //  ),
   // );
 // }
//}
class RoomStream extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('device').snapshots(),
        builder: (context,snapshot){
          if (!snapshot.hasData){
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.deepPurple,
              ),
            );
          }
          final messages=snapshot.data.documents;
          List<RoomTile> messageList=[];
          for(var message in messages ){
            final roomid=message.data['id'];
            final roomname=message.data['name'];
            final roomowner=message.data['owner'];
            final currentLogger=currentUser.email;

            if( currentLogger == roomowner ){

            final singleMessage=RoomTile( roomid , roomname, roomowner);
            messageList.add(singleMessage);}

          }
          return Expanded(
            child:  GridView.builder(
              padding: const EdgeInsets.all(10.0),
              itemCount: messageList.length,
              itemBuilder: (ctx,i)=>RoomTile(messageList[i].id,messageList[i].roomName,messageList[i].owner),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 3/2,crossAxisSpacing: 10,mainAxisSpacing: 10,

              ),
            ),
          );

        }
    );
  }
}