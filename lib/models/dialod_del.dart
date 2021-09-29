import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LogoutOverlay extends StatefulWidget {
  String id;
  LogoutOverlay(String this.id);

  @override
  State<StatefulWidget> createState() => LogoutOverlayState();
}

class LogoutOverlayState extends State<LogoutOverlay>
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
              height: 180.0,
              decoration: ShapeDecoration(
                  //color: Color.fromRGBO(41, 167, 77, 10),
                  color: Colors.deepPurple,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0))),
              child: Column(
                children: <Widget>[
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(
                        top: 30.0, left: 20.0, right: 20.0),
                    child: Text(
                      "Are you sure, you want to delete?",
                      style: TextStyle(color: Colors.white, fontSize: 16.0),
                    ),
                  )),
                  Expanded(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: ButtonTheme(
                            height: 35.0,
                            minWidth: 110.0,
                            child: RaisedButton(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                              splashColor: Colors.white.withAlpha(40),
                              child: Text(
                                'Yes',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black45,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13.0),
                              ),
                              onPressed: () {
                                FirebaseFirestore.instance
                                    .collection("device")
                                    .where("id", isEqualTo: widget.id)
                                    .get()
                                    .then((value) {
                                  value.docs.forEach((element) {
                                    FirebaseFirestore.instance
                                        .collection("device")
                                        .doc(element.id)
                                        .delete()
                                        .then((value) {
                                      print(widget.id);
                                      print("Success!");
                                      Navigator.pop(context);
                                    });
                                  });
                                });
                              },
                            )),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, right: 10.0, top: 10.0, bottom: 10.0),
                          child: ButtonTheme(
                              height: 35.0,
                              minWidth: 110.0,
                              child: RaisedButton(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0)),
                                splashColor: Colors.white.withAlpha(40),
                                child: Text(
                                  'No',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black45,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13.0),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ))),
                    ],
                  ))
                ],
              )),
        ),
      ),
    );
  }
}
