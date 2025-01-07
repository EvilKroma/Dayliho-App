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
      body: Center(
        child: Container(
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: EdgeInsets.all(50),
            child: Text('Flutter')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => print('FloatingActionButton cliqué'),
        child: Icon(Icons.add),
      ),
    );
  }
}
