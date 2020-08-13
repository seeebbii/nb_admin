import 'dart:convert';
import 'dart:io';
import 'package:awesome_loader/awesome_loader.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:nb_admin/models/NewsModel.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;


class UploadNews extends StatefulWidget {
  @override
  _UploadNewsState createState() => _UploadNewsState();
}

class _UploadNewsState extends State<UploadNews> {
  File imageSelected;
  String base64Image;
  String myDescription;
  var descController = new TextEditingController();
  bool _validate = true;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade800,
      appBar: AppBar(
        backgroundColor: Colors.grey.shade900,
        title: Text('Upload news'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            InkWell(
              onTap: () {
                getImage();
              },
              child: Container(
                padding: const EdgeInsets.all(25),
                child: imageSelected == null
                    ? Image.asset('assets/images/template.png')
                    : Image.file(imageSelected),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(25),
              child: Theme(
                data: new ThemeData(
                  primaryColor: Colors.grey.shade200,
                  primaryColorDark: Colors.purpleAccent,
                ),
                child: new TextField(
                  controller: descController,
                  cursorColor: Colors.purpleAccent.shade100,
                  decoration: new InputDecoration(
                    errorText: _validate ? null : 'Value Can\'t Be Empty',
                    labelText: "Enter Description",
                    focusColor: Colors.purpleAccent,
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                      borderSide: new BorderSide(color: Colors.white),
                    ),
                    //fillColor: Colors.green
                  ),
                  style: new TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontFamily: "Poppins",
                  ),
                ),
              ),
            ),
            RaisedButton(
              onPressed: validate,
              child: Text('Upload'),
            )
          ],
        ),
      ),
    );
  }

  Future getImage() async {
    var tempImage = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      imageSelected = tempImage;
    });
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
        leading: Icon(Icons.done_outline, color: Colors.purpleAccent.shade100,),
        title: (Text(
            'News updloaded Successful!',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w200,
                fontSize: 15)
        )),
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
        leading: Icon(Icons.close, color: Colors.purpleAccent.shade100,),
        title: (Text(
            'An error has occurred !',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w200,
                fontSize: 15)
        )),
      ),
    ),
  );

  uploadData() async {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return loading;
      },
    );
    var dbTimeKey = new DateTime.now();
    var formatDate = new DateFormat('MMM d, yyyy');
    var formatTime = new DateFormat('EEEE, hh:mm aaa');
    String date = formatDate.format(dbTimeKey);
    String time = formatTime.format(dbTimeKey);
    base64Image = base64Encode(imageSelected.readAsBytesSync());

    myDescription = descController.text.toString();
    String jsonObj = jsonEncode(<String, dynamic>{
      'date' : '$date, $time',
      'description' : myDescription,
      'img' : base64Image,
    });

    String URL = 'https://noobistani.000webhostapp.com/noobistani/uploadNews.php';
    http.Response response = await http.post(
      URL,
      body: jsonObj,
    );

    if(response.statusCode == 200){
      Navigator.of(context).pop();
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return success;
        },
      );
      await Future.delayed(Duration(seconds: 2), (){
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      });
    }else if(response.statusCode == 401){
      Navigator.of(context).pop();
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return caution;
        },
      );
      await Future.delayed(Duration(seconds: 2), (){
        Navigator.of(context).pop();
        Navigator.of(context).pop();

      });
    }

  }

  void validate() {
    if(descController.text.isEmpty){
      setState(() {
        _validate = false;
      });
    } else{
      setState(() {
        _validate = true;
      });
      if(imageSelected==null){
        Fluttertoast.showToast(
            msg: "Image cannot be empty!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey,
            textColor: Colors.white,
            fontSize: 16.0);
      }else{
        // upload data
        uploadData();
      }
    }
  }
}
