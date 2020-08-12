import 'package:flutter/material.dart';
import 'package:nb_admin/models/User.dart';
import 'package:nb_admin/ui/LoginScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerItems extends StatelessWidget {
  final Function onTap;
  final User user;

  DrawerItems({this.onTap, this.user});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.grey.shade900,
        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 25),
            ),
            UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.grey.shade900),
              accountName: Text(
                user.name,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              accountEmail: Text(
                user.email,
                style: TextStyle(fontSize: 12),
              ),
              currentAccountPicture: user.imageUrl == 'image name'
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(25.0),
                      child: Image.network(
                        'https://pbs.twimg.com/profile_images/1275457579078922240/BcW-3ekn.jpg',
                      ))
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Image.network(user.imageUrl)),
            ),
            Divider(
              thickness: 1,
              indent: 50,
              endIndent: 50,
              color: Colors.grey,
            ),
            SizedBox(
              height: 15,
            ),
            ListTile(
              leading: Icon(
                Icons.dashboard,
                color: Colors.white,
              ),
              title: Text(
                'News',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 18),
              ),
              onTap: () {
                onTap(context, 0);
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: Icon(
                Icons.personal_video,
                color: Colors.white,
              ),
              title: Text(
                'Tournaments',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 18),
              ),
              onTap: () {
                onTap(context, 1);
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: Icon(
                Icons.people_outline,
                color: Colors.white,
              ),
              title: Text(
                'Rosters',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 18),
              ),
              onTap: () {
                onTap(context, 2);
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: Icon(
                Icons.person_outline,
                color: Colors.white,
              ),
              title: Text(
                'Profile',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 18),
              ),
              onTap: () {
                onTap(context, 3);
                Navigator.of(context).pop();
              },
            ),
            Divider(
              thickness: 1,
              indent: 50,
              endIndent: 50,
              color: Colors.grey,
            ),
            SizedBox(
              height: 20,
            ),
            ListTile(
              leading: Icon(
                Icons.exit_to_app,
                color: Colors.red,
              ),
              title: Text(
                'Log Out',
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w400,
                    fontSize: 18),
              ),
              onTap: (){
                Navigator.of(context).pop();
                logOutHandler(context);
                },
            ),
          ],
        ),
      ),
    );
  }
  void logOutHandler(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('loggedIn', false);
    Navigator.of(context)
        .pushReplacement(new MaterialPageRoute(builder: (context) {
      return LoginScreen();
    }));
  }
}
