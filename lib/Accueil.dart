import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'CallApi.dart'; // Import de l'API
import 'Seances.dart'; // Import Seances.dart

class Accueil extends StatefulWidget {
  final Map<String, dynamic> connectedUserData;
  final VoidCallback onSeanceSelected;
  final VoidCallback onCompteSelected;

  const Accueil({
    super.key,
    required this.connectedUserData,
    required this.onSeanceSelected,
    required this.onCompteSelected,
  });

  @override
  _AccueilState createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  List<dynamic> bookedSeances = []; // Stocke les séances réservées
  bool isLoading = true; // Indique si les données sont en cours de chargement
  String errorMessage = ''; // Stocke les erreurs éventuelles
  String? userId; // ID de l'utilisateur
  Map<String, dynamic>? compteData; // Données du compte

  @override
  void initState() {
    super.initState();
    fetchUserId(); // Récupérer les données du compte
    fetchBookedSeances(); // Récupérer les séances dès le début
  }

  Future<void> fetchUserId() async {
    try {
      var id = widget.connectedUserData['userId'].toString();
      var data = await CompteApi.getCompteData(id);
      setState(() {
        userId = data['id'].toString();
        compteData = data;
      });
      print("ID du compte récupéré: $userId");
    } catch (err) {
      print("Erreur lors de la récupération de l'ID du compte: $err");
    }
  }

  Future<void> fetchBookedSeances() async {
    try {
      var id = widget.connectedUserData['userId'].toString();
      var data = await getBookedSeances.GetBookedSeances(id);

      if (data is List) {
        setState(() {
          bookedSeances = data;
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = "Format de réponse inattendu";
          isLoading = false;
        });
      }
    } catch (err) {
      setState(() {
        errorMessage = err.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Dashboard avec les cartes
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: widget.onSeanceSelected,
                      child: SizedBox(
                        height: 150, // Set a fixed height
                        child: Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.event,
                                    size: 50,
                                    color: Color.fromARGB(255, 235, 142, 2)),
                                SizedBox(height: 10),
                                Text('Planning',
                                    style: TextStyle(fontSize: 16)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: GestureDetector(
                      onTap: widget.onCompteSelected,
                      child: SizedBox(
                        height: 150, // Set a fixed height
                        child: Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Ensure the size of the number of reservations matches the icon size
                                Text(
                                  '${bookedSeances.length}',
                                  style: TextStyle(
                                    fontSize: 50,
                                    color: Color.fromARGB(255, 235, 142, 2),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text('Réservations',
                                    style: TextStyle(fontSize: 16)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Carte pour le catalogue d'exercices
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GestureDetector(
                onTap: widget.onSeanceSelected,
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
                        image: AssetImage('assets/news.webp'),
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                          Colors.black.withOpacity(0.5),
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
            // Titre des séances réservées
            // Affichage des séances réservées
          ],
        ),
      ),
    );
  }
}
