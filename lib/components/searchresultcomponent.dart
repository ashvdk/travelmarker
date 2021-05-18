import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travelpointer/components/actor.dart';
import 'package:travelpointer/screens/profilepage.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SearchResultComponent extends StatefulWidget {
  final List users;
  const SearchResultComponent({Key key, this.users}) : super(key: key);

  @override
  _SearchResultComponentState createState() => _SearchResultComponentState();
}

class _SearchResultComponentState extends State<SearchResultComponent> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.users.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Actor(
            size: 30.0,
          ),
          title: Text('${widget.users[index]['displayName']}'),
          trailing: InkWell(
            child: IconButton(
              onPressed: () {},
              color: Colors.black,
              icon: Icon(Icons.person_add_rounded),
            ),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 10.0),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => ProfilePage(
                  uid: widget.users[index]['_id'],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
