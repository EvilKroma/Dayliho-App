import 'package:flutter/material.dart';

class Compte extends StatelessWidget {
  const Compte({super.key, required this.connectedUserData});

  final Map<String, dynamic> connectedUserData;

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
