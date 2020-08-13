import 'package:flutter/material.dart';

class UploadTournaments extends StatefulWidget {
  @override
  _UploadTournamentsState createState() => _UploadTournamentsState();
}

class _UploadTournamentsState extends State<UploadTournaments> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade900,
        title: Text('Upload Tournaments'),
        centerTitle: true,
      ),
    );
  }
}
