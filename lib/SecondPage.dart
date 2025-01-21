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
                return Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(jsonEncode(seance)),
                );
              }).toList(),
            ),
          );
        }
      },
    );
  }
}

/* Page Compte */
class Compte extends StatelessWidget {
  const Compte({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Mon compte"));
  }
}

/* Cartes de séances */
class CarteSeance extends StatelessWidget {
  const CarteSeance({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
      child: Card(
        color: Colors.white, // Ensure card color is white
        elevation: 0, // Remove shadow
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('10:00', style: TextStyle(fontSize: 16)),
                  SizedBox(height: 5),
                  Text('45min', style: TextStyle(fontSize: 10)),
                ],
              ),
              SizedBox(width: 10),
              Image.asset(
                'assets/aquaponey.jpg',
                height: 50,
                width: 50,
                fit: BoxFit.cover,
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Aquaponey', style: TextStyle(fontSize: 16)),
                    SizedBox(height: 5),
                    Text('Description de la séance',
                        style: TextStyle(fontSize: 12)),
                  ],
                ),
              ),
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(
                          255, 255, 168, 53), // Couleur orange du bouton
                      foregroundColor: const Color.fromARGB(
                          255, 56, 30, 30), // Couleur du texte
                      padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 0), // Réduit la taille du bouton
                    ),
                    child: Text('Réserver'),
                  ),
                  SizedBox(height: 5),
                  Text('10 places dispos', style: TextStyle(fontSize: 12)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
