import 'package:flutter/material.dart';
import 'callApi.dart';
import 'SecondPage.dart'; // Import if CarteSeance is in SecondPage.dart

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
                      'assets/aquaponey.jpg', // Or use seance['imagePath'] if available
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
      return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
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
