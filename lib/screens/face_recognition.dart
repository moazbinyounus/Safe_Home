import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


FirebaseFirestore _fs = FirebaseFirestore.instance;
class Home extends StatefulWidget {
  final String RoomID;
  Home(this.RoomID);
  @override
  _HomeState createState() => _HomeState();
}

TextEditingController nameController = new TextEditingController();
String name;

class _HomeState extends State<Home> {
  String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white38,
          elevation: 0,
          title: Text('Upload Image',
          style: TextStyle(
            color: Colors.deepPurple
          ),
          ),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: RequiredValidator(errorText: 'Reruired'),
                  //controller: messageTextController,
                  onChanged: (value) {
                    name = value + ".jpg" ;
                  },
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'Enter Name',
                    hintStyle: TextStyle(color: Colors.black26),
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Flexible(
                  child: Container(
                height: 200.0,
                child: (imageUrl != null)
                    ? Image.network(imageUrl)
                    : Placeholder(
                        fallbackHeight: 200.0, fallbackWidth: double.infinity),
              )),
              SizedBox(
                height: 20.0,
              ),


              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),

                child: RaisedButton(
                  child: Text('Select Image and Upload',
                  style: TextStyle(
                    color: Colors.white,
                  ),),
                  color: Colors.deepPurple,
                  onPressed: () => uploadImage(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }




  uploadImage() async {
    final _storage = FirebaseStorage.instance;
    final _picker = ImagePicker();
    PickedFile image;

    //Check Permissions
    await Permission.photos.request();

    var permissionStatus = await Permission.photos.status;

    if (permissionStatus.isGranted) {
      //Select Image
      image = await _picker.getImage(source: ImageSource.gallery);
      var file = File(image.path);

      if (image != null) {
        //Upload to Firebase
        var snapshot =
            await _storage.ref().child('$name').putFile(file);
        // .onComplete;

        var downloadUrl = await snapshot.ref.getDownloadURL();

        _fs.collection('FaceRecognition').doc("1").set({
          'id': widget.RoomID ,
          'name': "$name",
          'link': downloadUrl,
        });


        setState(() {
          imageUrl = downloadUrl;
        });
      } else {
        print('No Path Received');
      }
    } else {
      print('Grant Permissions and try again');
    }
  }
}
