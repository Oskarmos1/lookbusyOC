import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:lookbusy/emails.dart';

class Mail extends StatefulWidget {
  const Mail({super.key});

  @override
  State<Mail> createState() => _MailState();
}

bool isLoadingMore = false;

class _MailState extends State<Mail> {
  ScrollController scrollController = ScrollController();
  Random rnd = Random();
  bool started = true;
  List<String> outputMails = [];
  List<int> mailIndex = [];
  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      print(scrollController.position.pixels);
      print(scrollController.position.maxScrollExtent);
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent - 10 &&
          isLoadingMore == false) {
        print(scrollController.position.pixels);
        print(scrollController.position.maxScrollExtent);
        isLoadingMore = true;
        loadMoreEmails();
      }
    });
/*
    // Listen to scroll events
    scrollController.addListener(() {
      // Check if the user has scrolled near the bottom
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent - 10 &&
          isLoadingMore == false) {
        loadMoreEmails();
      }
    });
    */
  }

  void loadMoreEmails() async {
    double screenWidth = MediaQuery.of(context).size.width;
    generateEmails(screenWidth);
    setState(() {});
    // Generate and load more emails
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  void generateEmails(double screenWidth) async {
    for (int i = 0; i < 15; i++) {
      // Add processed emails to the temporary list
      setState(() {
        int x = rnd.nextInt(MyMails.emails.length);
        outputMails.add(truncateText(
          formatToSingleLine(MyMails.emails.elementAt(x)),
          screenWidth,
          TextStyle(fontSize: 16, color: Colors.black),
        ));
        mailIndex.add(x);
        isLoadingMore = false;
      });
    }

    // Update the state once after processing all emails
  }

  String formatToSingleLine(String multilineString) {
    return multilineString
        .replaceAll('\n', ' ')
        .replaceAll(RegExp(r'\s+'), ' ')
        .trim();
  }

  String truncateText(String text, double maxWidth, TextStyle textStyle) {
    TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: textStyle),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    );

    textPainter.layout(maxWidth: maxWidth);

    if (textPainter.didExceedMaxLines) {
      // If the text exceeds max width, truncate it
      while (textPainter.didExceedMaxLines) {
        // Reduce the text by one character
        text = text.substring(0, text.length - 1);
        textPainter.text = TextSpan(text: text, style: textStyle);
        textPainter.layout(maxWidth: maxWidth);
      }
      return '$text...'; // Add ellipsis
    }

    return text; // Return original text if it fits
  }

  @override
  Widget build(BuildContext context) {
    if (started == true) {
      started = false;
      double screenWidth = MediaQuery.of(context).size.width;
      generateEmails(screenWidth);
    }
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const HugeIcon(
                      icon: HugeIcons.strokeRoundedArrowLeft02,
                      color: Color(0xFF263238),
                      size: 40.0,
                    ),
                  ),
                  Expanded(
                    child: Image(
                      image: const AssetImage("assets/BusyMail.png"),
                      height: 100, // You can adjust the height as needed
                      fit: BoxFit
                          .contain, // Adjust the fit property to control how the image scales
                    ),
                  ),
                ]),
            Text(outputMails.length.toString()),
            Expanded(
                child: ListView.builder(
                    controller: scrollController,
                    itemCount: outputMails.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      double screenWidth = MediaQuery.of(context).size.width;
                      return Column(children: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/mailDetail',
                                arguments: MyMails.emails
                                    .elementAt(mailIndex.elementAt(index)));
                          },
                          child: Text(outputMails.elementAt(index).toString()),
                        ),
                        const Divider(),
                      ]);
                    }))
          ],
        ),
      ),
    );
  }
}
