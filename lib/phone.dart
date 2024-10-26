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
  double preCallOpacity =
      1.0; // Initially, the incoming call screen is visible.
  double callOpacity = 0.0; // Call screen (after pick-up) starts invisible.
  double postCallOpacity = 0.0;
  List<Timer> timers = [];
  bool isMuted = false;
  bool isCallActive = false;
  Timer? callTimer;
  int callDuration = 0;
  bool started = true;
  @override
  void dispose() {
    super.dispose();
    for (var timer in timers) {
      timer.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (started == true) {
      started = false;
      Clipboard.setData(ClipboardData(text: ''));
      for (int i = 0; i < 10; i++) {
        timers.add(Timer(Duration(seconds: i * 4), () {
          if (isCallActive == false) {
            Vibration.vibrate(amplitude: 250, duration: 1000);
          }
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
                      padding: const EdgeInsets.only(top: 50.0),
                      child: Column(
                        children: const [
                          Text(
                            "John Appleseed",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "calling mobile...",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
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
                      const Text(
                        "John Appleseed",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        _formatCallDuration(callDuration),
                        style: TextStyle(
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
                            });
                          }),
                          _buildCallButton(Icons.dialpad, "Keypad"),
                          _buildCallButton(Icons.volume_up, "Audio"),
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
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30.0),
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          callOpacity = 0.0;
                          postCallOpacity = 1.0; // Show call end screen
                          isCallActive = false;
                        });
                        _endCallTimer();
                      },
                      icon: const Icon(Icons.call_end, color: Colors.white),
                      iconSize: 60,
                      color: Colors.red,
                      padding: const EdgeInsets.all(20),
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

  Widget _buildCallButton(IconData icon, String label, [VoidCallback? onTap]) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: CircleAvatar(
            backgroundColor: Colors.grey[800],
            radius: 30,
            child: Icon(icon, color: Colors.white, size: 30),
          ),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 14)),
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
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 14)),
      ],
    );
  }

  void _startCallTimer() {
    callTimer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (isCallActive) {
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
