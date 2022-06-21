//this dialog is used for displaying feedback when credentials entered have no account registered
import 'package:flutter/material.dart';
import 'package:safe_home/constants.dart';

class EmailPassword extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => EmailPasswordState();
}



class EmailPasswordState extends State<EmailPassword>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Container(
              margin: EdgeInsets.all(20.0),
              padding: EdgeInsets.all(15.0),
              height: 120.0,

              decoration: ShapeDecoration(
                //color: Color.fromRGBO(41, 167, 77, 10),
                  color: kThemeColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0))),
              child: Column(
                children: <Widget>[
                  Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 30.0, left: 20.0, right: 20.0),
                        child: Text(
                          "Wrong Email or Password",
                          style: TextStyle(color: Colors.white, fontSize: 16.0),
                        ),
                      )),

                ],
              )),
        ),
      ),
    );
  }
}