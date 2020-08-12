import 'package:flutter/material.dart';
import 'package:nb_admin/main.dart';
import 'package:nb_admin/models/User.dart';
import 'package:nb_admin/ui/LoginScreen.dart';
import 'package:nb_admin/ui/SplashScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<User>(
        future: getSavedUser(),
        builder: (BuildContext context, AsyncSnapshot<User> snapshot){
          return snapshot.hasData ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: Text(snapshot.data.email)),
              Center(
                child: RaisedButton(
                  color: Colors.black,
                  onPressed: logOutHandler,
                  child: Text("Logout", style: TextStyle(
                    color: Colors.white
                  ),),
                ),
              )
            ],
          ) : Center();
        },
      ),
    );
  }

  Future<User> getSavedUser() async{
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


  void logOutHandler() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('loggedIn', false);
    Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (context){
      return LoginScreen();
    }));
  }
}
