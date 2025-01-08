import 'package:flutter/material.dart';
import 'package:myapp/callApi.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: FirstPage(),
    theme: ThemeData.dark(),
  ));
}

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  final TextEditingController _userController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _loginFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _userController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "nom d'utilisateur",
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Erreur : entrer un texte correct';
                }
                return null;
              },
            ),
            ElevatedButton(
              onPressed: () {
                if (_loginFormKey.currentState!.validate()) {
                  String login = _userController.text;
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => SecondPage(firstValue: login)),
                  );
                }
              },
              child: const Text("Valider"),
            ),
          ],
        ),
      ),
    );
  }
}

class SecondPage extends StatefulWidget {
  final String firstValue;
  const SecondPage({super.key, required this.firstValue});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  late Future<List> _user;

  @override
  void initState() {
    super.initState();
    _user = Utilisateur.getAllUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.firstValue)),
      body: Container(
        child: FutureBuilder<List>(
          future: _user,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, i) {
                  final nom = snapshot.data?[i]['nom'] ?? 'Nom non disponible';
                  final prenom =
                      snapshot.data?[i]['prenom'] ?? 'Prénom non disponible';
                  print(snapshot.data?[i]);
                  return Card(
                    child: ListTile(
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(nom, style: const TextStyle(fontSize: 20)),
                          Text(prenom, style: const TextStyle(fontSize: 20)),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: Text("Pas de données"),
              );
            }
          },
        ),
      ),
    );
  }
}
