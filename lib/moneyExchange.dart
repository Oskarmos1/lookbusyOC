import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class Moneyexchange extends StatefulWidget {
  const Moneyexchange({super.key});

  @override
  State<Moneyexchange> createState() => _MoneyexchangeState();
}

class _MoneyexchangeState extends State<Moneyexchange> {
  double amount = 0;
  String otherUser = "";

  @override
  Widget build(BuildContext context) {
    final bool isReceiving = ModalRoute.of(context)!.settings.arguments as bool;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 207, 216, 220),
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Color.fromARGB(255, 96, 125, 139),
          title: Text(
            isReceiving ? "Receiving Money" : "Sending Money",
            style: GoogleFonts.montserrat(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 20),
              Text(
                isReceiving ? "Receiving" : "Sending",
                style: GoogleFonts.montserrat(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 55, 71, 79),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  hintText: "Amount",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r"[0-9.]")),
                  TextInputFormatter.withFunction((oldValue, newValue) {
                    final text = newValue.text;
                    return text.isEmpty
                        ? newValue
                        : double.tryParse(text) == null
                            ? oldValue
                            : newValue;
                  }),
                ],
                onChanged: (value) {
                  setState(() {
                    try {
                      amount = double.parse(value);
                    } catch (e) {
                      amount = 0;
                    }
                  });
                },
              ),
              const SizedBox(height: 16),
              TextField(
                decoration: InputDecoration(
                  hintText: "Who are you sending it to?",
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: (value) => setState(() {
                  otherUser = value;
                }),
              ),
              const SizedBox(height: 20),
              Center(
                child: TextButton(
                  onPressed: () {
                    // Default to "nobody" if otherUser is empty
                    String finalUser = otherUser.isEmpty ? "nobody" : otherUser;
                    Navigator.pop(context, [amount, finalUser]);
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 84, 110, 122),
                    padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Text(
                    "Send £${amount.toStringAsFixed(2)} to ${otherUser.isEmpty ? "nobody" : otherUser}",
                    style: GoogleFonts.montserrat(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
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
