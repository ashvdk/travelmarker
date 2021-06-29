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
  var chooseloginorcreate = true;
  bool disablesigninwithgooglebutton = false;
  bool disableloginorcreate = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void choosebetweenloginandcreate() {
    setState(() {
      chooseloginorcreate = !chooseloginorcreate;
    });
  }

  void doyouwanttodisbaleloginorcreate() {
    setState(() {
      disableloginorcreate = !disableloginorcreate;
    });
  }

  void setbuttonSetting() {
    setState(() {
      disablesigninwithgooglebutton = !disablesigninwithgooglebutton;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/leadingroad.jpg"), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
            child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              Container(
                height: 200.0,
                child: Center(
                  child: Text(
                    'Explore',
                    style: TextStyle(
                      fontFamily: 'Sacramento',
                      color: Colors.black,
                      fontSize: 50.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Container(
                child: SignInWithGoogle(
                  setUser: widget.setUser,
                  disablesigninwithgooglebutton: disablesigninwithgooglebutton,
                  doyouwanttodisbaleloginorcreate:
                      doyouwanttodisbaleloginorcreate,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: Center(
                  child: Text(
                    'OR',
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 20.0),
                child: Row(
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
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
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
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 10.0),
                child: SigninWithUsernameandPassword(
                  chooseloginorcreate: chooseloginorcreate,
                  setUser: widget.setUser,
                  setbuttonSetting: setbuttonSetting,
                  disableloginorcreate: disableloginorcreate,
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }
  // @override
  // Widget build(BuildContext context) {
  //   return Container(
  //     decoration: BoxDecoration(
  //       image: DecorationImage(
  //           image: AssetImage("assets/leadingroad.jpg"), fit: BoxFit.cover),
  //     ),
  //     child: Scaffold(
  //       backgroundColor: Colors.transparent,
  //       body: Center(
  //         child: Padding(
  //           padding: EdgeInsets.symmetric(horizontal: 24.0),
  //           child: Column(
  //             children: [
  //               Container(
  //                 padding: EdgeInsets.only(top: 100.0, bottom: 100.0),
  //                 child: Text(
  //                   'Explore',
  //                   style: TextStyle(
  //                       fontFamily: 'Sacramento',
  //                       color: Colors.white,
  //                       fontSize: 50.0,
  //                       fontWeight: FontWeight.bold),
  //                 ),
  //               ),
  //               Expanded(
  //                 flex: 1,
  //                 child: Container(
  //                   child: loading == "loading_selectaccountmessage"
  //                       ? Text('Select your google account')
  //                       : loading == "loading_settingprofilemessage"
  //                           ? Column(
  //                               mainAxisAlignment: MainAxisAlignment.center,
  //                               children: [
  //                                 CircularProgressIndicator(
  //                                   backgroundColor: Colors.white,
  //                                 ),
  //                                 Text('Setting up your profile....')
  //                               ],
  //                             )
  //                           : Column(
  //                               children: [
  //                                 SignInWithGoogle(
  //                                   setUser: widget.setUser,
  //                                   setLoading: setLoading,
  //                                   disablesigninwithgooglebutton:
  //                                       disablesigninwithgooglebutton,
  //                                 ),
  //                                 SizedBox(
  //                                   height: 10.0,
  //                                 ),
  //                                 Text('or'),
  //                                 SizedBox(
  //                                   height: 10.0,
  //                                 ),
  //                                 Row(
  //                                   mainAxisAlignment:
  //                                       MainAxisAlignment.spaceEvenly,
  //                                   children: [
  //                                     Expanded(
  //                                       child: GestureDetector(
  //                                         onTap: choosebetweenloginandcreate,
  //                                         child: Container(
  //                                           padding:
  //                                               EdgeInsets.only(bottom: 10.0),
  //                                           decoration: BoxDecoration(
  //                                             border: chooseloginorcreate
  //                                                 ? Border(
  //                                                     bottom: BorderSide(
  //                                                       color: Colors.black,
  //                                                       width: 3.0,
  //                                                     ),
  //                                                   )
  //                                                 : Border(),
  //                                           ),
  //                                           child: Text(
  //                                             'Login',
  //                                             textAlign: TextAlign.center,
  //                                             style: TextStyle(
  //                                                 fontSize: 20.0,
  //                                                 fontWeight: FontWeight.bold),
  //                                           ),
  //                                         ),
  //                                       ),
  //                                     ),
  //                                     Expanded(
  //                                       child: GestureDetector(
  //                                         onTap: choosebetweenloginandcreate,
  //                                         child: Container(
  //                                           padding:
  //                                               EdgeInsets.only(bottom: 10.0),
  //                                           decoration: BoxDecoration(
  //                                             border: chooseloginorcreate
  //                                                 ? Border()
  //                                                 : Border(
  //                                                     bottom: BorderSide(
  //                                                       color: Colors.black,
  //                                                       width: 3.0,
  //                                                     ),
  //                                                   ),
  //                                           ),
  //                                           child: Text(
  //                                             'Create',
  //                                             textAlign: TextAlign.center,
  //                                             style: TextStyle(
  //                                                 fontSize: 20.0,
  //                                                 fontWeight: FontWeight.bold),
  //                                           ),
  //                                         ),
  //                                       ),
  //                                     ),
  //                                   ],
  //                                 ),
  //                                 SizedBox(
  //                                   height: 20.0,
  //                                 ),
  //                                 Container(
  //                                   child: SigninWithUsernameandPassword(
  //                                     chooseloginorcreate: chooseloginorcreate,
  //                                     setUser: widget.setUser,
  //                                     setbuttonSetting: setbuttonSetting,
  //                                   ),
  //                                 ),
  //                               ],
  //                             ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
