import 'package:flutter/material.dart';

class Maildetail extends StatefulWidget {
  const Maildetail({super.key});

  @override
  State<Maildetail> createState() => _MaildetailState();
}

class _MaildetailState extends State<Maildetail> {
  @override
  Widget build(BuildContext context) {
    final String mail = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: <Widget>[
          Text(mail),
          TextField(),
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Return to emails"))
        ],
      ),
    ));
  }
}
