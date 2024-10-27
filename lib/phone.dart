import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart'; // Import google_fonts package
import 'package:lookbusy/emails.dart'; // Ensure this file exists and contains the required names
import 'package:vibration/vibration.dart';

class Phone extends StatefulWidget {
  const Phone({super.key});

  @override
  State<Phone> createState() => _PhoneState();
}

class _PhoneState extends State<Phone> {
  double preCallOpacity =
      1.0; // Initially, the incoming call screen is visible.
  double callOpacity = 0.0; // Call screen (after pick-up) starts invisible.
  double postCallOpacity = 0.0;
  Color muteBackgroundColor = Colors.grey[800]!;
  Color muteIconColor = Colors.white;
  Color speakerBackgroundColor = Colors.grey[800]!;
  Color speakerIconColor = Colors.white;
  List<Timer> timers = [];
  bool isMuted = false;
  bool isSpeakerOn = false; // Speaker button state
  bool isCallActive = false; // Indicates if the call is active
  Timer? callTimer;
  int callDuration = 0;
  bool started = true;
  String randomName = "Contact Name";

  @override
  void dispose() {
    for (var timer in timers) {
      timer.cancel();
    }
    callTimer?.cancel(); // Ensure the call timer is also canceled
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (started) {
      Random rnd = Random();
      randomName = MyMails.names[rnd.nextInt(MyMails.names.length)];
      started = false;

      Clipboard.setData(ClipboardData(text: ''));
      for (int i = 0; i < 10; i++) {
        timers.add(Timer(Duration(seconds: i * 4), () {
          if (!isCallActive) {
            Vibration.vibrate(amplitude: 250, duration: 1000);
          }
        }));
      }

      Timer(Duration(seconds: 40), () {
        if (mounted && callOpacity == 0.0) {
          setState(() {
            preCallOpacity = 0.0;
            postCallOpacity = 1.0;
          });
        }
      });
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            // Pre-call screen (Incoming call)
            Visibility(
              visible: preCallOpacity == 1.0,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 70.0),
                      child: Column(
                        children: [
                          Text(
                            randomName,
                            style: GoogleFonts.roboto(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "calling mobile...",
                            style: GoogleFonts.roboto(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    // Buttons for Pick up and Decline
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildActionButton(Icons.call, "Pick Up", Colors.green,
                            () {
                          // Accept the call
                          setState(() {
                            preCallOpacity = 0.0;
                            callOpacity =
                                1.0; // Now the call screen is visible.
                            isCallActive = true; // Set call active to true
                            for (var timer in timers) {
                              timer.cancel();
                            }
                          });
                          _startCallTimer();
                        }),
                        _buildActionButton(
                            Icons.call_end, "Decline", Colors.red, () {
                          // Decline the call
                          setState(() {
                            for (var timer in timers) {
                              timer.cancel();
                            }
                            preCallOpacity = 0.0;
                            postCallOpacity =
                                1.0; // Transition to call end screen
                          });
                        }),
                      ],
                    ),
                    SizedBox(height: 40),
                  ],
                ),
              ),
            ),

            // In-call screen (after answering the call)
            Visibility(
              visible: callOpacity == 1.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Call duration and caller info at the top
                  Column(
                    children: [
                      Text(
                        randomName,
                        style: GoogleFonts.roboto(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        _formatCallDuration(callDuration),
                        style: GoogleFonts.roboto(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),

                  // Action buttons (Mute, Keypad, etc.)
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildCallButton(
                              Icons.mic_off, isMuted ? "Unmute" : "Mute", () {
                            setState(() {
                              isMuted = !isMuted;
                              if (isMuted) {
                                muteBackgroundColor = Colors.white;
                                muteIconColor = Colors.grey;
                              } else {
                                muteBackgroundColor = Colors.grey[800]!;
                                muteIconColor = Colors.white;
                              }
                            });
                          }, muteBackgroundColor, muteIconColor),
                          _buildCallButton(Icons.dialpad, "Keypad"),
                          _buildCallButton(Icons.volume_up,
                              isSpeakerOn ? "Speaker" : "Speaker", () {
                            setState(() {
                              isSpeakerOn = !isSpeakerOn;
                              if (isSpeakerOn) {
                                speakerBackgroundColor = Colors.white;
                                speakerIconColor = Colors.grey;
                              } else {
                                speakerBackgroundColor = Colors.grey[800]!;
                                speakerIconColor = Colors.white;
                              }
                            });
                          }, speakerBackgroundColor, speakerIconColor),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildCallButton(Icons.add, "Add Call"),
                          _buildCallButton(Icons.video_call, "FaceTime"),
                          _buildCallButton(Icons.contacts, "Contacts"),
                        ],
                      ),
                    ],
                  ),

                  // End call button

                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          callOpacity = 0.0;
                          postCallOpacity = 1.0; // Show call end screen
                          isCallActive = false; // Set call active to false
                        });
                        _endCallTimer();
                      },
                      icon: const Icon(Icons.call_end, color: Colors.white),
                      iconSize: 40,
                      color: Colors.red,
                      padding: const EdgeInsets.all(15),
                      splashRadius: 35,
                      splashColor: Colors.redAccent,
                    ),
                  ),
                ],
              ),
            ),

            // Post-call screen (Call ended)
            Visibility(
              visible: postCallOpacity == 1.0,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Call Ended",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: 'Roboto',
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Return Home",
                          style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCallButton(IconData icon, String label,
      [VoidCallback? onTap, Color? backgroundColor, Color? iconColor]) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: CircleAvatar(
            backgroundColor: backgroundColor ?? Colors.grey[800],
            radius: 30,
            child: Icon(icon, color: iconColor ?? Colors.white, size: 30),
          ),
        ),
        const SizedBox(height: 8),
        Text(label,
            style: GoogleFonts.roboto(
                color: iconColor ?? Colors.white, fontSize: 14)),
      ],
    );
  }

  Widget _buildActionButton(
      IconData icon, String label, Color color, VoidCallback onTap) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: CircleAvatar(
            backgroundColor: color,
            radius: 30,
            child: Icon(icon, color: Colors.white, size: 30),
          ),
        ),
        const SizedBox(height: 8),
        Text(label,
            style: GoogleFonts.roboto(color: Colors.white, fontSize: 14)),
      ],
    );
  }

  void _startCallTimer() {
    callTimer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (isCallActive) {
        // Check if the call is active before incrementing
        setState(() {
          callDuration++;
        });
      }
    });
  }

  void _endCallTimer() {
    callTimer?.cancel();
    callDuration = 0;
  }

  String _formatCallDuration(int durationInSeconds) {
    final minutes = durationInSeconds ~/ 60;
    final seconds = durationInSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}
