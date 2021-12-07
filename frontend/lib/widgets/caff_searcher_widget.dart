import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/entities/caff_file.dart';
import 'package:frontend/entities/user.dart';
import 'package:frontend/session.dart';
import 'package:frontend/toast.dart';

import 'gif_widget.dart';

class CaffSearcherWidget extends StatefulWidget {
  final Session session;
  final User user;

  const CaffSearcherWidget({required this.session, required this.user});

  @override
  _CaffSearcherWidgetState createState() => _CaffSearcherWidgetState();
}

class _CaffSearcherWidgetState extends State<CaffSearcherWidget> {
  final TextEditingController _searchFieldController = TextEditingController();
  List<CaffFile> _caffTitles = [];
  TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getAllCaffs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        title: Container(
          height: 40,
          padding: EdgeInsets.only(left: 5, right: 5),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.white,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: Row(
            children: [
              Flexible(
                child: TextField(
                  controller: _searchFieldController,
                ),
                flex: 8,
              ),
              Flexible(
                child: IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                  onPressed: _onSearchButtonPressed,
                ),
                flex: 1,
              ),
            ],
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: _caffTitles.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.image),
            title: Text(_caffTitles[index].title),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  child: Icon(Icons.edit),
                  onTap: () {
                    _onEditTap(index);
                  },
                ),
                InkWell(
                  child: Icon(Icons.delete),
                  onTap: () {
                    _onDeleteTap(index);
                  },
                ),
              ],
            ),
            onTap: () {
              _selectGif(index);
            },
          );
        },
      ),
    );
  }

  void _onSearchButtonPressed() {
    if (_searchFieldController.text.isEmpty) {
      _getAllCaffs();
    } else {
      widget.session
          .get('/api/caff/searchByName/' + _searchFieldController.text)
          .then((response) {
        if (response.statusCode == 200) {
          if (response.bodyBytes.isNotEmpty) {
            setState(() {
              _caffTitles = List<CaffFile>.from(json
                  .decode(utf8.decode(response.bodyBytes))
                  .map((model) => CaffFile.fromJson(model)));
            });
          }
        } else {
          CaffToast.showError(
              'Something went wrong! Please check your network connection!');
        }
      });
    }
  }

  void _selectGif(int index) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => GifWidget(
                session: widget.session,
                user: widget.user,
                gifId: _caffTitles[index].id)));
  }

  void _getAllCaffs() {
    widget.session.get('/api/caff').then((response) {
      if (response.statusCode == 200) {
        if (response.bodyBytes.isNotEmpty) {
          setState(() {
            _caffTitles = List<CaffFile>.from(json
                .decode(utf8.decode(response.bodyBytes))
                .map((model) => CaffFile.fromJson(model)));
          });
        }
      } else {
        CaffToast.showError(
            'Something went wrong! Please check your network connection!');
      }
    });
  }

  void _onEditTap(int index) {
    showDialog(
        context: context,
        useRootNavigator: false,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.black,
            title: Text('Edit title', style: TextStyle(color: Colors.yellow),),
            content: Container(
              padding: EdgeInsets.only(left: 20.0),
              color: Colors.yellow.withOpacity(0.7),
              child: TextField(
                style: TextStyle(color: Colors.black),
                controller: _nameController,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  hintText: 'Title',
                  hintStyle: TextStyle(
                      color: Colors.black.withOpacity(0.5)),
                ),
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Close'),
              ),
              TextButton(
                  onPressed: () {
                    widget.session.post('/api/caff/' + _caffTitles[index].id.toString() + "/editName/" + _nameController.text, {}).then((response) {
                      if (response.statusCode == 200) {
                        setState(() {
                          _caffTitles.elementAt(index).title = _nameController.text;
                        });
                        Navigator.of(context).pop();
                      } else {
                        CaffToast.showError(
                            'Something went wrong! Please check your network connection!');
                      }
                    });
                  },
                  child: Text('Edit')),
            ],
          );
        });


  }

  void _onDeleteTap(int index) {
    widget.session.delete('/api/caff/' + _caffTitles[index].id.toString()).then((response) {
      if (response.statusCode == 200) {
        setState(() {
          _caffTitles.removeAt(index);
        });
      } else if (response.statusCode == 403) {
        CaffToast.showError(
            'Unauthorized!');
      } else {
        CaffToast.showError(
            'Something went wrong! Please check your network connection!');
      }
    });
  }
}
