import 'dart:ffi';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:highlight_text/highlight_text.dart';
import 'package:safe_home/screens/rooms_screen.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

FirebaseFirestore _fs = FirebaseFirestore.instance;

class VoiceTraining extends StatefulWidget {
  final String RoomID;
  VoiceTraining(this.RoomID);
  //const VoiceTraining({Key key, this.RoomID}) : super(key: key);

  @override
  _VoiceTrainingState createState() => _VoiceTrainingState();
}

class _VoiceTrainingState extends State<VoiceTraining> {
  stt.SpeechToText _speechToText;
  bool _isListening = false;
  String _text = 'Press the button and start speaking ';
  double confidence = 1.0;
  String word='No word Saved';
  String id;
  @override
  void initState() {
    // TODO: implement initState

    //important hai yeh
    super.initState();
    _speechToText = stt.SpeechToText();
    word = _getTrainedwords();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: Colors.white38,
          elevation: 0,
          title: Text('Voice Training',
          style: TextStyle(
            color: Colors.deepPurple
          ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: AvatarGlow(
          animate: _isListening,
          glowColor: Theme.of(context).primaryColor,
          endRadius: 75.0,
          duration: const Duration(milliseconds: 2000),
          repeatPauseDuration: const Duration(milliseconds: 100),
          repeat: true,
          child: FloatingActionButton(
            onPressed: _listen,
            child: Icon(_isListening ? Icons.mic : Icons.mic_none),
          ),
        ),
        body: Column(children: [
          StreamBuilder<QuerySnapshot>(
              stream: _fs.collection('VoiceTraining').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final messages = snapshot.data.docs;

                for (var message in messages) {
                  var rooid=message.get('id');
                  if(rooid ==widget.RoomID){

                  word = message.get('words');
                  if(word==''){
                    word='No Word Saved';
                  }

                  }

                }

                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text('Previously Saved Words: $word'),
                );
              }),
          SingleChildScrollView(
            reverse: true,
            child: Container(
              padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 150.0),
              child: Text(
                '$_text',
                style: TextStyle(
                  fontSize: 32.0,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          TextButton(onPressed: updateWords, child: Text('Done'))
        ]));
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speechToText.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speechToText.listen(
          onResult: (val) => setState(() {
            _text = val.recognizedWords;
            if (val.hasConfidenceRating && val.confidence > 0) {
              confidence = val.confidence;
            }
          }),
        );
      }
    } else {
      setState(() => _isListening = false);
      _speechToText.stop();
    }
  }

  String _getTrainedwords() {
    _fs.collection('VoiceTraining').get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        var rid=doc['id'];
        if(rid == widget.RoomID){
        print(doc["words"]);
        word = doc["words"];}
        else{
          word='';
        }


      });
    });

    if (word == '') {
      word = 'noting is saved before ';
      return word;
    } else {
      return word;
    }
  }

  void updateWords() {

    if(_text!='Press the button and start speaking '){
    _fs.collection('VoiceTraining').doc(widget.RoomID).set({
      'id': widget.RoomID,
      'words': _text,
    });}
  }
}

