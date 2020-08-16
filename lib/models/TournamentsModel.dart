import 'package:awesome_loader/awesome_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer.dart';

class TournamentsModel extends StatefulWidget {
  String id;
  String startDate;
  String postDate;
  String description;
  String title;
  String imageUrl;

  TournamentsModel(this.id, this.startDate, this.postDate,this.title, this.description, this.imageUrl);

  @override
  _TournamentsModelState createState() => _TournamentsModelState();
}

class _TournamentsModelState extends State<TournamentsModel> {
  bool timerClosed = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(3.0),
      ),
      elevation: 8.0,
      margin: const EdgeInsets.only(top: 12.0, left: 25.0, right: 25.0, bottom: 10),
      child: Container(
        color: Colors.grey.shade800,
        padding: const EdgeInsets.all(14.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 10.0,
            ),
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(1.0),
                child: Image.network(
                  'https://noobistani.000webhostapp.com/noobistani/${widget.imageUrl}',
                  fit: BoxFit.cover,
                  height: 250,
                  width: 350,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    } else {
                      return Center(
                        child: AwesomeLoader(
                          loaderType: AwesomeLoader.AwesomeLoader4,
                          color: Color(0xFF61A4F1),
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
            SizedBox(
              height: 15.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Flexible(
                  child: Text(
                    widget.postDate,
                    style: TextStyle(color: Colors.grey, fontSize: 10),
                    textAlign: TextAlign.center,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Starts in: ',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white
                      ),
                    ),
                    timerClosed == true ? Text('Closed', style: TextStyle(color: Colors.purpleAccent.shade100, fontSize: 13),) :
                    CountdownTimer(
                      onEnd: (){
                        setState(() {
                          timerClosed = true;
                        });
                      },
                      endTime: int.parse(widget.startDate),
                      textStyle: TextStyle(fontSize: 15, color: Colors.purpleAccent.shade100),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
              widget.title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Text(
              widget.description,
              style: TextStyle(
                color: Colors.white60
              ),
            )
          ],
        ),
      ),
    );
  }
}
