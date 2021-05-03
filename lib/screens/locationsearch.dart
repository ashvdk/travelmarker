import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:travelpointer/classes/restapi.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

class LocationSearch extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return null;
  }

  Future fetchSuggestions(String input, String lang) async {
    //var token = await FirebaseAuth.instance.currentUser.getIdToken(true);
    var sessionToken = Uuid().v4();

    final request =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&key=AIzaSyBTOndyuPlpaoBLoaDRtZ9T_T5Y8y0fKRg&sessiontoken=$sessionToken';
    http.Response response =
        await RestAPI().getTheRequest(request, "NO_TOKEN_PRESENT");
    print(response.body);
    return "data came";
    // final response = await client.get(request);
    //
    // if (response.statusCode == 200) {
    //   final result = json.decode(response.body);
    //   if (result['status'] == 'OK') {
    //     // compose suggestions in a list
    //     return result['predictions']
    //         .map<Suggestion>((p) => Suggestion(p['place_id'], p['description']))
    //         .toList();
    //   }
    //   if (result['status'] == 'ZERO_RESULTS') {
    //     return [];
    //   }
    //   throw Exception(result['error_message']);
    // } else {
    //   throw Exception('Failed to fetch suggestion');
    // }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    return FutureBuilder(
      future: query == ""
          ? null
          : fetchSuggestions(
              query, Localizations.localeOf(context).languageCode),
      builder: (context, snapshot) => query == ''
          ? Container(
              padding: EdgeInsets.all(16.0),
              child: Text('Enter your address'),
            )
          : snapshot.hasData
              ? Container(child: Text('Loading...'))
              // ? ListView.builder(
              //     itemBuilder: (context, index) => ListTile(
              //       title:
              //           Text((snapshot.data[index] as Suggestion).description),
              //       onTap: () {
              //         close(context, snapshot.data[index] as Suggestion);
              //       },
              //     ),
              //     itemCount: snapshot.data.length,
              //   )
              : Container(child: Text('Loading...')),
    );
  }
}
