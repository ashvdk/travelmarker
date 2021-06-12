import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List chatUsers = [
    {
      "text": "Jane Russel",
      "secondaryText": "Awesome Setup",
      'image': "images/userImage1.jpeg",
      'time': "Now"
    },
    {
      'text': "Glady's Murphy",
      'secondaryText': "That's Great",
      'image': "images/userImage2.jpeg",
      'time': "Yesterday"
    },
    {
      'text': "Jorge Henry",
      'secondaryText': "Hey where are you?",
      'image': "images/userImage3.jpeg",
      'time': "31 Mar"
    },
    {
      'text': "Philip Fox",
      'secondaryText': "Busy! Call me in 20 mins",
      'image': "images/userImage4.jpeg",
      'time': "28 Mar"
    },
    {
      'text': "Debra Hawkins",
      'secondaryText': "Thankyou, It's awesome",
      'image': "images/userImage5.jpeg",
      'time': "23 Mar"
    },
    {
      'text': "Jacob Pena",
      'secondaryText': "will update you in evening",
      'image': "images/userImage6.jpeg",
      'time': "17 Mar"
    },
    {
      'text': "Andrey Jones",
      'secondaryText': "Can you please share the file?",
      'image': "images/userImage7.jpeg",
      'time': "24 Feb"
    },
    {
      'text': "John Wick",
      'secondaryText': "How are you?",
      'image': "images/userImage8.jpeg",
      'time': "18 Feb"
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SafeArea(
              child: Padding(
                padding: EdgeInsets.only(left: 16, right: 16, top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Conversations",
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      padding:
                          EdgeInsets.only(left: 8, right: 8, top: 2, bottom: 2),
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.pink[50],
                      ),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.add,
                            color: Colors.pink,
                            size: 20,
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Text(
                            "Add New",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 16, left: 16, right: 16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Search...",
                  hintStyle: TextStyle(color: Colors.grey.shade600),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey.shade600,
                    size: 20,
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  contentPadding: EdgeInsets.all(8),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.grey.shade100)),
                ),
              ),
            ),
            ListView.builder(
              itemCount: chatUsers.length,
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 16),
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
                  padding:
                      EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Row(
                          children: <Widget>[
                            CircleAvatar(
                              backgroundImage: NetworkImage(
                                  "https://cdn3.iconfinder.com/data/icons/avatars-round-flat/33/avat-01-512.png"),
                              maxRadius: 30,
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Expanded(
                              child: Container(
                                color: Colors.transparent,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      chatUsers[index]['text'],
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    Text(
                                      chatUsers[index]['secondaryText'],
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey.shade600,
                                          fontWeight: (index == 0 || index == 3)
                                              ? FontWeight.bold
                                              : FontWeight.normal),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        chatUsers[index]['time'],
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: (index == 0 || index == 3)
                                ? FontWeight.bold
                                : FontWeight.normal),
                      ),
                    ],
                  ),
                );
                // return ConversationList(
                //   name: chatUsers[index].name,
                //   messageText: chatUsers[index].messageText,
                //   imageUrl: chatUsers[index].imageURL,
                //   time: chatUsers[index].time,
                //   isMessageRead: (index == 0 || index == 3) ? true : false,
                // );
              },
            ),
          ],
        ),
      ),
    );
  }
}
