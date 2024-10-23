import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Phone extends StatefulWidget {
  const Phone({super.key});

  @override
  State<Phone> createState() => _PhoneState();
}

class _PhoneState extends State<Phone> {
  double callOpacity = 0.0;
  double preCallOpacity = 1.0;
  double postCallOpacity = 0.0;
  List<Timer> timers = [];
  @override
  void dispose() {
    super.dispose();
    for (int i = 0; i < timers.length; i++) {
      timers[i].cancel();
    }
  }

  bool started = true;
  Timer? x;
  @override
  Widget build(BuildContext context) {
    if (started == true) {
      started = false;
      Clipboard.setData(ClipboardData(text: ''));
      for (int i = 0; i < 10; i++) {
        timers.add(Timer(Duration(seconds: i * 4), () {
          //Vibration.vibrate(amplitude: 250, duration: 1000);
        }));
      }
      Timer(Duration(seconds: 40), () {
        if (mounted) {
          setState(() {
            preCallOpacity = 0.0;
            postCallOpacity = 1.0;
          });
        }
      });
    }
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            const Text("Phone App"),
            Opacity(
              opacity: preCallOpacity,
              child: TextButton(
                  onPressed: () {
                    if (preCallOpacity == 1.0) {
                      for (int i = 0; i < timers.length; i++) {
                        timers[i].cancel();
                      }
                      setState(() {
                        preCallOpacity = 0.0;
                        callOpacity = 1.0;
                      });
                    }
                  },
                  child: const Text("Pick up phone.")),
            ),
            Opacity(
              opacity: preCallOpacity,
              child: TextButton(
                  onPressed: () {
                    if (preCallOpacity == 1.0) {
                      for (int i = 0; i < timers.length; i++) {
                        timers[i].cancel();
                      }
                      setState(() {
                        preCallOpacity = 0.0;
                        postCallOpacity = 1.0;
                      });
                    }
                  },
                  child: const Text("Decline")),
            ),
            TextButton(
                onPressed: () {},
                child: Opacity(
                  child: Text("Mute"),
                  opacity: callOpacity,
                )),
            TextButton(
                onPressed: () {},
                child: Opacity(
                  child: Text("Keypad"),
                  opacity: callOpacity,
                )),
            TextButton(
                onPressed: () {},
                child: Opacity(
                  child: Text("Facetime"),
                  opacity: callOpacity,
                )),
            TextButton(
                onPressed: () {},
                child: Opacity(
                  child: Text("Audio"),
                  opacity: callOpacity,
                )),
            TextButton(
                onPressed: () {},
                child: Opacity(
                  child: Text("Add"),
                  opacity: callOpacity,
                )),
            TextButton(
                onPressed: () {
                  if (callOpacity == 1.0) {
                    setState(() {
                      callOpacity = 0.0;
                      postCallOpacity = 1.0;
                    });
                  }
                },
                child: Opacity(
                  child: Text("Decline"),
                  opacity: callOpacity,
                )),
            Opacity(opacity: postCallOpacity, child: Text("Call ended")),
            Opacity(
                opacity: postCallOpacity,
                child: TextButton(
                  child: Text("Return home"),
                  onPressed: () {
                    if (postCallOpacity == 1.0) {
                      Navigator.pop(context);
                    }
                  },
                )),
          ],
        ),
      ),
    );
  }
}
