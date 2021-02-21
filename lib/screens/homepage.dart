import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:travelpointer/screens/profilepage.dart';
import 'package:travelpointer/screens/feed.dart';

class HomePage extends StatefulWidget {
  final Function setUser;

  const HomePage({Key key, this.setUser}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
        return ProfilePage();
        break;
      default:
        return Text(
          'Index 2: School',
        );
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
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Search',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
