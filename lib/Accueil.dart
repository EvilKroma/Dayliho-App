import 'package:flutter/material.dart';
import 'Seances.dart'; // Import Seances.dart

class Accueil extends StatelessWidget {
  final Map<String, dynamic> connectedUserData;
  final VoidCallback onSeanceSelected; // Existing callback
  final VoidCallback onCompteSelected; // New callback

  const Accueil({
    super.key,
    required this.connectedUserData,
    required this.onSeanceSelected, // Existing constructor parameter
    required this.onCompteSelected, // New constructor parameter
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
                  onTap: onSeanceSelected, // Use existing callback
                  child: Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Icon(Icons.event,
                              size: 50,
                              color: const Color.fromARGB(255, 235, 142, 2)),
                          SizedBox(height: 10),
                          Text(
                            'Planning',
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
                  onTap: onCompteSelected, // Use new callback
                  child: Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Icon(Icons.account_box,
                              size: 50,
                              color: const Color.fromARGB(255, 235, 142, 2)),
                          SizedBox(height: 10),
                          Text(
                            'Réservations',
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
        // New Full-Width Card with Background Image
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: GestureDetector(
            onTap: onSeanceSelected, // Assign desired callback
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: AssetImage(
                        'assets/news.webp'), // Replace with your image path
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.3),
                      BlendMode.darken,
                    ),
                  ),
                ),
                child: Center(
                  child: Text(
                    'Catalogue d\'exercices',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
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
