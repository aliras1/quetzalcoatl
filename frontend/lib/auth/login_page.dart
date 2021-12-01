import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend/entities/user.dart';
import 'package:frontend/session.dart';
import 'package:frontend/widgets/main_widget.dart';

import 'auth_sqflite_handler.dart';
import 'auth_user.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _regUsernameController = TextEditingController();
  final _regPasswordController = TextEditingController();
  late bool _loading;
  Session session = Session();
  AuthSqfLiteHandler authSqfLiteHandler = AuthSqfLiteHandler();

  @override
  void initState() {
    super.initState();
    _loading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _loading
          ? Container(
              color: Colors.black,
              child: Center(
                child: CircularProgressIndicator(
                  color: Colors.yellow,
                ),
              ),
            )
          : Container(
              color: Colors.black,
              child: Center(
                child: Container(
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.height * 0.02),
                  width: 600,
                  height: 1000,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Container(
                          padding: EdgeInsets.only(left: 20.0),
                          color: Colors.yellow.withOpacity(0.7),
                          child: TextField(
                            style: TextStyle(color: Colors.black),
                            controller: _usernameController,
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              hintText: 'Username',
                              hintStyle: TextStyle(
                                  color: Colors.black.withOpacity(0.5)),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Center(
                        child: Container(
                          padding: EdgeInsets.only(left: 20.0),
                          color: Colors.yellow.withOpacity(0.7),
                          child: TextField(
                            enableSuggestions: false,
                            autocorrect: false,
                            obscureText: true,
                            style: TextStyle(color: Colors.black),
                            controller: _passwordController,
                            cursorColor: Colors.black,
                            decoration: InputDecoration(
                              hintText: 'Password',
                              hintStyle: TextStyle(
                                  color: Colors.black.withOpacity(0.5)),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Center(
                        child: ButtonTheme(
                          height: 50,
                          minWidth: 300,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.yellow),
                            ),
                            onPressed: _onLoginPressed,
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Center(
                        child: ButtonTheme(
                          height: 50,
                          minWidth: 300,
                          child: ElevatedButton(
                            onPressed: _onRegistrationPressed,
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.yellow),
                            ),
                            child: Text(
                              "Registration",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Future<void> _onLoginPressed() async {
    setState(() {
      _loading = true;
    });
    var body = new Map<String, dynamic>();
    body['username'] = _usernameController.text;
    body['password'] = _passwordController.text;
    session.postLogin('/api/login', body).then((response) {
      if (response.statusCode == 200) {
        session.updateCookie(response);
        session.get('/api/users/getAuthenticatedUser').then((innerRes) {
          if (innerRes.statusCode == 200) {
            session.updateCookie(innerRes);
            User user =
                User.fromJson(jsonDecode(utf8.decode(innerRes.bodyBytes)));
            setState(() {
              _loading = false;
            });
            authSqfLiteHandler.insertUser(AuthUser(
                id: 0,
                username: _usernameController.text,
                password: _passwordController.text));
            Fluttertoast.showToast(
                msg: "Successful login!",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0);

            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      MainWidget(session: session, user: user)),
            );
          }
        });
      } else if (response.statusCode == 401) {
        setState(() {
          _loading = false;
        });
        Fluttertoast.showToast(
            msg: "Wrong credentials!",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      } else {
        setState(() {
          _loading = false;
        });
        Fluttertoast.showToast(
            msg: response.toString(),
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    });
  }

  void _onRegistrationPressed() {
    showDialog(
        context: context,
        useRootNavigator: false,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return _loading
                ? Container(
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Colors.yellow,
                      ),
                    ),
                  )
                : AlertDialog(
                    backgroundColor: Colors.grey.shade900,
                    title: Text(
                      "Registration",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    content: Container(
                      padding: EdgeInsets.all(10),
                      color: Colors.black,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Center(
                            child: Container(
                              padding: EdgeInsets.only(left: 20.0),
                              color: Colors.yellow.withOpacity(0.7),
                              child: TextField(
                                style: TextStyle(color: Colors.black),
                                controller: _regUsernameController,
                                cursorColor: Colors.black,
                                decoration: InputDecoration(
                                  hintText: 'Username',
                                  hintStyle: TextStyle(
                                      color: Colors.black.withOpacity(0.5)),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 5),
                          Center(
                            child: Container(
                              padding: EdgeInsets.only(left: 20.0),
                              color: Colors.yellow.withOpacity(0.7),
                              child: TextField(
                                style: TextStyle(color: Colors.black),
                                controller: _regPasswordController,
                                cursorColor: Colors.black,
                                obscureText: true,
                                decoration: InputDecoration(
                                  hintText: 'Password',
                                  hintStyle: TextStyle(
                                      color: Colors.black.withOpacity(0.5)),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Close',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          _onRegistrationActivatePressed(setState);
                        },
                        child: Text(
                          'Register',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  );
          });
        });
  }

  Future<void> _onRegistrationActivatePressed(StateSetter setState) async {
    setState(() {
      _loading = true;
    });

    /*
    if (response.statusCode == 200) {

      } else if (response.statusCode == 500) {
        setState(() {
          _loading = false;
        });
        if (response.body != null &&
            json.decode(response.body)['message'] != null &&
            json.decode(response.body)['message'] ==
                'Username is already in use!') {
          Fluttertoast.showToast(
              msg: "This username is already in use!",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        } else {
          Fluttertoast.showToast(
              msg: "Something went wrong!",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
      } else {
        setState(() {
          _loading = false;
        });
        Fluttertoast.showToast(
          msg: "Something went wrong!",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    */
    await Future.delayed(Duration(seconds: 3));
    _loading = false;
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _regUsernameController.dispose();
    _regPasswordController.dispose();
    super.dispose();
  }
}
