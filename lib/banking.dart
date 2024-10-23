import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class Transaction {
  DateTime timeOfTransaction;
  double amount;
  String typeOfTransaction;
  String otherUserName;
  Transaction(this.amount, this.timeOfTransaction, this.typeOfTransaction,
      this.otherUserName);
}

class Banking extends StatefulWidget {
  const Banking({super.key});

  @override
  State<Banking> createState() => _BankingState();
}

class _BankingState extends State<Banking> {
  ScrollController scrollController = ScrollController();
  double money = 5000;
  List<Transaction> transactions = [
    Transaction(200, DateTime.now(), "Send money", "Billy"),
    Transaction(300, DateTime.now(), "Recieve money", "Fred")
  ];
  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                      image: const AssetImage("assets/BusyBank.png"),
                      height: 100, // You can adjust the height as needed
                      fit: BoxFit
                          .contain, // Adjust the fit property to control how the image scales
                    ),
                  ),
                ]),
            Text("£${num.parse(money.toStringAsFixed(2))}"),
            TextButton(
                onPressed: () async {
                  try {
                    final returnInfo = await Navigator.pushNamed(
                        context, '/moneyExchange',
                        arguments: false) as List;
                    setState(() {
                      money = money - returnInfo?[0];
                      transactions.add(Transaction(returnInfo![0],
                          DateTime.now(), "Send money", returnInfo[1]));
                    });
                  } catch (e) {}
                },
                child: Text("send money")),
            TextButton(
                onPressed: () async {
                  try {
                    final returnInfo = await Navigator.pushNamed(
                        context, '/moneyExchange',
                        arguments: true) as List;
                    setState(() {
                      money = money + returnInfo?[0];
                      transactions.add(Transaction(returnInfo![0],
                          DateTime.now(), "Send money", returnInfo[1]));
                    });
                  } catch (e) {}
                },
                child: Text("recieve money")),
            Text("Transactions:"),
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                itemCount: transactions.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Column(
                    children: <Widget>[
                      Text("-----TRANSACTION ${index + 1}-----"),
                      Text(
                          "Amount: £${num.parse(transactions[index].amount.toStringAsFixed(2))}"),
                      Text("Type: ${transactions[index].typeOfTransaction}"),
                      Text("Date: ${transactions[index].timeOfTransaction}"),
                      Text("Other User: ${transactions[index].otherUserName}"),
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
