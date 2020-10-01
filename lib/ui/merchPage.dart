import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
class MerchPage extends StatefulWidget {
  @override
  _MerchPageState createState() => _MerchPageState();
}

class _MerchPageState extends State<MerchPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            leading: IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: Icon(
                Icons.menu,
                size: 25,
              ),
            ),
            backgroundColor: Colors.grey.shade900,
            elevation: defaultTargetPlatform == TargetPlatform.android ? 8.0 : 0.0,
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.directions_car)),
                Tab(icon: Icon(Icons.directions_transit)),
                Tab(icon: Icon(Icons.directions_bike)),
              ],
            ),
            title: Text('Merchandise'),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
            },
            child: Icon(
              Icons.add,
              color: Colors.black,
            ),
            backgroundColor: Colors.purpleAccent.shade100,
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          body: TabBarView(
            children: [
              Icon(Icons.directions_car),
              Icon(Icons.directions_transit),
              Icon(Icons.directions_bike),
            ],
          ),
        ),
      ),
    );
  }
}


