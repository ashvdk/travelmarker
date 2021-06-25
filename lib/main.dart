import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelpointer/classes/addanewlocation.dart';
import 'package:travelpointer/models/alldata.dart';
import 'package:travelpointer/models/firebasedata.dart';
import 'package:travelpointer/models/markerimage.dart';
import 'package:travelpointer/models/userdetails.dart';
import 'package:travelpointer/screens/addusernamescreen.dart';
import 'package:travelpointer/screens/homepage.dart';
import 'package:travelpointer/screens/userregisteration.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';

final storage = new FlutterSecureStorage();

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
        ChangeNotifierProvider.value(
          value: UserDetails(),
        ),
        ChangeNotifierProvider.value(
          value: FirebaseData(),
        ),
      ],
      //FirebaseData
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Quicksand'),
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
  var user = null;
  var userregistered = null;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setUser();
  }

  Future<void> signOutGoogle() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('userregistered');
    setUser();
  }

  void setUser() async {
    // String user_registered = await storage.read(key: "userregistered");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String user_registered = prefs.getString('userregistered');
    print("Checking user registeration value");
    print(user_registered);
    setState(() {
      user = FirebaseAuth.instance.currentUser;
      userregistered = user_registered;
    });
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<MarkerImage>(context, listen: false).setMarkers();
    if (user == null) {
      return UserRegisteration(setUser: setUser);
    } else {
      Provider.of<FirebaseData>(context, listen: false).setToken();
      if (userregistered == "no") {
        return AddUsernameScreen(
          setUser: setUser,
        );
      } else if (userregistered == "error" || userregistered == null) {
        signOutGoogle();
        return Container(
          color: Colors.white,
          width: 0.0,
          height: 0.0,
        );
      } else {
        return HomePage(setUser: setUser);
      }
    }
  }
}
