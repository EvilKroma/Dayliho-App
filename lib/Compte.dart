import 'package:flutter/material.dart';

class Compte extends StatelessWidget {
  final Map<String, dynamic> connectedUserData;
  const Compte({super.key, required this.connectedUserData});

  @override
  Widget build(BuildContext context) {
    // Récupération de l'ID de l'utilisateur
    var userId = connectedUserData['userId'];

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("User ID: $userId"),
        ],
      ),
    );
  }
}
