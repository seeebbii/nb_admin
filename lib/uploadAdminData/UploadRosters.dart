import 'package:flutter/material.dart';

class UploadRosters extends StatefulWidget {
  @override
  _UploadRostersState createState() => _UploadRostersState();
}

class _UploadRostersState extends State<UploadRosters> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade900,
        title: Text('Upload news'),
        centerTitle: true,
      ),
    );
  }
}
