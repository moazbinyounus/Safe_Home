import 'package:flutter/material.dart';
import 'package:safe_home/screens/room_detail.dart';
import '../models/dialod_del.dart';


class ContactTile extends StatelessWidget {

  static String line='room_tile';
  final String room_id;
  final String contact1;
  final String contact2;
  final String address;

  ContactTile(this.room_id, this.contact1, this.contact2,this.address);
  @override
  Widget build(BuildContext context) {

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(



          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(


                decoration: BoxDecoration(

                  border: Border(
                    bottom: BorderSide(
                      color: Colors.black54,
                    ),
                  ),
                ),
                child: ListTile(
                  leading: Icon(
                    Icons.phone,
                    color: Colors.deepPurple,
                  ),
                  title: Text(
                    '$contact1',
                    style: TextStyle(
                      //color: Colors.deepPurple,
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
              Container(

                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.black54,
                    ),
                  ),
                ),
                child: ListTile(
                  leading: Icon(Icons.phone,
                  color: Colors.deepPurple,),
                  title: Text(
                    '$contact2',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
              Container(

                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.black54,
                    ),
                  ),
                ),
                child: ListTile(
                  leading: Icon(Icons.location_on,
                    color: Colors.deepPurple,),

                  title: Text(
                    'Address: $address',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.normal,
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
