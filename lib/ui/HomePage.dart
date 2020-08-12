import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nb_admin/drawer/DrawerItems.dart';
import 'package:nb_admin/main.dart';
import 'package:nb_admin/models/User.dart';
import 'package:nb_admin/ui/LoginScreen.dart';
import 'package:nb_admin/ui/ProfilePage.dart';
import 'package:nb_admin/ui/SplashScreen.dart';
import 'package:nb_admin/ui/TournamentsPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'NewsPage.dart';
import 'RosterPage.dart';

class HomePage extends StatefulWidget {
  User user;

//  HomePage({Key key, this.user}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSavedUser();
  }

  int index = 0;
  List<Widget> screens = [
    NewsPage(),
    TournamentsPage(),
    RosterPage(),
    ProfilePage()
  ];

  List<String> screenTitles = [
    "News",
    'Tournaments',
    'Roasters',
    'Profile'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(screenTitles[index]),
        centerTitle: true,
        backgroundColor: Colors.grey.shade900,
        elevation: defaultTargetPlatform == TargetPlatform.android ? 8.0 : 0.0,
      ),
      body: screens[index],
      drawer: DrawerItems(
        onTap: (ctx, i) {
          setState(() {
            index = i;
          });
        },
        user: widget.user,
      ),
    );
  }

  Future<User> getSavedUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String id, name, email, imageUrl;
    id = prefs.getString('id');
    name = prefs.getString('name');
    email = prefs.getString('email');
    imageUrl = prefs.getString('imageUrl');
    User user = new User(id, name, email, imageUrl);
    setState(() {
      widget.user = user;
    });
    return user;
  }

}
