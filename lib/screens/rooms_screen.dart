// this screen contains the rooms that a particular user has added
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/room_tile.dart';
import 'addroom_screen.dart';
import 'package:safe_home/services/getToken.dart';

User currentUser;
bool isSwitched;
FirebaseFirestore _firestore= FirebaseFirestore.instance;
class RoomScreen extends StatefulWidget {
  static  String id='rooms_screen';
  @override
  _RoomScreenState createState() => _RoomScreenState();
}
class _RoomScreenState extends State<RoomScreen> {
  final _auth=FirebaseAuth.instance;
  @override

  // here init is used to get current user for further uses
void initState() {
    super.initState();
    getCurrentUser();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      FirebaseMessaging.instance.getToken().then((token) {
        print("Device token $token");

        updateUserTokenInFirebase(
          deviceToken: token,
          userID: FirebaseAuth.instance.currentUser.uid,
        ).then((value) {
          print("Token updated $value");
        }).catchError((onError) {
          print("Update token Error $onError");
        });

      });
    });
  }

  void getCurrentUser()async{
    try{
    final user= await _auth.currentUser;

    if(user != null){
      currentUser = user;
  }}
  catch (e){
      print(e);
  }}

  Widget build(BuildContext context) {
    return
       Scaffold(
        appBar: AppBar(
          //foregroundColor: Colors.blueAccent,
          elevation: 0,

          backgroundColor: Colors.white,
          shadowColor: Colors.white,
          automaticallyImplyLeading: false,

          title: Text('Room Management',
          style: TextStyle(
            color: Colors.deepPurple
          ),),
        ),
        body: SafeArea(
          child: Column(
            children: [
              RoomStream(),
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: FloatingActionButton(onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>AddRoom(currentUser.email)));
                },
                  backgroundColor: Colors.deepPurple,
                child: Icon(Icons.add

                ),
                ),
              )
            ],
          ),
        ),
      );
  }
}

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
          final messages=snapshot.data.docs;
          List<RoomTile> messageList=[];
          for(var message in messages ){
            final roomid=message.get('id');
            final roomname=message.get('name');
            final roomowner=message.get('owner');
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
                crossAxisCount: 2, childAspectRatio: 3/3,crossAxisSpacing: 10,mainAxisSpacing: 10,

              ),
            ),
          );

        }
    );
  }
}