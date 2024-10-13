import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    final bool isRecieving = ModalRoute.of(context)!.settings.arguments as bool;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: <Widget>[
            isRecieving ? Text("Recieving") : Text("Sending"),
            TextButton(
              child: Text("Return to banking."),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextField(
              decoration: const InputDecoration(hintText: "Amount"),
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
            TextField(
              decoration:
                  const InputDecoration(hintText: "Who are you sending it to"),
              onChanged: (value) => setState(() {
                otherUser = value;
              }),
            ),
            TextButton(
                onPressed: () {
                  Navigator.pop(context, [amount, otherUser]);
                },
                child: Text("Send £${amount.toStringAsFixed(2)} to $otherUser"))
          ],
        ),
      ),
    );
  }
}
