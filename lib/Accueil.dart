import 'package:flutter/material.dart';

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
