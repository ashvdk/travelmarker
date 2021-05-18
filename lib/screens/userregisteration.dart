import 'package:flutter/material.dart';
import 'package:travelpointer/components/signinwithgoogle.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserRegisteration extends StatefulWidget {
  final Function setUser;

  const UserRegisteration({Key key, this.setUser}) : super(key: key);
  @override
  _UserRegisterationState createState() => _UserRegisterationState();
}

class _UserRegisterationState extends State<UserRegisteration> {
  var loading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void setLoading() {
    setState(() {
      loading = !loading;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: loading
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      backgroundColor: Colors.white,
                    ),
                    Text('Setting up your profile....')
                  ],
                )
              : SignInWithGoogle(
                  setUser: widget.setUser,
                  setLoading: setLoading,
                ),
        ),
      ),
    );
  }
}
