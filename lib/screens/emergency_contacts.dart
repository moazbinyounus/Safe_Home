import 'package:flutter/material.dart';
import 'package:safe_home/models/contact_tile.dart';
import 'package:safe_home/screens/add_emergency.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore _firestore= FirebaseFirestore.instance;
class EmergencyContacts extends StatelessWidget {
  final String room_id;
  EmergencyContacts(this.room_id);
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Emergency Contacts'
        ),
      ),
      body: Column(
        children: [
          ContactStream(room_id),

          FloatingActionButton( onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>AddEmergency(room_id)));
          },
              child: Icon(
                Icons.add
              ))
        ],
      ),
    );
  }
}
class ContactStream extends StatelessWidget {
  String room_id;
  ContactStream(this.room_id);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('Emergency').snapshots(),
        builder: (context,snapshot){
          if (!snapshot.hasData){
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.deepPurple,
              ),
            );
          }
          final messages=snapshot.data.docs;
          List<ContactTile> messageList=[];
          for(var message in messages ){
            final device_id=message.get('device_id');
            final contact1=message.get('contact1');
            final contact2=message.get('contact2');


            if( device_id == room_id ){

              final singleMessage=ContactTile( device_id , contact1 , contact2);
              messageList.add(singleMessage);}

          }
          return Expanded(
            child:  GridView.builder(
              padding: const EdgeInsets.all(10.0),
              itemCount: messageList.length,
              itemBuilder: (ctx,i)=>ContactTile(messageList[i].room_id,messageList[i].contact1,messageList[i].contact2),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1, childAspectRatio: 6/6,crossAxisSpacing: 10,mainAxisSpacing: 10,

              ),
            ),
          );

        }
    );
  }
}
