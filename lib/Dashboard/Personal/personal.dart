import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:intl/intl.dart';
import 'package:budget_genius/Dashboard/Personal/seeAllTransactions.dart';
import 'package:budget_genius/Dashboard/Personal/transactions.dart';
import 'package:flutter/material.dart';

import 'expenses.dart';



class Personal extends StatefulWidget {
  const Personal({
    Key? key,
    required List<Transaction> transactions,
  }) : super(key: key);

  @override
  State<Personal> createState() => _PersonalState();
}

class _PersonalState extends State<Personal> {
  final String consumerKey = 'CKdmHRbv3v0j5tCTK61yLLcxMxejLG3S';
  final String consumerSecret = 'NVhHX8B8AAeKP9pD';
  final String accessToken = 'YOUR_ACCESS_TOKEN';
  final String accessSecret = 'YOUR_ACCESS_SECRET';
  String? _mpesaBalance;

  Future<void> _getMpesaBalance() async {
    try {
      // Get the access token first
      final String accessToken = await getAccessToken();

      // Make an HTTP POST request to the M-Pesa API with the access token
      final response = await http.post(
        Uri.parse(
            'https://api.safaricom.co.ke/mpesa/accountbalance/v1/query'),
        headers: {
          'Authorization': 'Bearer $accessToken',
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        },
        body: jsonEncode({
          "Initiator": "Dennis",
          "SecurityCredential": "PkzhaoItu8EqH5hFICzd0nObcyjdNGMcxVGIFz5smwzhPGz95tWbEkBrAa9vq/HzO8jhjmcwRghJSU9PHO/G7jY4UDhMpIuLX1FKRZ5lGPoNnMfdqfWWiGToaJFyB/tNhGx7SwRA+OFW04Jz71F0JAO0kDx4rgej9sQi/TaKtdnbarPacO0pryqKHwMdcSRA0lKbIZk6yKzi3g7cC+6oFlyDZDvx1rhuW4NkBbCOsRIneejwMbrvrLNSRu7l6IBI261GQChlkTnzAQgzEVyPC49C7MO5WxsT9hmXBRT2Z2K2GOSCjhTweQ9qhoFRktEgGmvgGlxmNVBEDPLQQYfJbw==",
          "CommandID": "AccountBalance",
          "PartyA": "0718705129",
          "IdentifierType": "4",
          "Remarks": "",
          "QueueTimeOutURL": "",
          "ResultURL": "",
          // Replace this value with your M-Pesa account number
          "InitiatorAccountCurrentBalance": {"AccountNumber": "0718705129"}
        }),
      );

      if (response.statusCode == 200) {
        setState(() {
          // Set the M-Pesa balance in the state variable
          _mpesaBalance = response.body;
        });
      } else {
        throw Exception('Failed to load M-Pesa balance');
      }
    } catch (e) {
      print(e);
    }
  }
  Future<String> getAccessToken() async {
    final String consumerKey = 'CKdmHRbv3v0j5tCTK61yLLcxMxejLG3S';
    final String consumerSecret = 'NVhHX8B8AAeKP9pD';

    final response = await http.get(
      Uri.parse(
          'https://api.safaricom.co.ke/oauth/v1/generate?grant_type=client_credentials'),
      headers: {
        'Authorization':
        'Basic ${base64Encode(utf8.encode('$consumerKey:$consumerSecret'))}',
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return data['access_token'];
    } else {
      throw Exception('Failed to load access token');
    }
  }

  @override
  void initState(){
    super.initState();
    _getMpesaBalance();
  }
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
                Container(
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children:
                    [
                      Card(
                        shadowColor: Colors.black45,
                        elevation: 8,
                        child: Container(
                          color: Colors.white24,
                          height: 100,
                          width: 150,
                          child: Column(
                            children:  const [
                              ListTile(
                                title: Text(
                                  'Equity',
                                  //style: Utils.mediumTextStyle as TextStyle?,
                                ),
                                subtitle: Text("10000 Ksh."),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        shadowColor: Colors.black45,
                        elevation: 8,
                        child: Container(
                          color: Colors.white24,
                          height: 100,
                          width: 150,
                          child: Column(
                            children:  [

                              ListTile(
                                title: Text(
                                  'M-pesa',
                                  //style:mediumTextStyle,
                                ),
                                subtitle: _mpesaBalance != null
                                    ? Text(_mpesaBalance!)
                                    : CircularProgressIndicator(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]
                  ),
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
                    Expenses(),
                    Goal(goal: goal),
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
}
