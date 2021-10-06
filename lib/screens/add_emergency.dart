import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:safe_home/models/contactAdded_dialog.dart';
import '../models/DialogWidget.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseFirestore _firestore = FirebaseFirestore.instance;

class AddEmergency extends StatelessWidget {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final String room_id;
  AddEmergency(this.room_id);
  String contact1;
  String contact2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Contacts'
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                validator: MultiValidator(
                    [
                      MinLengthValidator(13, errorText: 'Contact must be in +92********** format '),
                      RequiredValidator(errorText: 'Field empty')
                    ]
                ),
                //controller: messageTextController,
                onChanged: (value) {
                 contact1 = value;
                },
                //keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Enter Contact 1',
                  hintStyle: TextStyle(color: Colors.black26),
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
              TextFormField(
                validator: MultiValidator(
                    [
                      MinLengthValidator(13, errorText: 'Contact must be in +92********** format '),
                      RequiredValidator(errorText: 'Field empty')
                    ]
                ),
                //controller: messageTextController,
                onChanged: (value) {
                  contact2 = value;
                },
                decoration: InputDecoration(
                  hintText: 'Enter Contact 2',
                  hintStyle: TextStyle(color: Colors.black26),
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
                    onPressed: () {
                      if (formKey.currentState.validate()) {
                        print('satisfied');
                        print(room_id);

                        FirebaseFirestore.instance
                            .collection("Emergency")
                            .doc(room_id)
                            .set({
                          "device_id": room_id,
                          "contact1": contact1,
                          "contact2": contact2,
                        }).then((value) {
                          return "success updated";
                        }).catchError((onError) {

                          print('contact added');
                          return "error";
                        });

                        showDialog(

                          context: context,
                          builder: (_) => DialogWidget('Contacts Added !'),

                        );

                      } else {
                        showDialog(
                          // Todo: Dialog box with button navigation
                          context: context,
                          builder: (_) => DialogWidget('Wrong Entry'),
                        );
                      }
                    },
                    minWidth: 200.0,
                    height: 42.0,
                    child: Text(
                      'Add Contacts',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
