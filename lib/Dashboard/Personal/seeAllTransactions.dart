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
    Icons.accessibility,
    Icons.account_balance,
    Icons.account_box,
    Icons.account_circle,
    Icons.ac_unit,
    Icons.adb,
    Icons.add_alarm,
    Icons.add_alert,
    Icons.add_box,
    Icons.add_circle_outline,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        title: Text("${transaction.title}"),
      ),
      body: Column(
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
              color: Colors.transparent,
              child: ListTile(
                leading: Text("Account"),
                trailing: Text("1233 1322 2222 2223"),
              ),
            ),
          ),
          Card(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 200,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Category"),
                    Center(
                      child: CircleAvatar(
                        child: Icon(Icons.emoji_food_beverage),
                      ),
                    ),
                    const Divider(),
                    Expanded(
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                        ),
                        itemCount: myIcons.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(myIcons[index]),
                          );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
