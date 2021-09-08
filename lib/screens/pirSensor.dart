import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
FirebaseFirestore _firestore= FirebaseFirestore.instance;
class PirSensor extends StatelessWidget {
  final String room_id;

  PirSensor(this.room_id);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Motion Sensor'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            MessageStream(room_id),
          ],
        ),
      ),

    );
  }
}
class messageBubble extends StatelessWidget {
  messageBubble(this.sender,this.message);
  final String message;
  final String sender;
  //final bool isme;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text('$sender',
              style: TextStyle(
                  color: Colors.white38
              ),),
          ),
          Material(
            color: Colors.deepPurple ,
            borderRadius: BorderRadius.circular(30),

            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
              child: Text('$message $sender',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),),
            ),
          ),
        ],
      ),
    );
  }
}
class MessageStream extends StatelessWidget {
  var now = DateTime.now();
  final String room_id;

  MessageStream(this.room_id);
  
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('pir').snapshots(),
        builder: (context,snapshot){
          if (!snapshot.hasData){
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.deepPurple,
              ),
            );
          }
          final messages=snapshot.data.docs.reversed;
          List<messageBubble> messageList=[];
          for(var message in messages ){
            final textMessage=message.get('message');
            final sender=message.get('timestamp');
            final id=message.get('id');
            DateTime messageDate=DateTime.parse(sender);
            print(textMessage);



if(now.isBefore(messageDate)==true && room_id==id.toString()){

            final singleMessage= messageBubble(sender, textMessage);
            messageList.add(singleMessage);
}

          }
          return Expanded(
            child: ListView(
              children:
              messageList,

            ),
          );

        }
    );
  }
}