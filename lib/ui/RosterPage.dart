import 'package:flutter/material.dart';
import 'package:nb_admin/models/RostersModel.dart';

class RosterPage extends StatefulWidget {
  @override
  _RosterPageState createState() => _RosterPageState();
}

class _RosterPageState extends State<RosterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      body: RostersModel('','','','','','',''),
    );
  }
}
