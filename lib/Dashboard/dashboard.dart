import 'package:budget_genius/Dashboard/Personal/personal.dart';
import 'package:budget_genius/Dashboard/Personal/transactions.dart';
import 'package:budget_genius/Utils/Utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Household/household.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Budget",
            //style: Utils.mediumTextStyle as TextStyle?,

          ),
          backgroundColor: Colors.greenAccent,
          bottom: const TabBar(
            tabs: [
              Tab(text: "Personal",
              ),
              Tab(text: "Household"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Personal(transactions: transactions,),
            Household(),
          ],
        ),
      ),
    );
  }
}