import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewsModel extends StatelessWidget {
  String id;
  String date;
  String description;
  String imageUrl;

  NewsModel(this.id, this.date, this.description, this.imageUrl);


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network('https://noobistani.000webhostapp.com/noobistani/$imageUrl', height: 95,width: 95,),
          SizedBox(
            width: 15,
          ),
          Container(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  date,
                  style: TextStyle(
                    fontSize: 13,
                    letterSpacing: 0.4,
                    color: Colors.white24
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  description.length >  35 ? description.substring(0,32) +  "..." : description,
                  maxLines: 1,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontWeight: FontWeight.w500, color: Colors.white),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
