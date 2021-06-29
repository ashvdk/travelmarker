import 'package:flutter/material.dart';

class PhotoSHowUI extends StatefulWidget {
  final String photourl;
  PhotoSHowUI({this.photourl});
  @override
  _PhotoSHowUIState createState() => _PhotoSHowUIState();
}

class _PhotoSHowUIState extends State<PhotoSHowUI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: Image.network('${widget.photourl}'),
        ),
      ),
    );
  }
}
