import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: <Widget>[
          TextButton(
            child: Text("Fake Banking App"),
            onPressed: () {
              Navigator.pushNamed(context, '/banking');
            },
          ),
          TextButton(
            child: Text("Fake Messenger"),
            onPressed: () {
              Navigator.pushNamed(context, '/messenger');
            },
          ),
          TextButton(
            child: Text("Fake Mail"),
            onPressed: () {
              Navigator.pushNamed(context, '/mail');
            },
          ),
          TextButton(
            child: Text("Fake Phone Call"),
            onPressed: () {
              Navigator.pushNamed(context, '/phone');
            },
          ),
        ],
      ),
    ));
  }
}
