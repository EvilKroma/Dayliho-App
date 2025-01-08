import 'package:flutter/material.dart';
import 'package:myapp/callApi.dart';
import 'SecondPage.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  final TextEditingController _userEmail = TextEditingController();
  final TextEditingController _userPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _loginFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _userEmail,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Email",
              ),
              validator: (value) {
                if (value == null || value.isEmpty || !value.contains('@')) {
                  return 'Veuillez entrer un email valide';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _userPassword,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Mot de passe",
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Mot de passe invalide';
                }
                return null;
              },
            ),
            ElevatedButton(
              onPressed: () async {
                if (_loginFormKey.currentState!.validate()) {
                  String email = _userEmail.text;
                  String password = _userPassword.text;
                  try {
                    Map<String, dynamic> user =
                        await Utilisateur.checkUser(email, password);
                    if (user.isNotEmpty) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                SecondPage(firstValue: email, user: user)),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(
                                'Utilisateur non trouvé ou mot de passe incorrect')),
                      );
                    }
                  } catch (error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Erreur: $error')),
                    );
                  }
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
