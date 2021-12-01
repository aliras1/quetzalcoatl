import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:frontend/entities/user.dart';
import 'package:frontend/session.dart';
import 'package:frontend/widgets/main_widget.dart';

import 'auth/auth_sqflite_handler.dart';
import 'auth/login_page.dart';

void main() {
  runApp(Phoenix(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CAFF GIF APP',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Session session = Session();
  AuthSqfLiteHandler authSqfLiteHandler = AuthSqfLiteHandler();
  Widget mainWidget = Container(
    color: Colors.black,
    child: Center(
      child: CircularProgressIndicator(
        color: Colors.yellow,
      ),
    ),
  );

  @override
  void initState() {
    super.initState();
    authSqfLiteHandler.retrieveUser().then((authUser) {
      if (authUser != null) {
        var body = new Map<String, dynamic>();
        body['username'] = authUser.username;
        body['password'] = authUser.password;
        session
            .postLogin(
          '/api/login',
          body,
        )
            .then((res) {
          if (res.statusCode == 200) {
            session.updateCookie(res);
            session.get('/api/users/getAuthenticatedUser').then((innerRes) {
              if (innerRes.statusCode == 200) {
                session.updateCookie(innerRes);
                User user =
                    User.fromJson(jsonDecode(utf8.decode(innerRes.bodyBytes)));
                setState(() {
                  mainWidget = MainWidget(session: session, user: user);
                });
              }
            });
          } else {
            authSqfLiteHandler.deleteUsers();
            Fluttertoast.showToast(
                msg:
                    "Something went wrong with the automatic login, please login again!",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
            setState(() {
              mainWidget = LoginPage(
                title: 'Login',
              );
            });
          }
        });
      } else {
        setState(() {
          mainWidget = LoginPage(
            title: 'Login',
          );
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return mainWidget;
  }
}
