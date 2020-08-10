import 'package:flutter/material.dart';
import 'package:nb_admin/ui/LoginScreen.dart';

void main(){
  return runApp(
    MaterialApp(
      title: 'NB ADMIN',
      home: MyApp(),
      debugShowCheckedModeBanner: false,
    )
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LoginScreen();
  }
}
