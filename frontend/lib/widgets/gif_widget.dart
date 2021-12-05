
import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:frontend/entities/user.dart';
import 'package:image/image.dart' as image_package;

import '../session.dart';
import '../toast.dart';

class GifWidget extends StatefulWidget {
  final int gifId;
  final Session session;
  final User user;

  const GifWidget(
      {required this.gifId, required this.session, required this.user});

  @override
  _GifWidgetState createState() => _GifWidgetState();
}

class _GifWidgetState extends State<GifWidget> {
  File? _gifFile;

  @override
  void initState() {
    super.initState();

    widget.session
        .get('/api/caff/getCaff/' + widget.gifId.toString())
        .then((response) async {
      if (response.statusCode == 200) {
        Uint8List bytes = response.bodyBytes;
        _gifFile = File.fromRawPath(bytes);
      } else {
        CaffToast.showError(
            'Something went wrong! Please check your network connection!');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          _gifFile == null ? Container() : Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: FileImage(_gifFile!))),
          ),
        ],
      ),
    );
  }

  Future<void> writeToFile(ByteData data, String path) {
    final buffer = data.buffer;
    return new File(path).writeAsBytes(
        buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }
}
