import 'package:flutter/material.dart';
import 'callApi.dart'; // Assure-toi d'importer la bonne classe

class Compte extends StatelessWidget {
  final Map<String, dynamic> connectedUserData;
  const Compte({super.key, required this.connectedUserData});

  @override
  Widget build(BuildContext context) {
    var userId = connectedUserData['userId'].toString();

    return Scaffold(
      backgroundColor: Colors.white,
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
                  Center(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(compteData[
                              'profilePictureUrl'] ??
                          'https://plus.unsplash.com/premium_photo-1689977968861-9c91dbb16049?q=80&w=2940&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: Text(
                      "${compteData['nom']} ${compteData['prenom']}",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: Text(
                      "Email: ${compteData['email']}",
                      style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                    ),
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: Text(
                      "Rôle: ${compteData['role']}",
                      style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                    ),
                  ),
                  Spacer(), // Push the button to the bottom
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red, // Red background color
                      foregroundColor: Colors.white, // White text color
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 5, // Add shadow
                    ),
                    child: Center(child: Text('Déconnexion')),
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
