import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_admin/models/RostersModel.dart';
import 'package:nb_admin/uploadAdminData/UploadRosters.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';

class RosterPage extends StatefulWidget {
  @override
  _RosterPageState createState() => _RosterPageState();
}

class _RosterPageState extends State<RosterPage> {
  GlobalKey<RefreshIndicatorState> refreshKey;
  List<RostersModel> rostersList = <RostersModel>[];

  @override
  void initState() {
    // TODO: implement initState
    refreshKey = GlobalKey<RefreshIndicatorState>();
    super.initState();
//    readData();
  }

  removeNews(RostersModel obj, int index) async {
    String URL =
        'https://noobistani.000webhostapp.com/noobistani/deleteRoster.php?id=${obj.id}';
    http.Response response = await http.get(URL);
    print(response.body);
    setState(() {
      rostersList.removeAt(index);
    });
  }

  dismissibleBg() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.red,
      ),
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: 15.0),
      child: Icon(Icons.delete),
    );
  }

  Future<Null> refreshList() async {
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      rostersList.reversed;
    });
//    readData();
    return null;
  }

  showSnackBar(context) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text('Roster Removed'),
    ));
  }

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
      body: FutureBuilder(
          future: readData(),
          builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.data.length <= 0) {
                return RefreshIndicator(
                  key: refreshKey,
                  onRefresh: refreshList,
                  child: Center(
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        Shimmer.fromColors(
                          baseColor: Colors.grey,
                          highlightColor: Colors.black54,
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              'Why so empty here? :(',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  letterSpacing: 1.5),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return RefreshIndicator(
                  key: refreshKey,
                  onRefresh: refreshList,
                  child: ListView.builder(
                      itemCount: rostersList.length,
                      padding: new EdgeInsets.all(8.0),
                      reverse: false,
                      shrinkWrap: false,
                      itemBuilder: (_, int index) {
                        return GestureDetector(
                          onTap: () {
                            print(index);
                          },
                          child: Dismissible(
                            background: dismissibleBg(),
                            onDismissed: (direction) {
                              removeNews(rostersList[index], index);
                              showSnackBar(context);
                            },
                            key: Key(rostersList[index].id),
                            child: Card(
                                elevation: 3.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                color: Colors.grey.shade800,
                                child: rostersList[index]),
                          ),
                        );
                      }),
                );
              }
            } else if (snapshot.connectionState == ConnectionState.none) {
              return Center(child: Text('Error')); // error
            } else {
              return Center(child: CircularProgressIndicator()); // loading
            }
          }),
    );
  }

  Future<List> readData() async {
    rostersList.clear();
    String URL =
        'https://noobistani.000webhostapp.com/noobistani/getRosters.php';
    http.Response response = await http.get(URL);
    List test = json.decode(response.body);
//    newsList.add(json.decode(response.body));
    for (var i = 0; i < test.length; i++) {
      RostersModel newsPage = RostersModel(
          test[i]['id'],
          test[i]['name'],
          test[i]['role'],
          test[i]['facebookLink'],
          test[i]['discordLink'],
          test[i]['youtubeLink'],
          test[i]['instaLink'],
          test[i]['twitterLink']);
      rostersList.add(newsPage);
    }
//    print(test.length);
    return rostersList;
  }
}
