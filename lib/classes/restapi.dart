import 'package:http/http.dart' as http;
import 'dart:io';

class RestAPI {
  String url = "https://warm-dusk-84059.herokuapp.com/";
  Future postTheRequest(String apiURL, var body, var token) async {
    return await http.post('$url$apiURL',
        body: body, headers: {HttpHeaders.authorizationHeader: token});
  }

  Future getTheRequest(String apiURL, var token) async {
    if (token == "NO_TOKEN_PRESENT") {
      return await http.get('$url$apiURL');
    } else {
      return await http.get('$url$apiURL',
          headers: {HttpHeaders.authorizationHeader: token});
    }
  }
}
