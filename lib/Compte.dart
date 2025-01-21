import 'package:flutter/material.dart';
import 'callApi.dart'; // Assure-toi d'importer la bonne classe

class Compte extends StatelessWidget {
  final Map<String, dynamic> connectedUserData;
  const Compte({super.key, required this.connectedUserData});

  @override
  Widget build(BuildContext context) {
    // Récupération de l'ID de l'utilisateur et conversion en String
    var userId = connectedUserData['userId'].toString(); // Conversion en String

    return FutureBuilder<Map<String, dynamic>>(
      future: CompteApi.getCompteData(userId), // Utilisation de CompteApi
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator()); // Chargement
        } else if (snapshot.hasError) {
          return Center(child: Text('Erreur: ${snapshot.error}')); // Erreur
        } else if (snapshot.hasData) {
          // Affichage des données récupérées
          var compteData = snapshot.data!;
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //Text("User ID: $userId"), // Affiche l'ID de l'utilisateur
                Text("Nom: ${compteData['nom']}"),
                Text("Prénom: ${compteData['prenom']}"),
                Text("Email: ${compteData['email']}"),
                Text("Rôle: ${compteData['role']}"),
              ],
            ),
          );
        } else {
          return Center(child: Text('Aucune donnée disponible.'));
        }
      },
    );
  }
}
