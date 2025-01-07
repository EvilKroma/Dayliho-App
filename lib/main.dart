import 'package:flutter/material.dart';

void main() {
  runApp(/*const*/ MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Principale(),
    theme: ThemeData.dark(),
  ));
}

class Principale extends StatelessWidget {
  const Principale({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Text('Leading'),
        title: Text('Title'),
        titleTextStyle: TextStyle(color: Colors.red, fontSize: 40),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: Center(child: Text('Psahtek')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => print('FloatingActionButton cliqué'),
        child: Icon(Icons.add),
      ),
    );
  }
}
