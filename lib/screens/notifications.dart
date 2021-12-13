import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:safe_home/models/DialogWidget.dart';
import 'package:safe_home/models/NotificationTile.dart';
import 'package:safe_home/models/delNotification.dart';

FirebaseFirestore _firestore= FirebaseFirestore.instance;

class Notifications extends StatelessWidget {
  String id;
  Notifications(this.id);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: TextButton(
        onPressed: (){
          showDialog(
            context: context,
            builder: (_) => DelNotification(id),
          );
          //Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>AddEmergency(room_id)));

        },
        child: Icon(Icons.delete,color: Colors.deepPurple,size: 30,),
      ),
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.white38,
        title: Text(
          'Notfications',
          style: TextStyle(
              color: Colors.deepPurple
          ),
        ),
      ),
      body: Column(
        children: [
          NotificationStream(id),
        ],

      ),
    );
  }
}
class NotificationStream extends StatelessWidget {
  String id;
  NotificationStream(this.id);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('messages').orderBy('time',descending: true).snapshots(),
        builder: (context,snapshot){
          if (!snapshot.hasData){
            return Center(
              child: LinearProgressIndicator(
                backgroundColor: Colors.deepPurple,
              ),
            );
          }

            final messages=snapshot.data.docs;
            List<NotificationTile> messageList=[];
            for(var message in messages ){
              //final deviceId=message.get('device_id');
              final title=message.get('title');
              final content=message.get('content');
              final deviceId=message.get('device_id');



              if( deviceId== id ){


                final singleMessage=NotificationTile( deviceId,title,content);
                messageList.add(singleMessage);}


            }


                return Expanded(
                  child:  GridView.builder(
                    padding: const EdgeInsets.all(10.0),
                    itemCount: messageList.length,
                    itemBuilder: (ctx,i)=>NotificationTile(messageList[i].id,messageList[i].title,messageList[i].content),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1, childAspectRatio: 8/2,crossAxisSpacing: 5,mainAxisSpacing: 10,

                    ),
                  ),
                );

            }



    );
  }
}