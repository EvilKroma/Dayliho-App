import 'package:flutter/material.dart';
import 'callApi.dart';

class Seances extends StatelessWidget {
  final String userId; // Add userId parameter

  const Seances({super.key, required this.userId}); // Update constructor

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text('Séances'),
      ),
      body: FutureBuilder<List<dynamic>>(
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
                    date: _extraireDate(seance['dateDebut']), // Pass the date
                    heureDebut: _extraireHeure(seance['dateDebut']),
                    duree:
                        _calculerDuree(seance['dateDebut'], seance['dateFin']),
                    titre: seance['titre'] ?? 'N/A',
                    description: seance['description'] ?? 'Aucune description',
                    imagePath: seance['URL_photo'] ?? '', // Handle null value
                    lieu: seance['lieu'] ?? 'Lieu inconnu', // Handle null value
                    seanceId: seance['id'].toString(), // Ajout du seanceId
                    userId: userId, // Pass userId to CarteSeance
                  );
                }).toList(),
              ),
            );
          }
        },
      ),
    );
  }

  // Fonction pour extraire uniquement l'heure d'une date
  String _extraireHeure(String? date) {
    if (date == null) return 'Heure inconnue';
    try {
      DateTime dateTime = DateTime.parse(date);
      return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    } catch (e) {
      return 'Heure invalide';
    }
  }

  // Fonction pour extraire la date en jj/mm
  String _extraireDate(String? date) {
    if (date == null) return 'Date inconnue';
    try {
      DateTime dateTime = DateTime.parse(date);
      return '${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}';
    } catch (e) {
      return 'Date invalide';
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

class CarteSeance extends StatelessWidget {
  final String date;
  final String heureDebut;
  final String duree;
  final String titre;
  final String lieu;
  final String description;
  final String imagePath;
  final String seanceId;
  final String userId;
  final bool showReserveButton; // Add this parameter

  const CarteSeance({
    super.key,
    required this.date,
    required this.heureDebut,
    required this.duree,
    required this.titre,
    required this.lieu,
    required this.description,
    required this.imagePath,
    required this.seanceId,
    required this.userId,
    this.showReserveButton = true, // Default to true
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
                  Text(date,
                      style: TextStyle(fontSize: 12)), // Display the date
                  SizedBox(height: 5),
                  Text(heureDebut, style: TextStyle(fontSize: 16)),
                  SizedBox(height: 5),
                  Text(duree, style: TextStyle(fontSize: 10)),
                ],
              ),
              SizedBox(width: 10),
              Image.network(
                imagePath,
                height: 50,
                width: 50,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons
                      .error); // Display an error icon if the image fails to load
                },
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(titre, style: TextStyle(fontSize: 14)),
                    SizedBox(height: 5),
                    Text(description, style: TextStyle(fontSize: 10)),
                    SizedBox(height: 5),
                    Text(lieu, style: TextStyle(fontSize: 8)),
                  ],
                ),
              ),
              Column(
                children: [
                  if (showReserveButton)
                    ElevatedButton(
                      onPressed: () async {
                        try {
                          var response =
                              await BookSeance.bookSeance(userId, seanceId);

                          // Vérifier si la réponse indique un succès ou une erreur
                          bool isSuccess = response['success'] ?? false;
                          String message =
                              response['message'] ?? 'Opération terminée';

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(message),
                              backgroundColor:
                                  isSuccess ? Colors.green : Colors.red,
                            ),
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Erreur: $e'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 255, 168, 53),
                        foregroundColor: const Color.fromARGB(255, 56, 30, 30),
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                      ),
                      child: Text('Réserver'),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
