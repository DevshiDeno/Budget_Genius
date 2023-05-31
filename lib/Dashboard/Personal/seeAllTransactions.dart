import 'package:budget_genius/Dashboard/Personal/transactions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  const TransactionList({Key? key, required this.transactions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Equity transactions"),
        backgroundColor: Colors.greenAccent,
      ),
      body: Container(
        child: ListView.builder(
          itemCount: transactions.length,
          itemBuilder: (BuildContext context, int index) {
            String formattedDate =
                DateFormat('yyyy-MM-dd').format(transactions[index].date);

            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TransactionDetails(
                              transaction: transactions[index],
                            )));
              },
              child: Card(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  child: ListTile(
                    title: ListTile(
                      subtitle: Text(formattedDate),
                      title: Text(transactions[index].title),
                    ),
                    trailing: Text(transactions[index].amount.toString()),
                    leading: CircleAvatar(
                      backgroundImage:
                          NetworkImage(transactions[index].imageUrl),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class TransactionListMPESA extends StatelessWidget {
  const TransactionListMPESA({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Equity transactions",
          //style: Utils.mediumTextStyle as TextStyle?,
        ),
        backgroundColor: Colors.greenAccent,
      ),
      body: ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (BuildContext context, int index) {
          String formattedDate =
              DateFormat('yyyy-MM-dd').format(transactions[index].date);
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TransactionDetails(
                            transaction: transactions[index],
                          )));
            },
            child: Card(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 60,
                child: ListTile(
                  title: ListTile(
                    subtitle: Text(formattedDate),
                    title: Text(transactions[index].title),
                  ),
                  trailing: Text(transactions[index].amount),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(transactions[index].imageUrl),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class TransactionDetails extends StatelessWidget {
  TransactionDetails({Key? key, required this.transaction}) : super(key: key);
  final Transaction transaction;
  final List<IconData> myIcons = [
    Icons.home,
    Icons.card_giftcard,
    Icons.face,
    Icons.account_circle,
    Icons.ac_unit,
    Icons.adb,
    Icons.add_alarm,
    Icons.add_alert,
    Icons.add_box,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        title: Text("${transaction.title}"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 100,
                child: ListTile(
                  title: Text("-${transaction.amount}"),
                  subtitle: Text("${transaction.date}"),
                ),
              ),
            ),
            Card(
              child: Container(
                child: const ListTile(
                  leading: Text("Account"),
                  trailing: Text("1233 **** **** 2223"),
                ),
              ),
            ),
            Card(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 440,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Category"),
                      const Center(
                        child: CircleAvatar(
                          child: Icon(Icons.emoji_food_beverage),
                        ),
                      ),
                      const Divider(),
                      Expanded(
                        child: GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 4,
                            mainAxisSpacing: 4,
                          ),
                          itemCount: myIcons.length,
                          itemBuilder: (BuildContext context, int index) {
                            return SizedBox(
                              width: 4,
                              height: 4,
                              child: Icon(myIcons[index]),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.delete_sharp),
                    const SizedBox(width: 2),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Delete transaction",
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
