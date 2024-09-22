import 'package:flutter/material.dart';

class Banking extends StatefulWidget {
  const Banking({super.key});

  @override
  State<Banking> createState() => _BankingState();
}

class _BankingState extends State<Banking> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Text("Banking App"),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Return to home."))
          ],
        ),
      ),
    );
  }
}
