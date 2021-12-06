import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../session.dart';

class AddCaffWidget extends StatefulWidget {
  final Session session;

  const AddCaffWidget({Key? key, required this.session}) : super(key: key);

  @override
  _AddCaffWidgetState createState() => _AddCaffWidgetState();
}

class _AddCaffWidgetState extends State<AddCaffWidget> {
  final TextEditingController _titleController = TextEditingController();
  File? _file;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          ListTile(
            title: Text(
              'Add a CAFF file',
              style: TextStyle(
                  color: Colors.yellow,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            color: Colors.yellow,
            height: 40,
            padding: EdgeInsets.all(4),
            child: TextField(
              cursorColor: Colors.black,
              controller: _titleController,
              style: TextStyle(fontSize: 25),
              decoration: new InputDecoration.collapsed(
                  hintText: 'Title of the CAFF file'),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            color: Colors.yellow,
            child: ListTile(
              leading: Icon(
                Icons.add_circle,
                color: Colors.black,
              ),
              title: Text(
                _file == null ? 'Click here to add CAFF file' : _file!.path.split('/').last,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              onTap: _onAddCaffTap,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            color: Colors.yellow,
            child: ListTile(
              title: Container(
                child: Center(
                  child: Text(
                    'Create CAFF file',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              onTap: _onCreateCaffTap,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _onAddCaffTap() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        _file = File(result.files.first.path!);
      });
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
  }

  void _onCreateCaffTap() {
    _file!.readAsBytes().then((caff) {
      dynamic body = <String, String>{
        'title': _titleController.text,
      };
      widget.session
          .sendMultipart('/api/caff', body, caff)
          .then((response) {
        if (response.statusCode == 200) {
          Fluttertoast.showToast(
              msg:
                  "Successful data change, restart the app for the logo change!",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16.0);
          Phoenix.rebirth(context);
          // Navigator.of(context).pop();
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
      });
    });
  }
}
