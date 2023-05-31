import 'package:intl/intl.dart';
import 'package:budget_genius/Dashboard/Personal/seeAllTransactions.dart';
import 'package:budget_genius/Dashboard/Personal/transactions.dart';
import 'package:flutter/material.dart';

class Personal extends StatelessWidget {
  const Personal({
    Key? key,
    required List<Transaction> transactions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return Card(
                      shadowColor: Colors.black45,
                      elevation: 8,
                      child: Container(
                        color: Colors.white24,
                        height: 170,
                        width: constraints.maxWidth,
                        child: Column(
                          children: const [
                            ListTile(
                              title: Text(
                                'Total',
                                //  style: Utils.mediumTextStyle as TextStyle?,
                              ),
                              trailing: Text("10000 Ksh."),
                            ),
                            ListTile(
                              title: Text(
                                'Equity',
                                //style: Utils.mediumTextStyle as TextStyle?,
                              ),
                              trailing: Text("10000 Ksh."),
                            ),
                            ListTile(
                              title: Text(
                                'M-pesa',
                                //style:mediumTextStyle,
                              ),
                              trailing: Text(
                                "10 Ksh.",
                                //style: Utils.mediumTextStyle as TextStyle?,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                const PreferredSize(
                  preferredSize: Size.fromHeight(48),
                  child: TabBar(
                    labelColor: Colors.green,
                    tabs: [
                      Tab(
                        text: "Transactions",
                      ),
                      Tab(
                        text: "Expenses",
                      ),
                      Tab(
                        text: "Goals",
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(children: [
                    buildTransactions(context),
                    buildExpenses(),
                    buildGoals(),
                  ]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTransactions(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 350,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("M-pesa"),
                ),
                Expanded(
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    // disable scrolling
                    itemCount: transactions.length,
                    itemBuilder: (BuildContext context, int index) {
                      String formattedDate = DateFormat('yyyy-MM-dd')
                          .format(transactions[index].date);
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
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 60,
                            child: ListTile(
                              title: ListTile(
                                subtitle: Text(formattedDate),
                                title: Text(transactions[index].title),
                              ),
                              trailing: Text(transactions[index].amount),
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const TransactionListMPESA()),
                      );
                    },
                    child: const Text('See all'),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 350,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Equity"),
                ),
                Expanded(
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: transactions.length,
                    itemBuilder: (BuildContext context, int index) {
                      String formattedDate = DateFormat('yyyy-MM-dd')
                          .format(transactions[index].date);
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                    child: const Text("See all"),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const TransactionListMPESA()));
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildExpenses() {
    return Container();
  }

  Widget buildGoals() {
    return Container();
  }
}
