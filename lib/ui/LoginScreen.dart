import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nb_admin/utilities/constant_dart.dart';
import 'package:http/http.dart' as http;
import 'SignupScreen.dart';
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailKey = GlobalKey<FormState>();
  final _passKey  = GlobalKey<FormState>();
  String email, pass;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  Widget _emailFormField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Email',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          height: 60.0,
          decoration: kBoxDecorationStyle,
          alignment: Alignment.center,
          child: Form(
            key: _emailKey,
            child: TextFormField(
              validator: (value){
                if(value.isEmpty){
                  return '*';
                }else{
                  email = value.trim();
                  return null;
                }
              },
              keyboardType: TextInputType.emailAddress,
              style: TextStyle(
                color: Colors.white,
              ),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14.0),
                  prefixIcon: Icon(
                    Icons.email,
                    color: Colors.white,
                  ),
                  hintText: "Enter your Email",
                  hintStyle: kHintTextStyle
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _passwordFormField(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Password',
          style: kLabelStyle,
        ),
        SizedBox(
          height: 10.0,
        ),
        Container(
          height: 60.0,
          decoration: kBoxDecorationStyle,
          alignment: Alignment.center,
          child: Form(
            key: _passKey,
            child: TextFormField(
              validator: (value){
                if(value.isNotEmpty){
                  pass = value;
                  return null;
                }else{
                  return '*';
                }
              },
              obscureText: true,
              style: TextStyle(
                color: Colors.white,
              ),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 14.0),
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Colors.white,
                  ),
                  hintText: "Enter your Password",
                  hintStyle: kHintTextStyle
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _forgotPass() {
    return Container(
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildLoginBtn(),
          FlatButton(
            onPressed: () => print('Forgot Password Button Pressed'),
            padding: EdgeInsets.only(right: 0.0),
            child: Text(
              'Forgot Password?',
              style: TextStyle(
                color: Colors.purpleAccent.shade100,
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget _buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      child: RaisedButton(
        elevation: 5.0,
        onPressed: (){},
        padding: EdgeInsets.all(10.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        ),
        color: Colors.purpleAccent.shade100,
        child: Text(
          'LOGIN',
          style: TextStyle(
            color: Colors.black,
            letterSpacing: 1.5,
            fontSize: 15.0,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }


  Widget _buildSignupBtn() {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context){
          return SignUp();
        }));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 15.0),
        alignment: Alignment.bottomCenter,
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: 'Don\'t have an Account? ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
              TextSpan(
                text: 'Create one',
                style: TextStyle(
                  color: Colors.purpleAccent.shade100,
                  decoration: TextDecoration.underline,
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.dark,
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Stack(
              children: <Widget>[
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.grey.shade600,
                        Colors.grey.shade700,
                        Colors.grey.shade800,
                        Colors.grey.shade900,
                      ],
                      stops: [0.1, 0.4, 0.7, 0.9],
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(15),
                  child: Text(
                    'NOOBISTANI',
                    style: TextStyle(
                        letterSpacing: 2.5,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.2
                    ),
                  ),
                ),
                Container(
                  height: double.infinity,
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                      horizontal: 40.0,
                      vertical: 30.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset('assets/logo/nbLogo.png',
                        height: 150,
                        width: 1000,
                        fit: BoxFit.cover,),
                        _emailFormField(),
                        SizedBox(
                          height: 30.0,
                        ),
                        _passwordFormField(),
                        _forgotPass(),
                        Divider(
                          height: 5.0,
                          color: Colors.grey.shade900,
                          thickness: 1.0,
                        ),
                        _buildSignupBtn(),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}