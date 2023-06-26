import 'package:budget_genius/Dashboard/Personal/personal.dart';
import 'package:budget_genius/Dashboard/Personal/transactions.dart';
import 'package:budget_genius/Login/welcome.dart';
import 'package:budget_genius/Provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Household/household.dart';

class Dashboard extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser;

  Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                showMenu(
                    context: context,
                    position: RelativeRect.fromLTRB(1000.0, 80.0, 0.0, 0.0),
                    items: [
                      PopupMenuItem(
                        onTap: () {
                          final provider = Provider.of<GoogleSignInProvider>(
                              context,
                              listen: false);
                          provider.logout(context);
                        },
                        height: 5,
                        child: const Text("Logout"),
                      ),
                    ]);
              },
              icon: CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(user?.photoURL ?? ''),
              ),
              alignment: Alignment.topLeft,
            ),
          ],
          title: const Text(
            "Budget",
            //style: Utils.mediumTextStyle as TextStyle?,
          ),
          backgroundColor: Colors.greenAccent,
          bottom: const TabBar(
            tabs: [
              Tab(
                text: "Personal",
              ),
              Tab(text: "Household"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Personal(
              transactions: transactions,
            ),
            const Household(),
          ],
        ),
      ),
    );
  }
}
