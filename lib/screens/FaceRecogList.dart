import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:safe_home/constants.dart';
import '../models/faceTIle.dart';
import 'face_recognition.dart';
FirebaseFirestore _firestore= FirebaseFirestore.instance;

class FaceRecog extends StatelessWidget {
  String id;
  FaceRecog(this.id);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: TextButton(
        onPressed: (){
          //Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>AddEmergency(room_id)));
          Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>Home(id)));

        },
        child: Icon(Icons.add_circle_outline,color: kThemeColor,size: 30,),
      ),
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.white38,
        title: Text(
          'Face Recognition',
          style: TextStyle(
              color: kThemeColor
          ),
        ),
      ),
      body: Column(
        children: [
          FaceStream(id),
        ],

      ),
    );
  }
}
class FaceStream extends StatelessWidget {
  String id;
  FaceStream(this.id);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('Notification').orderBy('time',descending: true).snapshots(),
        builder: (context,snapshot){
          if (!snapshot.hasData){
            return Center(
              child: LinearProgressIndicator(
                backgroundColor: kThemeColor,
              ),
            );
          }

          final messages=snapshot.data.docs;
          List<FaceTile> messageList=[];
          for(var message in messages ){
            //final deviceId=message.get('device_id');
            final title=message.get('title');
            final content=message.get('content');
            final deviceId=message.get('device_id');
            final url=message.get('VideoLink');
            String devId=deviceId.toString();



            if( devId == id ){
              final singleMessage=FaceTile( title,content,url);
              messageList.add(singleMessage);}

          }


          return Expanded(
            child:  GridView.builder(
              padding: const EdgeInsets.all(10.0),
              itemCount: messageList.length,
              ////
              itemBuilder: (ctx,i)=>FaceTile(messageList[i].title,messageList[i].content,messageList[i].url),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1, childAspectRatio: 8/2,crossAxisSpacing: 5,mainAxisSpacing: 10,

              ),
            ),
          );

        }



    );
  }
}