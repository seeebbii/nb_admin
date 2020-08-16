import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nb_admin/models/TournamentsModel.dart';
import 'package:nb_admin/uploadAdminData/UploadTournaments.dart';
import 'package:shimmer/shimmer.dart';

class TournamentsPage extends StatefulWidget {
  @override
  _TournamentsPageState createState() => _TournamentsPageState();
}

class _TournamentsPageState extends State<TournamentsPage> {
  List<TournamentsModel> tourneyList = <TournamentsModel>[];
  GlobalKey<RefreshIndicatorState> refreshKey;

  @override
  void initState() {
    // TODO: implement initState
    refreshKey = GlobalKey<RefreshIndicatorState>();
    super.initState();
    readData();
  }

  removeTournaments(TournamentsModel obj, int index) async {
    String URL =
        'https://noobistani.000webhostapp.com/noobistani/deleteTournaments.php?id=${obj.id}&image_url=https://noobistani.000webhostapp.com/noobistani/${obj.imageUrl}';
    http.Response response = await http.get(URL);
    print(response.body);
    setState(() {
      tourneyList.removeAt(index);
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
      tourneyList.reversed;
    });
//    readData();
    return null;
  }

  showSnackBar(context) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text('News Removed'),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
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
                      itemCount: tourneyList.length,
//                    padding: new EdgeInsets.all(5.0),
                      reverse: false,
                      shrinkWrap: false,
                      itemBuilder: (_, int index) {
                        return InkWell(
                          onTap: () {
                            print(index);
                          },
                          child: Dismissible(
                            background: dismissibleBg(),
                            onDismissed: (direction) {
                              removeTournaments(tourneyList[index], index);
                              showSnackBar(context);
                            },
                            key: Key(tourneyList[index].id),
                            child: new ListTile(
                              title: tourneyList[index],
                            ),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
            return UploadTournaments();
          }));
        },
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
        backgroundColor: Colors.purpleAccent.shade100,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Future<List> readData() async {
    tourneyList.clear();
    String URL = 'https://noobistani.000webhostapp.com/noobistani/getTournaments.php';
    http.Response response = await http.get(URL);
    List test = json.decode(response.body);
    for (var i = 0; i < test.length; i++) {
      TournamentsModel item = TournamentsModel(test[i]['id'], test[i]['startDate'],
          test[i]['postDate'], test[i]['title'], test[i]['description'],test[i]['image_url'] );
      tourneyList.add(item);
    }
    print(tourneyList.length);
    return tourneyList;
  }
}
