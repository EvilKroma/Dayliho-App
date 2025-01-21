import 'dart:convert';
import 'package:http/http.dart' as http;

class Utilisateur {
  static String baseUrl = 'http://10.0.2.2:1234';

  // Connexion de l'utilisateur
  static Future<Map<String, dynamic>> checkUser(
      String email, String password) async {
    try {
      var res = await http.post(
        Uri.parse(baseUrl + "/user/checkUser"),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'mot_de_passe': password}),
      );
      if (res.statusCode == 201) {
        print(res.body);
        return jsonDecode(res.body);
      } else {
        return Future.error("Informations incorrectes");
      }
    } catch (err) {
      return Future.error(err);
    }
  }
}

class Seance {
  static String baseUrl = 'http://10.0.2.2:1234';

  // Récupération des séances de sport
  static Future<List<dynamic>> getSeances() async {
    try {
      var res = await http.get(
        Uri.parse(baseUrl + '/video/getVideos'),
        headers: {'Content-Type': 'application/json'},
      );

      if (res.statusCode == 200) {
        return jsonDecode(res.body);
      } else {
        throw Exception('Erreur lors de la récupération des séances de sport.');
      }
    } catch (err) {
      throw Exception(err.toString());
    }
  }
}

class CompteApi {
  // Renommée en CompteApi ou ApiService
  static String baseUrl = 'http://10.0.2.2:1234';

  // Récupération des données du compte
  static Future<Map<String, dynamic>> getCompteData(String userId) async {
    try {
      var res = await http.get(
        Uri.parse(baseUrl + '/user/getUserById?id=$userId'),
        headers: {'Content-Type': 'application/json'},
      );

      if (res.statusCode == 200) {
        return jsonDecode(res.body);
      } else {
        throw Exception(
            'Erreur lors de la récupération des données du compte.');
      }
    } catch (err) {
      throw Exception(err.toString());
    }
  }
}
