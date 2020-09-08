import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:nb_admin/models/NewsModel.dart';
import 'package:nb_admin/uploadAdminData/UploadNews.dart';
import 'package:shimmer/shimmer.dart';


class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  List<NewsModel> newsList = <NewsModel>[];
  GlobalKey<RefreshIndicatorState> refreshKey;

  @override
  void initState() {
    // TODO: implement initState
    refreshKey = GlobalKey<RefreshIndicatorState>();
    super.initState();
//    readData();
  }

  removeNews(NewsModel obj, int index) async {
    String URL =
        'https://noobistani.000webhostapp.com/noobistani/deleteNews.php?id=${obj.id}&image_url=https://noobistani.000webhostapp.com/noobistani/${obj.imageUrl}';
    http.Response response = await http.get(URL);
    print(response.body);
    setState(() {
      newsList.removeAt(index);
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
      newsList.reversed;
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
                      itemCount: newsList.length,
                      padding: new EdgeInsets.all(8.0),
                      reverse: false,
                      shrinkWrap: false,
                      itemBuilder: (_, int index) {
                        return GestureDetector(
                          onTap: (){
                            print(index);
                          },
                          child: Dismissible(
                            background: dismissibleBg(),
                            onDismissed: (direction) {
                              removeNews(newsList[index], index);
                              showSnackBar(context);
                            },
                            key: Key(newsList[index].id),
                            child: Card(
                              elevation: 3.0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              color: Colors.black38,
                              child: new ListTile(
                                title: newsList[index],
                              ),
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
            return UploadNews();
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
    newsList.clear();
    String URL = 'https://noobistani.000webhostapp.com/noobistani/getNews.php';
    http.Response response = await http.get(URL);
    List test = json.decode(response.body);
//    newsList.add(json.decode(response.body));
    for (var i = 0; i < test.length; i++) {
      NewsModel newsPage = NewsModel(test[i]['id'], test[i]['date'],
          test[i]['description'], test[i]['image_url']);
      newsList.add(newsPage);
    }
//    print(test.length);
    return newsList;
  }
}
