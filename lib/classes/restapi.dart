import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';

class RestAPI {
  //String url = "https://warm-dusk-84059.herokuapp.com/";

  String url = "http://192.168.1.6:8080/";
  Future postTheRequest(String apiURL, var body, var token) async {
    var url2 = Uri.parse('$url$apiURL');
    return await http.post(url2, body: body, headers: {
      HttpHeaders.authorizationHeader: token,
      HttpHeaders.contentTypeHeader: "application/json"
    });
  }

  Future getTheRequest(String apiURL, var token) async {
    var url2 = Uri.parse('$url$apiURL');
    if (token == "NO_TOKEN_PRESENT") {
      return await http.get(url2);
    } else {
      return await http
          .get(url2, headers: {HttpHeaders.authorizationHeader: token});
    }
  }

  Future delete(String apiURL, var token) async {
    var url2 = Uri.parse('$url$apiURL');
    return await http
        .delete(url2, headers: {HttpHeaders.authorizationHeader: token});
  }
}
