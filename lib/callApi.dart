import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Utilisateur {
  static String baseUrl = 'http://localhost:1234';

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
  static String baseUrl = 'http://localhost:1234';

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
  static String baseUrl = 'http://localhost:1234';

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

class BookSeance {
  // Renommée en CompteApi ou ApiService
  static String baseUrl = 'http://localhost:1234';

  // Récupération des données du compte
  static Future<Map<String, dynamic>> bookSeance(
      String userId, String seanceId) async {
    try {
      print(baseUrl + '/video/bookSeance/$userId/$seanceId');
      var res = await http.post(
        Uri.parse(baseUrl + '/video/bookSeance/$userId/$seanceId'),
        headers: {'Content-Type': 'application/json'},
      );

      print('Status code: ${res.statusCode}');
      print('Response body: ${res.body}');

      if (res.statusCode == 200 || res.statusCode == 201) {
        // Si la réponse est vide ou null, retourner un message de succès
        if (res.body.isEmpty || res.body == 'null') {
          return {'success': true, 'message': 'Réservé avec succès'};
        }
        
        try {
          return jsonDecode(res.body);
        } catch (e) {
          // Si le JSON ne peut pas être décodé, retourner un message de succès
          return {'success': true, 'message': 'Réservé avec succès'};
        }
      } else if (res.statusCode == 409) {
        // Conflit - probablement déjà réservé
        return {'success': false, 'message': 'Cette séance est déjà réservée'};
      } else if (res.statusCode == 404) {
        // Séance non trouvée
        return {'success': false, 'message': 'Séance non trouvée'};
      } else {
        // Autres erreurs
        String errorMessage = 'Erreur lors de la réservation de la séance.';
        try {
          var errorResponse = jsonDecode(res.body);
          if (errorResponse.containsKey('message')) {
            errorMessage = errorResponse['message'];
          }
        } catch (e) {
          // Si on ne peut pas décoder l'erreur, utiliser le message par défaut
        }
        return {'success': false, 'message': errorMessage};
      }
    } catch (err) {
      print('Exception in bookSeance: $err');
      return {'success': false, 'message': 'Erreur de connexion: $err'};
    }
  }
}

class getBookedSeances {
  static String baseUrl = 'http://localhost:1234';

  static Future<List<dynamic>> GetBookedSeances(String userId) async {
    try {
      var res = await http.get(
        Uri.parse(baseUrl + '/video/getBookedSeances/$userId'),
        headers: {'Content-Type': 'application/json'},
      );

      if (res.statusCode == 200) {
        print(res.body);
        return jsonDecode(res.body);
      } else {
        throw Exception(
            'Erreur lors de la récupération des séances réservées.');
      }
    } catch (err) {
      throw Exception(err.toString());
    }
  }
}
