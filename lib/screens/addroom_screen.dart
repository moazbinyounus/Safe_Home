import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
Firestore _firestore= Firestore.instance;
class AddRoom extends StatelessWidget {
  final String owner;
  AddRoom(this.owner);
 String device_id;
 String RoomName;
  final messageTextController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Room'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [


            TextField(
              //controller: messageTextController,
              onChanged: (value){
                device_id=value;
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Enter Device ID',
                hintStyle: TextStyle(

                    color: Colors.black26
                ),


                contentPadding:
                EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                  BorderSide(color: Colors.deepPurple, width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                  BorderSide(color: Colors.deepPurple, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              //controller: messageTextController,
              onChanged: (value){
                RoomName=value;
              },
              decoration: InputDecoration(
                hintText: 'Give name to your device',
                hintStyle: TextStyle(

                    color: Colors.black26
                ),


                contentPadding:
                EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                  BorderSide(color: Colors.deepPurple, width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                  BorderSide(color: Colors.deepPurple, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),

                ),
              ),

            ),
            SizedBox(
              height: 20,
            ),
      Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: Material(
          color: Colors.deepPurple,
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
          elevation: 5.0,
          child: MaterialButton(
            onPressed: ()  {
              //messageTextController.clear();

              _firestore.collection('device').add({'id' : device_id , 'name' : RoomName,
                'owner' : owner});


            },
            minWidth: 200.0,
            height: 42.0,
            child: Text(
              'Add Room',
              style: TextStyle(
                color: Colors.white
              ),
            ),
          ),
        ),
      ),

          ],
        ),
      ),
      
    );
  }
}
