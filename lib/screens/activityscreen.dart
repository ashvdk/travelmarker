import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:travelpointer/components/actor.dart';
import 'package:travelpointer/models/firebasedata.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:travelpointer/classes/restapi.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({Key key}) : super(key: key);

  @override
  _ActivityScreenState createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  var activity = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getActivity();
  }

  void getActivity() async {
    var uid = FirebaseAuth.instance.currentUser.uid;
    var token = Provider.of<FirebaseData>(context, listen: false).token;
    http.Response response = await RestAPI()
        .getTheRequest('user/$uid/getfollowersandfollwing', token);
    if (response.statusCode == 200) {
      var allActivity = jsonDecode(response.body);
      setState(() {
        activity = [...allActivity['result']];
      });
      print(allActivity['result'][0]['_id']);
    }
  }

  @override
  Widget build(BuildContext context) {
    return activity.isEmpty
        ? Container(
            child: Center(
              child: Text('No activity yet'),
            ),
          )
        : SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20.0, top: 20.0, bottom: 13.0),
                  child: Text(
                    'Following',
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
                Divider(
                  color: Colors.black12,
                  thickness: 1.0,
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20.0, right: 20.0),
                    child: ListView.builder(
                      itemCount: activity.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Actor(
                              size: 22.0,
                              photoURL: activity[index]['users'][0]
                                  ['photoURL']),
                          title: Align(
                            alignment: Alignment(-1.0, 0),
                            child: Text(
                              '${activity[index]['users'][0]['displayName']}',
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                          trailing: GestureDetector(
                            onTap: () async {
                              var _id = activity[index]['_id'];

                              var token = Provider.of<FirebaseData>(context,
                                      listen: false)
                                  .token;
                              http.Response response = await RestAPI()
                                  .delete('deletefollowing?_id=$_id', token);
                              if (response.statusCode == 200) {
                                getActivity();
                              }
                            },
                            child: Text(
                              'Remove',
                              style: TextStyle(
                                fontSize: 10.0,
                              ),
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(vertical: 10.0),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
