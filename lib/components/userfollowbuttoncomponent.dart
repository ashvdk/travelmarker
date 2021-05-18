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
      jsonDecode(response.body)['message'] == "Successful"
          ? setState(() {
              relationshipMessage = jsonDecode(response.body)['result'];
            })
          : setState(() {
              relationshipMessage = jsonDecode(response.body)['result'];
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
      print(jsonDecode(response.body)['message']);
      print(jsonDecode(response.body)['result']);
      jsonDecode(response.body)['message'] == "Successful"
          ? setState(() {
              relationshipMessage = jsonDecode(response.body)['result'];
            })
          : setState(() {
              relationshipMessage = jsonDecode(response.body)['result'];
            });
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
    return GestureDetector(
      onTap: sendFollowRequest,
      child: Container(
        child: loading
            ? CircularProgressIndicator(
                backgroundColor: Colors.white,
              )
            : Text(
                '$relationshipMessage',
                style: TextStyle(fontSize: 13.0),
              ),
      ),
    );
  }
}
