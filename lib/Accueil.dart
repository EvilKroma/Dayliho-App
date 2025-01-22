import 'package:flutter/material.dart';
import 'Seances.dart'; // Import Seances.dart

class Accueil extends StatelessWidget {
  final Map<String, dynamic> connectedUserData;
  final VoidCallback onSeanceSelected; // Ajouter le callback

  const Accueil({
    super.key,
    required this.connectedUserData,
    required this.onSeanceSelected, // Modifier le constructeur
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Dashboard with two cards
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              // First Card
              Expanded(
                child: GestureDetector(
                  onTap: onSeanceSelected, // Utiliser le callback
                  child: Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Icon(Icons.event, size: 50, color: Colors.blue),
                          SizedBox(height: 10),
                          Text(
                            'Séance 1',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16),
              // Second Card
              Expanded(
                child: GestureDetector(
                  onTap: onSeanceSelected, // Utiliser le callback
                  child: Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Icon(Icons.event, size: 50, color: Colors.green),
                          SizedBox(height: 10),
                          Text(
                            'Séance 2',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Data: $connectedUserData"),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
