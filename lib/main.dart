import 'package:flutter/material.dart';

import 'banking.dart';
import 'home.dart';
import 'mail.dart';
import 'messenger.dart';
import 'phone.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => const Home(),
      '/messenger': (context) => const Messenger(),
      '/banking': (context) => const Banking(),
      '/mail': (context) => const Mail(),
      '/phone': (context) => const Phone(),
    },
  ));
}


// git add .
// git commit -m "commit message"
// git push -u origin main