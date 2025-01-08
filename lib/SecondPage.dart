import 'package:flutter/material.dart';
import 'callApi.dart';

class SecondPage extends StatefulWidget {
  final String firstValue;
  final Map<String, dynamic> user;
  const SecondPage({super.key, required this.firstValue, required this.user});

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  late Future<List> _user;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("${widget.firstValue}")),
      body: Container(child: Text("test")),
    );
  }
}
