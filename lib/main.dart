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
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              for (int i = 0; i < 3; i++) DataColumn(),
            ]),
            for (int i = 0; i < 3; i++) DataRow(),
          ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () => print('FloatingActionButton cliqué'),
        child: Icon(Icons.add),
      ),
    );
  }
}

class DataRow extends StatelessWidget {
  const DataRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      padding: EdgeInsets.all(20),
      width: 450,
      child: Text('data'),
    );
  }
}

class DataColumn extends StatelessWidget {
  const DataColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      padding: EdgeInsets.all(20),
      child: Text('data ligne'),
    );
  }
}
