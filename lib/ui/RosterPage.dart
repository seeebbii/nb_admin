import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_admin/models/RostersModel.dart';
import 'package:nb_admin/uploadAdminData/UploadRosters.dart';

class RosterPage extends StatefulWidget {
  @override
  _RosterPageState createState() => _RosterPageState();
}

class _RosterPageState extends State<RosterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
            return UploadRosters();
          }));
        },
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
        backgroundColor: Colors.purpleAccent.shade100,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      backgroundColor: Colors.grey.shade800,
      body: Padding(
        padding: const EdgeInsets.all(5),
        child: Card(
            elevation: 3.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            color: Colors.grey.shade800,
            child: RostersModel('', '', '', '', '', '', '', '')
        ),
      ),
    );
  }
}
