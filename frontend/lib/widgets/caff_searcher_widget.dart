import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:frontend/session.dart';
import 'package:frontend/entities/user.dart';

import 'gif_widget.dart';

class CaffSearcherWidget extends StatefulWidget {
  final Session session;
  final User user;

  const CaffSearcherWidget({Key? key, required this.session, required this.user}) : super(key: key);

  @override
  _CaffSearcherWidgetState createState() => _CaffSearcherWidgetState();
}

class _CaffSearcherWidgetState extends State<CaffSearcherWidget> {
  final TextEditingController _searchFieldController = TextEditingController();
  List<String> _gifTitles = [];

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
                  child: TypeAheadField(
                    noItemsFoundBuilder: (context) {
                      return Container(
                        padding: EdgeInsets.all(1),
                        color: Colors.yellow,
                        child: Container(
                          color: Colors.black,
                          child: ListTile(
                            leading: Icon(
                              Icons.not_interested_rounded,
                              color: Colors.yellow,
                            ),
                            title: Text(
                              'No items found!',
                              style: TextStyle(
                                  color: Colors.yellow,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ),
                        ),
                      );
                    },
                    textFieldConfiguration: TextFieldConfiguration(
                      decoration:
                          new InputDecoration.collapsed(hintText: 'Search'),
                      controller: _searchFieldController,
                      cursorColor: Colors.black,
                      autofocus: false,
                      style: TextStyle(fontSize: 20),
                      onEditingComplete: _onSearchButtonPressed,
                    ),
                    suggestionsCallback: (pattern) async {
                      /*
                      dynamic response = await widget.session
                          .get("/api/searchField/" + pattern);
                      if (response.statusCode == 200) {
                        widget.session.updateCookie(response);
                        Iterable l =
                            json.decode(utf8.decode(response.bodyBytes));
                        names = List<SearchFieldNames>.from(
                            l.map((name) => SearchFieldNames.fromJson(name)));
                        List<String> resultList = [];
                        names.forEach((name) {
                          if (name.id != null) {
                            resultList.add(name.id.toString());
                          } else {
                            resultList.add(name.name);
                          }
                        });
                        return resultList;
                      }
                       */
                      //TODO
                      return [];
                    },
                    itemBuilder: (context, n) {
                      /*
                      SearchFieldNames? name;
                      if (names
                          .where((nm) => nm.id.toString() == n)
                          .isNotEmpty) {
                        name = names.where((nm) => nm.id.toString() == n).first;
                      }
                      return Container(
                        padding: EdgeInsets.all(1),
                        color: Colors.yellow,
                        child: Container(
                          color: Colors.black,
                          child: ListTile(
                            leading: name != null
                                ? CircleAvatar(
                                    radius: 20,
                                    backgroundImage: NetworkImage(
                                      widget.session.domainName +
                                          "/api/images/" +
                                          name.imageId.toString(),
                                      headers: widget.session.headers,
                                    ),
                                  )
                                : Icon(
                                    Icons.lightbulb_outline_sharp,
                                    color: Colors.yellow,
                                  ),
                            title: Text(
                              name == null ? n.toString() : name.name,
                              style: TextStyle(
                                  color: Colors.yellow,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                          ),
                        ),
                      );
                      */
                      //TODO
                      return Container();
                    },
                    onSuggestionSelected: (n) {
                      /*
                      String name;
                      if (names
                          .where((nm) => nm.id.toString() == n)
                          .isNotEmpty) {
                        name = names
                            .where((nm) => nm.id.toString() == n)
                            .first
                            .name;
                      } else {
                        name = n.toString();
                      }
                      _searchFieldController.text = name.toString();
                      _onSearchButtonPressed();

                       */
                      //TODO
                    },
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
          itemCount: _gifTitles.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Icon(Icons.image),
              title: Text(_gifTitles[index]),
              onTap: _selectGif(index),
            );
          },
        ),
    );
  }

  void _onSearchButtonPressed() {

  }

  _selectGif(int index) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => GifWidget(gifTitle: _gifTitles[index])));
  }
}
