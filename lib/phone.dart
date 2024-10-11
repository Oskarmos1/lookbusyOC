import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vibration/vibration.dart';

class Phone extends StatefulWidget {
  const Phone({super.key});

  @override
  State<Phone> createState() => _PhoneState();
}

class _PhoneState extends State<Phone> {
  @override
  void dispose() {
    super.dispose();
    x?.cancel();
  }

  Timer? x;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            const Text("Phone App"),
            TextButton(
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: ''));
                  for (int i = 0; i < 10; i++) {
                    x = Timer(Duration(seconds: i * 4), () {
                      Vibration.vibrate(amplitude: 250, duration: 1000);
                    });
                  }
                },
                child: Text("Press to vibrate phone")),
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
