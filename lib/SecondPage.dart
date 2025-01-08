import 'package:flutter/material.dart';

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
      appBar: AppBar(title: Text("Utilisateur : ${widget.email}")),
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
            // Bouton 1
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Accueil',
          ),
          NavigationDestination(
            // Bouton 2
            icon: Badge(label: Text('3'), child: Icon(Icons.sports)),
            label: 'Séances',
          ),
          NavigationDestination(
            // Bouton 3
            icon: Badge(
              label: Text('2'), // Affiche le nombre de messages
              child: Icon(Icons.account_box_sharp),
            ),
            label: 'Compte',
          ),
        ],
      ),
      body: <Widget>[
        // Tableau de widgets ayant chacun un index
        // Page d'accueil
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Data: ${widget.connectedUserData}"),
            ],
          ),
        ),
        // Page Notifications
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: Text(
                  'Séances à venir',
                  style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                ),
              ),
              // Liste des cartes Séance
              ListView.builder(
                shrinkWrap:
                    true, // Important pour éviter les conflits de hauteur
                physics:
                    NeverScrollableScrollPhysics(), // Pas de défilement interne
                itemCount: 5, // Nombre de cartes à afficher
                itemBuilder: (context, index) {
                  return SeanceCard(); // Génération des cartes
                },
              ),
            ],
          ),
        ),
        // Page Messages
        Center(child: Text("Mon compte")),
      ][currentPageIndex],
    );
  }
}

class SeanceCard extends StatefulWidget {
  const SeanceCard({super.key});

  @override
  State<SeanceCard> createState() => _SeanceCardState();
}

class _SeanceCardState extends State<SeanceCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Image.asset(
              'assets/aquaponey.jpg',
              height: 200, // Ajusté pour éviter un débordement
              fit: BoxFit.cover, // S'assure que l'image est bien contenue
            ),
            ListTile(
              title: Text('Aquaponey'),
              subtitle:
                  Text('Date: 12/12/2023\nHeure: 10:00 AM\nCoach: John Doe'),
            ),
          ],
        ),
      ),
    );
  }
}
