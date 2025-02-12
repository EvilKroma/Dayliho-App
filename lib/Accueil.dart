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

  @override
  void initState() {
    super.initState();
    fetchBookedSeances(); // Récupérer les séances dès le début
  }

  Future<void> fetchBookedSeances() async {
    var userId = widget.connectedUserData['userId'].toString();
    var data = await getBookedSeances.GetBookedSeances(userId);

    print("Réponse API (débug) : $data");

    if (data.containsKey('bookedSeances')) {
      var bookedList = data['bookedSeances'];
      if (bookedList is! List) {
        setState(() {
          errorMessage =
              "Format incorrect : expected a list but got ${bookedList.runtimeType}";
          isLoading = false;
        });
        return;
      }

      // Vérifions si bookedList est bien une liste
      if (bookedList is List) {
        setState(() {
          bookedSeances = List<dynamic>.from(bookedList);
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage =
              "Format incorrect : expected a list but got ${bookedList.runtimeType}";
          isLoading = false;
        });
      }
    } else {
      setState(() {
        errorMessage = "Format de réponse inattendu";
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var userId = widget.connectedUserData['userId'].toString();

    return Column(
      children: [
        // Dashboard avec les cartes
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: widget.onSeanceSelected,
                  child: Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Icon(Icons.event,
                              size: 50,
                              color: Color.fromARGB(255, 235, 142, 2)),
                          SizedBox(height: 10),
                          Text('Planning', style: TextStyle(fontSize: 16)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: GestureDetector(
                  onTap: widget.onCompteSelected,
                  child: Card(
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Icon(Icons.account_box,
                              size: 50,
                              color: Color.fromARGB(255, 235, 142, 2)),
                          SizedBox(height: 10),
                          Text('Réservations', style: TextStyle(fontSize: 16)),
                        ],
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

        // Affichage des séances réservées
      ],
    );
  }
}
