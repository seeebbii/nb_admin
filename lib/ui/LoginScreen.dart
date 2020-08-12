import 'dart:convert';
import 'package:awesome_loader/awesome_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:nb_admin/models/User.dart';
import 'package:nb_admin/ui/HomePage.dart';
import 'package:nb_admin/utilities/constant_dart.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'SignupScreen.dart';
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var _emailFieldController = new TextEditingController();
  var _passFieldController = new TextEditingController();

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
          child: TextField(
            controller: _emailFieldController,
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
          child: TextField(
            controller: _passFieldController,
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
        onPressed: loginUser,
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

  // DIALOGS
  AlertDialog loading = AlertDialog(
    backgroundColor: Colors.transparent,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    content: Container(
      decoration: BoxDecoration(
          color: Colors.grey.shade700,
          borderRadius: BorderRadius.circular(15.0)),
      height: 200,
      width: 50,
      child: AwesomeLoader(
        loaderType: AwesomeLoader.AwesomeLoader3,
        color: Colors.purpleAccent.shade100,
      ),
    ),
  );

  AlertDialog error = AlertDialog(
    backgroundColor: Colors.transparent,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    content: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 10.0,
      color: Colors.grey.shade700,
      child: ListTile(
        leading: Icon(Icons.error_outline, color: Colors.purpleAccent.shade100,),
        title: (Text(
            'Invalid credentials!',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w200,
                fontSize: 15)
        )),
      ),
    ),
  );

  AlertDialog success = AlertDialog(
    backgroundColor: Colors.transparent,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    content: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 10.0,
      color: Colors.grey.shade700,
      child: ListTile(
        leading: Icon(Icons.done_outline, color: Colors.purpleAccent.shade100,),
        title: (Text(
            'Login Successful!',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w200,
                fontSize: 15)
        )),
      ),
    ),
  );

  AlertDialog caution = AlertDialog(
    backgroundColor: Colors.transparent,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    content: Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 10.0,
      color: Colors.grey.shade700,
      child: ListTile(
        leading: Icon(Icons.close, color: Colors.purpleAccent.shade100,),
        title: (Text(
            'An error has occurred !',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w200,
                fontSize: 15)
        )),
      ),
    ),
  );

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



  void loginUser() async {
    // Validating text fields
    if(_emailFieldController.text.toString().isNotEmpty && _passFieldController.text.toString().isNotEmpty){
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return loading;
        },
      );

      String email, pass;
      email = _emailFieldController.text.trim();
      pass = _passFieldController.text.trim();

      // Creating a json encoded data to send the data to server
      String jsonObj = jsonEncode(<String, dynamic>{
        'user_email' : email,
        'user_password' : pass,
      });

      String URL = 'https://noobistani.000webhostapp.com/noobistani/admin_login.php';
      http.Response response = await http.post(
        URL,
        headers: <String, String>{'Content-Type' : 'application/json'},
        body: jsonObj,
      );
      // Checkin if the user has successfully logged in
      if(response.statusCode == 200){
        Navigator.of(context).pop();
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return success;
          },
        );
        saveObjectToPreferences(User.fromJson(json.decode(response.body)));
        await Future.delayed(Duration(seconds: 2), (){
          Navigator.of(context).pop();
          // Switch to home page here
          Navigator.of(context).pushReplacement(new MaterialPageRoute(builder: (context){
            return HomePage();
          }));
        });
      } else if(response.statusCode == 401){
        Navigator.of(context).pop();
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return error;
          },
        );
        await Future.delayed(Duration(seconds: 2), (){
          Navigator.of(context).pop();
        });
      }else{
        Navigator.of(context).pop();
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return caution;
          },
        );
        await Future.delayed(Duration(seconds: 2), (){
          Navigator.of(context).pop();
        });
      }
    }else{
      Fluttertoast.showToast(
          msg: "Text fields must not be empty!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  void saveObjectToPreferences(User user) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('id', user.id);
    prefs.setBool('loggedIn', true);
    prefs.setString('name', user.name);
    prefs.setString('email', user.email);
    prefs.setString('imageUrl', user.imageUrl);
  }
}