import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class ApiService {
  final String _baseUrl = "https://dbf82395-e1b7-48b8-9189-b6e1dd0eb187.mock.pstmn.io/";

  Future<dynamic> get(String url) async {
    var responseJson;
    try {
      final response = await http.get(_baseUrl + url);
      responseJson = jsonDecode(response.body);
    } on SocketException {
      throw Exception('No Internet connection');
    }
    return responseJson;
  }
}
