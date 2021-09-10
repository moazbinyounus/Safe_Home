//this file consists of the registration functionality using firebase as the backend database which is a non sql database.
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:safe_home/screens/rooms_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:form_field_validator/form_field_validator.dart';
import '../models/DialogWidget.dart';


class RegistrationScreen extends StatefulWidget {
  static String id = 'registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  GlobalKey<FormState> formKey= GlobalKey<FormState>();
  String email;
  String password;
  bool spinner=false;
  final _auth= FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: spinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            autovalidate: true,
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Flexible(
                  child: Container(
                    height: 200.0,
                    // app logo
                    child: Image.asset('assets/images/logo.png'),
                  ),
                ),
                SizedBox(
                  height: 48.0,
                ),
                TextFormField(
                  validator: MultiValidator(
                      [
                        EmailValidator(errorText: 'Wrong Email'),
                        RequiredValidator(errorText: 'Field empty')
                      ]
                  ),
                  onChanged: (value) {
                    //when user writes the written string will be taken email
                    email=value;
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter your email',
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepPurple, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepPurple, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextFormField(

                  validator: MultiValidator(
                      [
                        MinLengthValidator(8, errorText: 'password must be at least 8 digits long'),
                        RequiredValidator(errorText: 'Field empty')
                      ]
                  ),
                  onChanged: (value) {
                    //entered string will be saved as password
                    password= value;
                  },
                  decoration: InputDecoration(
                    hintText: 'Enter your password',

                    contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepPurple, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepPurple, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 24.0,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                  child: Material(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    elevation: 5.0,
                    child: MaterialButton(
                     //  onPressed: () async {
                     //
                     //  try{
                     //    setState(() {
                     //      spinner = true;
                     //    });
                     //    // the following command will create a new user using email and password. The command used for this is part of the fire auth library
                     //     final user= await _auth.createUserWithEmailAndPassword(email: email, password: password);
                     //      if(user != null){
                     //        //navigating to room screen.
                     //       Navigator.pushNamed(context, RoomScreen.id);
                     //     }
                     //      setState(() {
                     //        spinner=false;
                     //      });
                     //  }
                     //    catch (e){
                     //      print(e);
                     //    }
                     // },
                      onPressed: () async{
                        if(formKey.currentState.validate()){
                          print('validated');
                          try{
                            setState(() {
                              spinner = true;
                            });
                            final newUser= await _auth.createUserWithEmailAndPassword(email: email, password: password);
                            if (newUser != null){
                              Navigator.pushNamed(context, RoomScreen.id);
                            }
                            setState(() {
                              spinner= false;
                            });
                          }
                          catch (e){
                            setState(() {
                              spinner =false;
                            });

                            print(e);
                            String reason=e.toString();
                            showDialog(
                              context: context,
                              builder: (_) => DialogWidget( 'Account already in use' ),
                            );

                          }


                        }
                        else{
                          print('not Validated');
                        }
                      },

                      minWidth: 200.0,
                      height: 42.0,
                      child: Text(
                        'Register',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
