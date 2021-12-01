import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:frontend/auth/auth_sqflite_handler.dart';
import 'package:frontend/entities/user.dart';

import '../session.dart';

class SettingsWidget extends StatefulWidget {
  final Session session;
  final User user;

  const SettingsWidget({Key? key, required this.session, required this.user}) : super(key: key);

  @override
  _SettingsWidgetState createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends State<SettingsWidget> {
  AuthSqfLiteHandler authSqfLiteHandler = AuthSqfLiteHandler();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: ListView(
        children: [
          SizedBox(
            height: 50,
          ),
          Container(
            color: Colors.yellowAccent,
            child: ListTile(
              leading: Icon(
                Icons.logout,
                color: Colors.black,
              ),
              title: Text(
                'Logout',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              onTap: _onLogoutTap,
            ),
          ),
        ],
      ),
    );
  }

  void _onLogoutTap() {
    widget.session
        .post(
      '/api/logout',
      new Map<String, dynamic>(),
    )
        .then((res) {
      if (res.statusCode == 200) {
        widget.session.updateCookie(res);
        authSqfLiteHandler.deleteUsers();
        Phoenix.rebirth(context);
      }
    });
  }
}
