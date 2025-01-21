import 'dart:convert';

import 'package:flutter/material.dart';
import 'callApi.dart'; // Import the callApi.dart file

/* Page entière */
class SecondPage extends StatefulWidget {
  final String email;
  final Map<String, dynamic> connectedUserData;
  const SecondPage(
      {super.key, required this.email, required this.connectedUserData});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set background color to white
      // appBar: AppBar(title: Text("Utilisateur : ${widget.email}")),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.logout),
        ),
        automaticallyImplyLeading: true, // Retire le bouton déconnexion
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Color.fromARGB(255, 255, 168, 53),
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Accueil',
          ),
          NavigationDestination(
            icon: Badge(label: Text('3'), child: Icon(Icons.sports)),
            label: 'Séances',
          ),
          NavigationDestination(
            icon: Badge(
              label: Text('2'),
              child: Icon(Icons.account_box_sharp),
            ),
            label: 'Compte',
          ),
        ],
      ),
      body: [
        Accueil(connectedUserData: widget.connectedUserData),
        Seances(),
        Compte(),
      ][currentPageIndex],
    );
  }
}

/* Page Accueil */
class Accueil extends StatelessWidget {
  final Map<String, dynamic> connectedUserData;
  const Accueil({super.key, required this.connectedUserData});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Data: $connectedUserData"),
        ],
      ),
    );
  }
}

/* Page Séances */

/* Page Compte */
class Compte extends StatelessWidget {
  const Compte({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Mon compte"));
  }
}

/* Page Séances */
class Seances extends StatelessWidget {
  const Seances({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: Seance.getSeances(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Erreur: ${snapshot.error}"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text("Aucune donnée disponible"));
        } else {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: snapshot.data!.map((seance) {
                return CarteSeance(
                  heureDebut: _extraireHeure(seance['dateDebut']),
                  duree: _calculerDuree(seance['dateDebut'], seance['dateFin']),
                  titre: seance['titre'] ?? 'N/A',
                  description: seance['description'] ?? 'Aucune description',
                  imagePath:
                      'assets/aquaponey.jpg', // Par défaut, ou depuis le JSON
                  placesDisponibles: seance['nombrePlaces'] ?? 0,
                );
              }).toList(),
            ),
          );
        }
      },
    );
  }

  // Fonction pour extraire uniquement l'heure d'une date
  String _extraireHeure(String? date) {
    if (date == null) return 'Heure inconnue';
    try {
      DateTime dateTime = DateTime.parse(date);
      return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')} ';
    } catch (e) {
      return 'Heure invalide';
    }
  }

  // Fonction pour calculer la durée
  String _calculerDuree(String? dateDebut, String? dateFin) {
    if (dateDebut == null || dateFin == null) return 'Durée inconnue';
    try {
      DateTime debut = DateTime.parse(dateDebut);
      DateTime fin = DateTime.parse(dateFin);
      Duration difference = fin.difference(debut);

      int heures = difference.inHours;
      int minutes = difference.inMinutes % 60;

      return '${heures}h ${minutes}min';
    } catch (e) {
      return 'Durée invalide';
    }
  }
}

/* Classe CarteSeance */
class CarteSeance extends StatelessWidget {
  final String heureDebut;
  final String duree;
  final String titre;
  final String description;
  final String imagePath;
  final int placesDisponibles;

  const CarteSeance({
    super.key,
    required this.heureDebut,
    required this.duree,
    required this.titre,
    required this.description,
    required this.imagePath,
    required this.placesDisponibles,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Card(
        color: Colors.white,
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(heureDebut, style: TextStyle(fontSize: 16)),
                  SizedBox(height: 5),
                  Text(duree, style: TextStyle(fontSize: 10)),
                ],
              ),
              SizedBox(width: 10),
              Image.asset(
                imagePath,
                height: 50,
                width: 50,
                fit: BoxFit.cover,
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(titre, style: TextStyle(fontSize: 16)),
                    SizedBox(height: 5),
                    Text(description, style: TextStyle(fontSize: 12)),
                  ],
                ),
              ),
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 255, 168, 53),
                      foregroundColor: const Color.fromARGB(255, 56, 30, 30),
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    ),
                    child: Text('Réserver'),
                  ),
                  SizedBox(height: 5),
                  Text('$placesDisponibles places dispos',
                      style: TextStyle(fontSize: 12)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
