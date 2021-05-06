import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelpointer/classes/addanewlocation.dart';
import 'package:travelpointer/models/alldata.dart';
import 'package:travelpointer/models/markerimage.dart';
import 'package:travelpointer/screens/homepage.dart';
import 'package:travelpointer/screens/map.dart';
import 'package:travelpointer/screens/userregisteration.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyAPP());
}

class MyAPP extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: AllData(),
        ),
        ChangeNotifierProvider.value(
          value: AddANewLocation(),
        ),
        ChangeNotifierProvider.value(
          value: MarkerImage(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginCheck(),
      ),
    );
  }
}

class LoginCheck extends StatefulWidget {
  @override
  _LoginCheckState createState() => _LoginCheckState();
}

class _LoginCheckState extends State<LoginCheck> {
  var user = FirebaseAuth.instance.currentUser;

  void setUser() async {
    setState(() {
      user = FirebaseAuth.instance.currentUser;
    });

    //http.Response response = await http.post(url)
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<MarkerImage>(context, listen: false).setMarkers();
    if (user == null) {
      return UserRegisteration(setUser: setUser);
    } else {
      return HomePage(setUser: setUser);
    }
  }
}
