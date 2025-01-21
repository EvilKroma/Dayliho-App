import 'dart:convert';

import 'package:flutter/material.dart';
import 'callApi.dart'; // Import the callApi.dart file
import 'Accueil.dart'; // Import Accueil.dart
import 'Seances.dart'; // Import Seances.dart
import 'Compte.dart'; // Import Compte.dart

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

/* Cartes de séances */
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
