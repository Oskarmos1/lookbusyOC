import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lookbusy/emails.dart';

class Mail extends StatefulWidget {
  const Mail({super.key});

  @override
  State<Mail> createState() => _MailState();
}

bool isLoadingMore = false;

class _MailState extends State<Mail> {
  ScrollController scrollController = ScrollController();
  Random rnd = new Random();
  bool started = true;
  List<String> outputMails = [];
  List<int> mailIndex = [];
  int mailCount = 0;
  @override
  void initState() {
    super.initState();
    mailCount = rnd.nextInt(4000) + 2000;
    if (mounted) {
      setState(() {});
    }
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent - 10 &&
          isLoadingMore == false) {
        isLoadingMore = true;
        loadMoreEmails();
      }
    });
  }

  void loadMoreEmails() async {
    double screenWidth = MediaQuery.of(context).size.width;
    generateEmails(screenWidth);
    setState(() {});
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  void generateEmails(double screenWidth) async {
    for (int i = 0; i < 15; i++) {
      setState(() {
        int x = rnd.nextInt(MyMails.emails.length);
        outputMails.add(formatToSingleLine(MyMails.emails.elementAt(x)));
        mailIndex.add(x);
        isLoadingMore = false;
      });
    }
  }

  String formatToSingleLine(String multilineString) {
    return multilineString
        .replaceAll('\n', ' ')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
  }

  @override
  Widget build(BuildContext context) {
    if (started == true) {
      started = false;
      double screenWidth = MediaQuery.of(context).size.width;
      generateEmails(screenWidth);
    }
    return Scaffold(
      backgroundColor: const Color(0xFFFFD6D6), // Email Background
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF2424), // Email Top Bar
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Busy Mail',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 10),
            Text(
              'Inbox: $mailCount',
              style: const TextStyle(
                color: Color(0xFF91918F), // Email Text
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                itemCount: outputMails.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            '/mailDetail',
                            arguments: MyMails.emails
                                .elementAt(mailIndex.elementAt(index)),
                          );
                        },
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 10),
                          foregroundColor:
                              const Color(0xFF91918F), // Email Text Color
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.email_outlined,
                              color: Color(0xFFFF2424), // Email Icon
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                outputMails.elementAt(index).toString(),
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF91918F), // Email Text Color
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Divider(
                        color: Color(0xFF91918F), // Email Text Color
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
