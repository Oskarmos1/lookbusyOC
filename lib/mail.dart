import 'package:flutter/material.dart';

class Mail extends StatefulWidget {
  const Mail({super.key});

  @override
  State<Mail> createState() => _MailState();
}

class _MailState extends State<Mail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            const Text("Mail App"),
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
