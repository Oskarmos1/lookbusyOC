import 'package:flutter/material.dart';

class Phone extends StatefulWidget {
  const Phone({super.key});

  @override
  State<Phone> createState() => _PhoneState();
}

class _PhoneState extends State<Phone> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            const Text("Phone App"),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Return to home."))
          ],
        ),
      ),
    );
  }
}
