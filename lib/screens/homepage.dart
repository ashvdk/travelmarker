import 'dart:async';

import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:travelpointer/models/firebasedata.dart';
import 'dart:convert';
import 'package:travelpointer/screens/activityscreen.dart';
import 'package:travelpointer/screens/chatscreen.dart';
import 'package:travelpointer/screens/planningscreen.dart';
import 'package:travelpointer/screens/profilepage.dart';
import 'package:travelpointer/screens/feed.dart';
import 'package:travelpointer/screens/searchscreen.dart';
import 'package:travelpointer/classes/restapi.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  final Function setUser;

  const HomePage({Key key, this.setUser}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var database;
  void initState() {
    // TODO: implement initState
    super.initState();
    //runfunctioneveryminute();
  }

  void runfunctioneveryminute() {
    Timer.periodic(new Duration(minutes: 1), (timer) async {
      var token = Provider.of<FirebaseData>(context, listen: false).token;
      var uid = FirebaseAuth.instance.currentUser.uid;
      DateTime now = new DateTime.now();
      var body = jsonEncode({
        "uid": uid,
        "date": now.toString().split(" ")[0],
        "timespent": 1,
        "milliseconds": now.millisecondsSinceEpoch
      });
      http.Response response =
          await RestAPI().postTheRequest('logthetime', body, token);
      print("running every minute so run your function");
    });
  }

  Future<void> signOutGoogle() async {
    await FirebaseAuth.instance.signOut();

    print("User Signed Out");
    print(FirebaseAuth.instance.currentUser);
  }

  int _selectedIndex = 0;
  Widget getPage(int index) {
    switch (index) {
      case 0:
        return FeedScreen(setUser: widget.setUser);
        break;
      case 1:
        return SearchScreen();
        break;
      case 2:
        return PlanningScreen();
        break;
      case 3:
        return ActivityScreen();
        break;
      case 4:
        return ChatScreen();
      case 5:
        return ProfilePage(
          uid: FirebaseAuth.instance.currentUser.uid,
        );
        break;
      default:
        return FeedScreen(setUser: widget.setUser);
        break;
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: getPage(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map_rounded),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.supervisor_account_sharp),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_outlined),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xFF05a859),
        onTap: _onItemTapped,
      ),
    );
  }
}
