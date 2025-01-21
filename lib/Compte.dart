import 'package:flutter/material.dart';
import 'callApi.dart'; // Assure-toi d'importer la bonne classe

class Compte extends StatelessWidget {
  final Map<String, dynamic> connectedUserData;
  const Compte({super.key, required this.connectedUserData});

  @override
  Widget build(BuildContext context) {
    var userId = connectedUserData['userId'].toString();

    return Scaffold(
      body: FutureBuilder<Map<String, dynamic>>(
        future: CompteApi.getCompteData(userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            var compteData = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                        compteData['profilePictureUrl'] ??
                            'https://via.placeholder.com/150'),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "${compteData['nom']} ${compteData['prenom']}",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Email: ${compteData['email']}",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Rôle: ${compteData['role']}",
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            );
          } else {
            return Center(child: Text('Aucune donnée disponible.'));
          }
        },
      ),
    );
  }
}
