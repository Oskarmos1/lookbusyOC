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
            child: const Text("Fake Banking App"),
            onPressed: () {
              Navigator.pushNamed(context, '/banking');
            },
          ),
          TextButton(
            child: const Text("Fake Messenger"),
            onPressed: () {
              Navigator.pushNamed(context, '/messenger');
            },
          ),
          TextButton(
            child: const Text("Fake Mail"),
            onPressed: () {
              Navigator.pushNamed(context, '/mail');
            },
          ),
          TextButton(
            child: const Text("Fake Phone Call"),
            onPressed: () {
              Navigator.pushNamed(context, '/phone');
            },
          ),
        ],
      ),
    ));
  }
}
