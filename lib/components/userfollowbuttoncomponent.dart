import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:travelpointer/classes/restapi.dart';
import 'package:travelpointer/models/firebasedata.dart';

class UserFollowButtonComponent extends StatefulWidget {
  final Map user;
  const UserFollowButtonComponent({Key key, this.user}) : super(key: key);

  @override
  _UserFollowButtonComponentState createState() =>
      _UserFollowButtonComponentState();
}

class _UserFollowButtonComponentState extends State<UserFollowButtonComponent> {
  var loading = false;
  var relationship_id;
  String relationshipMessage;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    checkRelationship();
  }

  void checkRelationship() async {
    print("came to check relationship");
    setState(() {
      loading = true;
    });
    var token = Provider.of<FirebaseData>(context, listen: false).token;
    var uid = FirebaseAuth.instance.currentUser.uid;
    var followerid = widget.user['_id'];
    print('user id $uid');
    print(' follower id $followerid');

    http.Response response = await RestAPI()
        .getTheRequest('user/$uid/checkrelationship/$followerid', token);
    if (response.statusCode == 200) {
      setState(() {
        loading = false;
      });
      var result = jsonDecode(response.body);
      relationshipMessage = "Following";
      relationship_id = result['result'];
    } else {
      setState(() {
        loading = false;
        relationshipMessage = "Follow";
        relationship_id = "";
      });
    }
  }

  void sendFollowRequest() async {
    setState(() {
      loading = true;
    });
    var body = {
      "uid": FirebaseAuth.instance.currentUser.uid,
      "followerid": widget.user['_id']
    };
    var token = Provider.of<FirebaseData>(context, listen: false).token;
    http.Response response =
        await RestAPI().postTheRequest('user/addfollowing', body, token);
    if (response.statusCode == 200) {
      setState(() {
        loading = false;
      });
      var result = jsonDecode(response.body);
      relationshipMessage = "Following";
      relationship_id = result['result'];
    }
  }

  @override
  Widget build(BuildContext context) {
    // return IconButton(
    //   onPressed: sendFollowRequest,
    //   color: Colors.black,
    //   icon: Icon(
    //     Icons.person_add_rounded,
    //     //supervisor_account_sharp
    //     size: 26.0,
    //     //color: Color(0xFF05a859),
    //   ),
    // );
    return loading
        ? CircularProgressIndicator(
            backgroundColor: Colors.white,
          )
        : relationshipMessage == "Follow"
            ? GestureDetector(
                onTap: sendFollowRequest,
                child: Text(
                  'Follow',
                  style: TextStyle(fontSize: 13.0),
                ),
              )
            : GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => SingleChildScrollView(
                      child: Column(
                        children: [
                          Text(
                            'Are you sure you want to unfollow ${widget.user['displayName']}?',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "You won\'t be able to see their activities when you unfollow",
                            textAlign: TextAlign.center,
                          ),
                          Row(
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('Cancel'),
                                style: TextButton.styleFrom(
                                  primary: Colors.black,
                                  //minimumSize: Size(500, 60),
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 16.0),
                                ),
                              ),
                              SizedBox(
                                width: 20.0,
                              ),
                              Expanded(
                                flex: 1,
                                child: TextButton(
                                  onPressed: () async {
                                    var token = Provider.of<FirebaseData>(
                                            context,
                                            listen: false)
                                        .token;
                                    http.Response response = await RestAPI()
                                        .delete(
                                            'deletefollowing?_id=$relationship_id',
                                            token);
                                    if (response.statusCode == 200) {
                                      setState(() {
                                        relationshipMessage = "Follow";
                                        relationship_id = "";
                                      });

                                      Navigator.pop(context);
                                    }
                                  },
                                  child: Text('Unfollow'),
                                  style: TextButton.styleFrom(
                                    primary: Colors.white,
                                    //minimumSize: Size(500, 60),
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 16.0),
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0)),
                                    ),
                                    backgroundColor: Colors.blue,
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
                child: Text(
                  'Following',
                  style: TextStyle(fontSize: 13.0),
                ),
              );
  }
}
