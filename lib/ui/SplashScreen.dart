import 'package:flutter/material.dart';
import 'package:nb_admin/main.dart';
import 'package:nb_admin/ui/LoginScreen.dart';
import 'package:shimmer/shimmer.dart';

import 'HomePage.dart';

class SplashScreen extends StatefulWidget {

  bool loggedIn;
  SplashScreen({Key key, this.loggedIn}) : super(key : key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  Future<bool> checkLoggedInUser() async {
    await Future.delayed(Duration(seconds: 3), );
    return widget.loggedIn;
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLoggedInUser().then((status){
      if(status){
        navigateToHome();
      }else{
        navigateToLogin();
      }
    });
  }

  void navigateToHome(){
    Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (context){
      return HomePage();
    }));
  }
  void navigateToLogin(){
    Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (context){
      return LoginScreen();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.grey.shade900.withOpacity(1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/logo/nbLogo.png',
              height: 400,
              width: 1000,
              fit: BoxFit.cover,
            ),
            Shimmer.fromColors(
                child: Container(
                  child: Text(
                    'NOOBISTANI',
                    style: TextStyle(
                      fontFamily: 'Chilanka',
                      fontSize: 20,
                      letterSpacing: 2.5,
                    ),
                  ),
                ),
                baseColor: Colors.grey,
                highlightColor: Colors.black54),
          ],
        ),
      ),
    );
  }
}

