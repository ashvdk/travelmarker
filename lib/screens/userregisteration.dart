import 'package:flutter/material.dart';
import 'package:travelpointer/components/signinwithgoogle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:travelpointer/components/signinwithusernameandpassword.dart';

class UserRegisteration extends StatefulWidget {
  final Function setUser;

  const UserRegisteration({Key key, this.setUser}) : super(key: key);
  @override
  _UserRegisterationState createState() => _UserRegisterationState();
}

class _UserRegisterationState extends State<UserRegisteration> {
  var loading = "loading_button";
  var chooseloginorcreate = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void setLoading(String message) {
    setState(() {
      loading = message;
    });
  }

  void choosebetweenloginandcreate() {
    setState(() {
      chooseloginorcreate = !chooseloginorcreate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: loading == "loading_selectaccountmessage"
              ? Text('Select your google account')
              : loading == "loading_settingprofilemessage"
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(
                          backgroundColor: Colors.white,
                        ),
                        Text('Setting up your profile....')
                      ],
                    )
                  : Column(
                      children: [
                        Expanded(flex: 1, child: Container()),
                        SignInWithGoogle(
                          setUser: widget.setUser,
                          setLoading: setLoading,
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text('or'),
                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: choosebetweenloginandcreate,
                                child: Container(
                                  padding: EdgeInsets.only(bottom: 10.0),
                                  decoration: BoxDecoration(
                                    border: chooseloginorcreate
                                        ? Border(
                                            bottom: BorderSide(
                                              color: Colors.black,
                                              width: 3.0,
                                            ),
                                          )
                                        : Border(),
                                  ),
                                  child: Text(
                                    'Login',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: choosebetweenloginandcreate,
                                child: Container(
                                  padding: EdgeInsets.only(bottom: 10.0),
                                  decoration: BoxDecoration(
                                    border: chooseloginorcreate
                                        ? Border()
                                        : Border(
                                            bottom: BorderSide(
                                              color: Colors.black,
                                              width: 3.0,
                                            ),
                                          ),
                                  ),
                                  child: Text(
                                    'Create',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Container(
                          child: SigninWithUsernameandPassword(
                              chooseloginorcreate: chooseloginorcreate),
                        ),
                        Expanded(flex: 1, child: Container()),
                      ],
                    ),
        ),
      ),
    );
  }
}
