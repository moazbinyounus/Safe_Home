import 'package:flutter/material.dart';
import 'package:safe_home/screens/room_detail.dart';
import '../models/dialod_del.dart';


class ContactTile extends StatelessWidget {

  static String line='room_tile';
  final String room_id;
  final String contact1;
  final String contact2;

  ContactTile(this.room_id, this.contact1, this.contact2);
  @override
  Widget build(BuildContext context) {

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(



          child: Container(
            color: Colors.white,
            child: Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '$contact1',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  Text(
                    '$contact2',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.normal,
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
