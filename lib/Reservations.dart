import 'package:flutter/material.dart';
import 'callApi.dart'; // Import de l'API
import 'Seances.dart'; // Import Seances.dart

class Reservations extends StatefulWidget {
  final Map<String, dynamic> connectedUserData;

  const Reservations({super.key, required this.connectedUserData});

  @override
  _ReservationsState createState() => _ReservationsState();
}

class _ReservationsState extends State<Reservations> {
  List<dynamic> bookedSeances = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchBookedSeances();
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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text('Réservations'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : errorMessage.isNotEmpty
              ? Center(child: Text('Erreur: $errorMessage'))
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: bookedSeances.length,
                        itemBuilder: (context, index) {
                          var seance = bookedSeances[index];
                          return CarteSeance(
                            date: _extraireDate(seance['dateDebut']),
                            heureDebut: _extraireHeure(seance['dateDebut']),
                            duree: _calculerDuree(
                                seance['dateDebut'], seance['dateFin']),
                            titre: seance['titre'] ?? 'N/A',
                            description:
                                seance['description'] ?? 'Aucune description',
                            imagePath:
                                seance['URL_photo'] ?? '', // Handle null value
                            lieu: seance['lieu'] ??
                                'Lieu inconnu', // Handle null value
                            seanceId: seance['id'].toString(),
                            userId:
                                widget.connectedUserData['userId'].toString(),
                            showReserveButton: false,
                          );
                        },
                      ),
                    ),
                  ],
                ),
    );
  }

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
