import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
//import 'package:safe_home/screens/player.dart';
import 'package:safe_home/screens/room_detail.dart';
import '../models/dialod_del.dart';



class FaceTile extends StatelessWidget {

  static String line='facetile';
  //final String deviceId;
  final String title;
  final String content;
  final String url;


  FaceTile(//this.deviceId,
      this.title,
      this.content,
      this.url
      );

  Future<String> downloadFile(String url, String fileName, String dir) async {
    HttpClient httpClient = new HttpClient();
    File file;
    String filePath = '';
    String myUrl = '';

    try {
      myUrl = url+'/'+fileName;
      var request = await httpClient.getUrl(Uri.parse(myUrl));
      var response = await request.close();
      if(response.statusCode == 200) {
        var bytes = await consolidateHttpClientResponseBytes(response);
        filePath = '$dir/$fileName';
        file = File(filePath);
        await file.writeAsBytes(bytes);
      }
      else
        filePath = 'Error code: '+response.statusCode.toString();
    }
    catch(ex){
      filePath = 'Can not fetch url';
    }

    return filePath;
  }

  @override
  Widget build(BuildContext context) {

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Card(
        elevation: 10,
        child: GridTile(

          child: GestureDetector(



            child: Container(
              //height: 500,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    //color: Colors.deepPurple,


                    decoration: BoxDecoration(

                      border: Border(
                        // bottom: BorderSide(
                        //   color: Colors.black54,
                        // ),
                      ),
                    ),
                    child: ListTile(
                      //leading: Text(title),
                      title: Text(
                        '$content',
                        style: TextStyle(
                          //color: Colors.deepPurple,
                          //fontSize: 20,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      onTap:  ()async{

                        //downloadFile(url, "video", "/storage/emulated/0/Downloads");
                        //MyVideoScreen();
                        final videoPlayerController =
                        VideoPlayerController.network(url);
                        await videoPlayerController.initialize();

                        final chewieController = ChewieController(
                          videoPlayerController: videoPlayerController,
                          autoPlay: true,
                          looping: true,
                        );
                        showDialog(context: context, builder: (context) {
                          return Card(


                              child: Chewie(
                              controller: chewieController,
                            ),

                          );
                        });


                      }
                    ),
                  ),



                ],
              ),
            ),
          ),

        ),
      ),
    );
  }
}
