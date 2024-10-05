import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'banking.dart';
import 'home.dart';
import 'mail.dart';
import 'messenger.dart';
import 'phone.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
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

