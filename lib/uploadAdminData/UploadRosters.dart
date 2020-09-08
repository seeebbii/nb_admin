import 'package:awesome_loader/awesome_loader.dart';
import 'package:flutter/material.dart';

class UploadRosters extends StatefulWidget {
  @override
  _UploadRostersState createState() => _UploadRostersState();
}

class _UploadRostersState extends State<UploadRosters> {
  @override
  var nameController = new TextEditingController();
  var roleController = new TextEditingController();
  var fbController = new TextEditingController();
  var discordController = new TextEditingController();
  var instaController = new TextEditingController();
  var twitterController = new TextEditingController();
  var youtubeController = new TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade900,
        title: Text('Upload Rosters'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Center(
                        child: Text(
                          'Roster Info',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              decoration: TextDecoration.underline),
                        ),
                      ),
                      TextField(
                        controller: nameController,
                        decoration:
                            InputDecoration(hintText: "Enter name of roster"),
                      ),
                      TextField(
                        controller: roleController,
                        decoration:
                            InputDecoration(hintText: "Enter role of roster"),
                      ),
                      TextField(
                        controller: fbController,
                        decoration: InputDecoration(hintText: "Facebook link"),
                      ),
                      TextField(
                        controller: discordController,
                        decoration: InputDecoration(hintText: "Discord link"),
                      ),
                      TextField(
                        controller: instaController,
                        decoration: InputDecoration(hintText: "Instagram link"),
                      ),
                      TextField(
                        controller: twitterController,
                        decoration: InputDecoration(hintText: "Twitter link"),
                      ),
                      TextField(
                        controller: youtubeController,
                        decoration: InputDecoration(hintText: "Youtube link"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Center(
              child: RaisedButton(
                child: Text('Upload'),
                onPressed: (){},
              ),
            )
          ],
        ),
      ),
    );
  }

  // DIALOGS
  AlertDialog loading = AlertDialog(
    backgroundColor: Colors.transparent,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    content: Container(
      decoration: BoxDecoration(
          color: Colors.grey.shade700,
          borderRadius: BorderRadius.circular(15.0)),
      height: 200,
      width: 50,
      child: AwesomeLoader(
        loaderType: AwesomeLoader.AwesomeLoader3,
        color: Colors.purpleAccent.shade100,
      ),
    ),
  );

  AlertDialog success = AlertDialog(
    backgroundColor: Colors.transparent,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    content: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 10.0,
      color: Colors.grey.shade700,
      child: ListTile(
        leading: Icon(
          Icons.done_outline,
          color: Colors.purpleAccent.shade100,
        ),
        title: (Text('News updloaded Successful!',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w200,
                fontSize: 15))),
      ),
    ),
  );

  AlertDialog caution = AlertDialog(
    backgroundColor: Colors.transparent,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    content: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 10.0,
      color: Colors.grey.shade700,
      child: ListTile(
        leading: Icon(
          Icons.close,
          color: Colors.purpleAccent.shade100,
        ),
        title: (Text('An error has occurred !',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w200,
                fontSize: 15))),
      ),
    ),
  );
}
