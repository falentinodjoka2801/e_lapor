import 'dart:convert';

import 'package:http/http.dart';

import 'package:e_lapor/libraries/ServerPath.dart';

class BerandaFuture {
  static String _apiBaseURL = ServerPath.apiBaseURL;
  static Future<String> getAdminWhatsappContact() async {
    String _waContact = '';

    Uri _url = Uri.parse(_apiBaseURL + '/' + ServerPath.adminWAContactPath);

    Response _httpResponse = await get(_url);
    if (_httpResponse.statusCode == 200) {
      Map<String, dynamic> _decodedBody = jsonDecode(_httpResponse.body);
      if (_decodedBody.containsKey('data')) {
        _waContact = _decodedBody['data'];
      }
    }

    return _waContact;
  }
}
