import 'package:flutter/material.dart';

class Maildetail extends StatefulWidget {
  const Maildetail({super.key});

  @override
  State<Maildetail> createState() => _MaildetailState();
}

class _MaildetailState extends State<Maildetail> {
  @override
  Widget build(BuildContext context) {
    final String mail = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      backgroundColor: const Color(0xFFFFD6D6), // Email Background
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF2424), // Email Top Bar
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
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
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Padding for overall content
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    mail,
                    style: const TextStyle(
                      color: Color(0xFF91918F), // Email Text Color
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const SizedBox(height: 10),
              TextField(
                maxLines: 4,
                style: const TextStyle(
                  color: Color(0xFF91918F),
                ),
                decoration: InputDecoration(
                  hintText: 'Type your reply...',
                  hintStyle: const TextStyle(color: Color(0xFF91918F)),
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: const BorderSide(
                      color: Color(0xFF91918F),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
