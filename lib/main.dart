import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import 'banking.dart'; // Update with your actual import
import 'home.dart'; // Update with your actual import
import 'mail.dart'; // Update with your actual import
import 'mailDetail.dart'; // Update with your actual import
import 'messenger.dart'; // Update with your actual import
import 'moneyExchange.dart'; // Update with your actual import
import 'phone.dart'; // Update with your actual import

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Your App Title', // Optional: Set your app title
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/messenger': (context) => const Messenger(),
        '/banking': (context) => const Banking(),
        '/mail': (context) => const Mail(),
        '/phone': (context) => const Phone(),
        '/moneyExchange': (context) => const Moneyexchange(),
        '/mailDetail': (context) => const Maildetail(),
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  void _navigateToHome() async {
    await Future.delayed(Duration(seconds: 2)); // Simulate loading
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
          builder: (context) => const Home()), // Navigate to the Home screen
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      ),
    );
  }
}
