import 'package:flutter/material.dart';
import 'package:nb_admin/ui/HomePage.dart';
import 'package:nb_admin/ui/LoginScreen.dart';
import 'package:nb_admin/ui/SplashScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool loggedIn;
SharedPreferences prefs;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  return runApp(
    MaterialApp(
      title: 'NB ADMIN',
      home: MyApp(),
      debugShowCheckedModeBanner: false,
    )
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      if(prefs.getBool('loggedIn') == null){
        loggedIn = false;
      }else{
        loggedIn = prefs.getBool('loggedIn');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SplashScreen(loggedIn: loggedIn,);
  }
}



