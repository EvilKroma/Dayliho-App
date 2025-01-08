import 'dart:convert';
import 'package:http/http.dart' as http;

class Utilisateur {
  static String baseUrl = 'http://10.0.2.2:1234';

  static Future<List> getAllUser() async {
    try {
      var res = await http.get(Uri.parse(baseUrl + "/user/getUsers"));
      if (res.statusCode == 200) {
        print(res.body);
        return jsonDecode(res.body);
      } else {
        return Future.error("erreur serveur");
      }
    } catch (err) {
      return Future.error(err);
    }
  }
}
