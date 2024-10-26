import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
  Color minusButtonBackground = Color.fromARGB(255, 176, 190, 197);
  Color minusButtonText = Color.fromARGB(255, 38, 50, 56);
  Color plusButtonBackground = Color.fromARGB(255, 84, 110, 122);
  Color plusButtonText = Color.fromARGB(255, 236, 239, 241);
  ScrollController scrollController = ScrollController();
  double money = 5000;
  String moneyStr = "5000.00";
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
      backgroundColor: Color.fromARGB(255, 207, 216, 220),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 96, 125, 139),
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          "Busy Bank",
          style: GoogleFonts.montserrat(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[]),
            Text(
              "£${moneyStr}",
              style: TextStyle(
                  fontSize: 70,
                  color: Color.fromARGB(255, 55, 71, 79),
                  fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
            ),
            Row(children: <Widget>[
              Expanded(
                  child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: minusButtonBackground,
                ),
                child: TextButton(
                  onPressed: () async {
                    try {
                      final returnInfo = await Navigator.pushNamed(
                          context, '/moneyExchange',
                          arguments: false) as List;

                      money = money - returnInfo?[0];
                      moneyStr = money.toStringAsFixed(2);

                      transactions.add(Transaction(returnInfo![0],
                          DateTime.now(), "Send money", returnInfo[1]));

                      setState(() {});
                    } catch (e) {}
                  },
                  child: Icon(
                    Icons.remove,
                    size: 50,
                    color: minusButtonText,
                  ),
                ),
              )),
              Expanded(
                  child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: plusButtonBackground,
                ),
                child: TextButton(
                    onPressed: () async {
                      try {
                        final returnInfo = await Navigator.pushNamed(
                            context, '/moneyExchange',
                            arguments: true) as List;
                        money = money + returnInfo[0];
                        moneyStr = money.toStringAsFixed(2);
                        transactions.add(Transaction(returnInfo[0],
                            DateTime.now(), "Recieve money", returnInfo[1]));
                        setState(() {});
                      } catch (e) {}
                    },
                    child: Icon(
                      Icons.add,
                      size: 50,
                      color: plusButtonText,
                    )),
              ))
            ]),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
              child: Text(
                "Transactions",
                style: TextStyle(
                  fontSize: 24, // Larger font size for emphasis
                  fontWeight: FontWeight.bold, // Bold for readability
                  color: Color.fromARGB(
                      255, 55, 71, 79), // Dark gray color for header text
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                itemCount: transactions.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  // Determine the background color based on transaction type
                  Color backgroundColor = transactions[index]
                              .typeOfTransaction ==
                          "Send money"
                      ? Color.fromARGB(255, 176, 190, 197) // Sent Background
                      : Color.fromARGB(
                          255, 84, 110, 122); // Received Background
                  Color textColor =
                      transactions[index].typeOfTransaction == "Send money"
                          ? Color.fromARGB(255, 38, 50, 56) // Sent Text
                          : Color.fromARGB(255, 236, 239, 241); // Received Text

                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: backgroundColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Amount: £${transactions[index].amount.toStringAsFixed(2)}",
                              style: TextStyle(color: textColor, fontSize: 16),
                            ),
                            Text(
                              "Type: ${transactions[index].typeOfTransaction}",
                              style: TextStyle(color: textColor, fontSize: 14),
                            ),
                            Text(
                              "Date: ${transactions[index].timeOfTransaction}",
                              style: TextStyle(color: textColor, fontSize: 12),
                            ),
                            Text(
                              "User: ${transactions[index].otherUserName}",
                              style: TextStyle(color: textColor, fontSize: 12),
                            ),
                          ],
                        ),
                        Icon(
                          transactions[index].typeOfTransaction == "Send money"
                              ? Icons.arrow_upward
                              : Icons.arrow_downward,
                          color: textColor,
                        ),
                      ],
                    ),
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
