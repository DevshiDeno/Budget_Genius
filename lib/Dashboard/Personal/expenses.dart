import 'package:budget_genius/Dashboard/Personal/transactions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({Key? key}) : super(key: key);

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  bool _customTileExpanded = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          buildExpense(),
          //BuildStructure()
        ],
      ),
    );
  }

  Container buildExpense() {
    return Container(
      height: 500,
      child: Column(
        children: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text("To be Paid",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold)),
              )),
          ExpansionTile(
            controlAffinity: ListTileControlAffinity.leading,
            title: Text('Total Loans'),
            trailing: Text("Ksh.4800"),
            leading: Icon(_customTileExpanded
                ? Icons.arrow_drop_down_circle
                : Icons.arrow_drop_down),
            children: const <Widget>[
              ListTile(
                title: Text('KCB loan'),
                trailing: Text("Ksh. 4000"),
              ),
              ListTile(
                title: Text('Fuliza'),
                trailing: Text("Ksh. 800"),
              ),
            ],
            onExpansionChanged: (bool expanded) {
              setState(() {
                _customTileExpanded = expanded;
              });
            },
          ),
          ExpansionTile(
            controlAffinity: ListTileControlAffinity.leading,
            title: Text('Bills'),
            trailing: Text("Ksh.4340"),
            leading: Icon(_customTileExpanded
                ? Icons.arrow_drop_down_circle
                : Icons.arrow_drop_down),
            children: const <Widget>[
              ListTile(
                title: Text('Rent'),
                trailing: Text("Ksh. 1000"),
              ),
              ListTile(
                title: Text('KPLC'),
                trailing: Text("Ksh. 3340"),
              ),
            ],
            onExpansionChanged: (bool expanded) {
              setState(() {
                _customTileExpanded = expanded;
              });
            },
          ),
          ExpansionTile(
            controlAffinity: ListTileControlAffinity.leading,
            title: Text('Subscriptions'),
            trailing: Text("Ksh.6456"),
            leading: Icon(_customTileExpanded
                ? Icons.arrow_drop_down_circle
                : Icons.arrow_drop_down),
            children: const <Widget>[
              ListTile(
                title: Text('WI-Fi'),
                trailing: Text("Ksh. 3000"),
              ),
              ListTile(
                title: Text('GO TV'),
                trailing: Text("Ksh. 1456"),
              ),
              ListTile(
                title: Text('NETFLIX'),
                trailing: Text("Ksh. 2000"),
              ),
            ],
            onExpansionChanged: (bool expanded) {
              setState(() {
                _customTileExpanded = expanded;
              });
            },
          )
        ],
      ),
    );
  }
}

class Goal extends StatelessWidget {
  final List<Goals> goal;

  const Goal({Key? key, required this.goal}) : super(key: key);

  Widget completed(List<Goals> goals) {
    bool achieved = false;
    for (int i = 0; i < goals.length; i++) {
      if (goals[i].amount >= goals[i].target) {
        achieved = true;
        break;
      }
    }
    if(achieved) {
      return Icon(Icons.check_circle,
          color: Colors.green);
    }else{
      return SizedBox.shrink(); // Return an empty widget instead of null

    }

  }
  Widget text(List<Goals> goals){
    bool achieved = false;
    for (int i = 0; i < goals.length; i++) {
      if (goals[i].amount >= goals[i].target) {
        achieved = true;
        break;
      }
    }
    if(achieved) {
      return Text("Achieved",
      style: TextStyle(color: Colors.green),
      );
    }else{
    return Text("Almost",
      style: TextStyle(color: Colors.red),
    );
    }
  }
  Widget remaining(List<Goals> goals) {
    var diff = 0;
    for (int i = 0; i < goals.length; i++) {
      var difference = goals[i].amount - goals[i].target;
      diff += difference.round();
    }
    if (diff != 0) {
      return Text(diff.toString(),
        style: TextStyle(color: Colors.red),
      );
    } else {
      return SizedBox.shrink(); // Return an empty widget instead of null
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 10,
        shadowColor: Colors.black,
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 300, // Reduced the height of the Card
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 2,
                      mainAxisSpacing: 4,
                    ),
                    itemCount: goal.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ClipRect(
                        child: Card(
                          elevation: 10,
                          shadowColor: Colors.black,
                          child: Container(
                            width: 20,
                            child: Column(
                              children: [
                                Text(goal[index].title),
                                SizedBox(height: 4),
                                Text(goal[index].amount.toString()),
                                remaining([goal[index]]),
                                SizedBox(height: 4),
                                completed([goal[index]]), // Pass a list with a single Goal object here
                                SizedBox(height: 4),
                                text([goal[index]])
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
