import 'dart:async';
import 'package:flutter/material.dart';

class Actor extends StatelessWidget {
  final double size;
  Actor({this.size});
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: size,
      backgroundImage: NetworkImage(
        'https://images.unsplash.com/flagged/photo-1570612861542-284f4c12e75f?ixid=MXwxMjA3fDB8MHxzZWFyY2h8M3x8cGVyc29ufGVufDB8fDB8&ixlib=rb-1.2.1&w=1000&q=80',
      ),
    );
  }
}
