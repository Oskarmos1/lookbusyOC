import 'dart:math';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Random rnd = new Random();

  Color bankingBackGround = Color.fromARGB(255, 17, 17, 16);
  Color bankingWavesColor = Color.fromARGB(1, 96, 125, 139);
  Color messengerBackGround = Color.fromARGB(255, 42, 42, 42);
  Color messengerWavesColor = Color.fromARGB(1, 174, 88, 175);
  Color phoneBackGround = Color.fromARGB(255, 17, 17, 16);
  Color phoneWavesColor = Color.fromARGB(1, 27, 102, 62);
  Color mailBackGround = Color.fromARGB(255, 42, 42, 42);
  Color mailWavesColor = Color.fromARGB(1, 255, 36, 36);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFF000000),
        body: SafeArea(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Expanded(
                      child: GestureDetector(
                          onTap: () async {
                            bankingBackGround =
                                Color.fromARGB(255, 145, 145, 143);
                            bankingWavesColor =
                                Color.fromARGB(255, 145, 145, 143);
                            ;
                            setState(() {});
                            final result =
                                await Navigator.pushNamed(context, '/banking');

                            bankingBackGround = Color.fromARGB(255, 17, 17, 16);
                            bankingWavesColor = Color.fromARGB(1, 96, 125, 139);
                            setState(() {});
                          },
                          child: ClipRRect(
                            // Use ClipOval to create a circular shape
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color.fromARGB(255, 145, 145, 143),
                                    width: 2),
                                borderRadius: BorderRadius.circular(16.0),
                                color: bankingBackGround,
                              ),
                              child: AvatarGlow(
                                glowCount: 3,
                                // Adjust glow radius
                                duration: Duration(milliseconds: 2000),
                                glowRadiusFactor: 0.2,
                                glowColor: bankingWavesColor,
                                glowShape:
                                    BoxShape.circle, // Set glow shape to circle
                                child: Image.asset(
                                  "assets/BankingIcon.png",
                                  scale: 2,
                                ),
                              ),
                            ),
                          )),
                    ),
                    Expanded(
                      child: GestureDetector(
                          onTap: () async {
                            messengerBackGround =
                                Color.fromARGB(255, 145, 145, 143);

                            messengerWavesColor =
                                Color.fromARGB(255, 145, 145, 143);

                            setState(() {});
                            final result = await Navigator.pushNamed(
                                context, '/messenger');

                            messengerBackGround =
                                Color.fromARGB(255, 42, 42, 42);
                            messengerWavesColor =
                                Color.fromARGB(1, 174, 88, 175);
                            setState(() {});
                          },
                          child: ClipRRect(
                            // Use ClipOval to create a circular shape
                            child: Container(
                              decoration: BoxDecoration(
                                color: messengerBackGround, // Background color
                                border: Border.all(
                                    color: Color.fromARGB(255, 145, 145, 143),
                                    width: 2),
                                borderRadius: BorderRadius.circular(16.0),
                              ),
                              child: AvatarGlow(
                                glowCount: 3,
                                // Adjust glow radius
                                duration: Duration(milliseconds: 2100),
                                glowRadiusFactor: 0.2,
                                glowColor: messengerWavesColor,
                                glowShape:
                                    BoxShape.circle, // Set glow shape to circle
                                child: Image.asset(
                                  "assets/MessengerIcon.png",
                                  scale: 1.35,
                                ),
                              ),
                            ),
                          )),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Expanded(
                      child: GestureDetector(
                          onTap: () async {
                            mailBackGround = Color.fromARGB(255, 145, 145, 143);
                            ;
                            mailWavesColor = Color.fromARGB(255, 145, 145, 143);
                            ;
                            setState(() {});
                            final result =
                                await Navigator.pushNamed(context, '/mail');

                            mailBackGround = Color.fromARGB(255, 42, 42, 42);
                            mailWavesColor = Color.fromARGB(1, 255, 36, 36);
                            setState(() {});
                          },
                          child: ClipRRect(
                            // Use ClipOval to create a circular shape
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color.fromARGB(255, 145, 145, 143),
                                    width: 2),
                                borderRadius: BorderRadius.circular(16.0),
                                color: mailBackGround, // Background color
                              ),
                              child: AvatarGlow(
                                glowCount: 3,
                                // Adjust glow radius
                                duration: Duration(milliseconds: 1900),
                                glowRadiusFactor: 0.2,
                                glowColor: mailWavesColor,
                                glowShape:
                                    BoxShape.circle, // Set glow shape to circle
                                child: Image.asset(
                                  "assets/EmailIcon.png",
                                  scale: 2,
                                ),
                              ),
                            ),
                          )),
                    ),
                    Expanded(
                      child: GestureDetector(
                          onTap: () async {
                            phoneBackGround =
                                Color.fromARGB(255, 145, 145, 143);
                            ;
                            phoneWavesColor =
                                Color.fromARGB(255, 145, 145, 143);
                            ;
                            setState(() {});
                            final result =
                                await Navigator.pushNamed(context, '/phone');

                            phoneBackGround = Color.fromARGB(255, 17, 17, 16);
                            phoneWavesColor = Color.fromARGB(1, 27, 102, 62);
                            setState(() {});
                          },
                          child: ClipRRect(
                            // Use ClipOval to create a circular shape
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Color.fromARGB(255, 145, 145, 143),
                                    width: 2),
                                borderRadius: BorderRadius.circular(16.0),
                                color: phoneBackGround, // Background color
                              ),
                              child: AvatarGlow(
                                glowCount: 3,
                                // Adjust glow radius
                                duration: Duration(milliseconds: 2200),
                                glowRadiusFactor: 0.2,
                                glowColor: phoneWavesColor,
                                glowShape:
                                    BoxShape.circle, // Set glow shape to circle
                                child: Image.asset(
                                  "assets/PhoneIcon.png",
                                  scale: 2,
                                ),
                              ),
                            ),
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
