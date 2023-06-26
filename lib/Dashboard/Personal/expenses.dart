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

class Goal extends StatefulWidget {
  final List<Goals> goal;

  const Goal({Key? key, required this.goal}) : super(key: key);

  @override
  State<Goal> createState() => _GoalState();
}

class _GoalState extends State<Goal> {
  Widget completed(List<Goals> goals) {
    bool achieved = false;
    for (int i = 0; i < goals.length; i++) {
      if (goals[i].amount >= goals[i].target) {
        achieved = true;
        break;
      }
    }
    if (achieved) {
      return Icon(Icons.check_circle, color: Colors.green);
    } else {
      return SizedBox.shrink(); // Return an empty widget instead of null
    }
  }

  Widget text(List<Goals> goals) {
    bool achieved = false;
    for (int i = 0; i < goals.length; i++) {
      if (goals[i].amount >= goals[i].target) {
        achieved = true;
        break;
      }
    }
    if (achieved) {
      return Text(
        "Achieved",
        style: TextStyle(color: Colors.green),
      );
    } else {
      return Text(
        "Almost!!",
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
      return Text(
        diff.toString(),
        style: TextStyle(color: Colors.red),
      );
    } else {
      return const SizedBox.shrink(); // Return an empty widget instead of null
    }
  }

  void _showDialog() {
    String goalName = "";
    int goalTarget = 0;
    int amount =0;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Add your new goal"),
            contentPadding: EdgeInsets.all(16.0),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  autofocus: true,
                  decoration: InputDecoration(labelText: "Goal Name"),
                  onChanged: (value) {
                    setState(() {
                      goalName = value;
                    });
                  },
                  validator: (value)=>value!.isEmpty ? "Please enter a goal name": null,
                ),
                TextFormField(
                  autofocus: false,
                  decoration: InputDecoration(labelText: "Deposit Starting Amount"),
                  onChanged: (value) {
                    setState(() {
                      amount = int.parse(value) ?? 0;
                    });
                  },
                  validator: (value)=>value!.isEmpty ? "Please eneter a goal name": null,
                ),
                TextFormField(
                  autofocus: false,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: "Goal target"),
                  onChanged: (value) {
                    setState(() {
                      goalTarget = int.parse(value) ?? 0;
                    });
                  },
                  style: TextStyle(fontSize: 10),
                  validator:
                      (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a valid target amount';
                    }
                    int? target = int.tryParse(value);
                    if (target == null || target == 0) {
                      return 'Please enter a valid target amount';
                    }
                    return null;
                  },
                ),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("cancel")),
              TextButton(
                  onPressed: () {
                    setState(() {
                      goal.add(Goals(
                          title: goalName,
                          amount: amount.toDouble(),
                          target: goalTarget.toDouble()));
                      Navigator.pop(context);
                    });
                  },
                  child: Text("Save"))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shadowColor: Colors.black,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height *0.5, // Reduced the height of the Card
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
        Builder(
          builder: (context) {
            return GridView.builder(
            shrinkWrap: true,
            // Added this line to make GridView take only as much height as required by its contents
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 2,
              mainAxisSpacing: 4,
            ),
            itemCount: widget.goal.length,
            itemBuilder: (BuildContext context, int index) {
              return Dismissible(
                key: UniqueKey(),
                onDismissed: (direction){
                  setState(() {
                    widget.goal.removeAt(index);
                  });
                },
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(right: 20),
                  child: const Icon(Icons.delete),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.red,
                  child: Card(
                    elevation: 5,
                    shadowColor: Colors.black,
                    child: Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Column(
                        children: [
                          Text(widget.goal[index].title,
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold)),
                          const SizedBox(height: 2.5),
                          Text(widget.goal[index].amount.toString()),
                          remaining([widget.goal[index]]),
                          const SizedBox(height: 2.5),
                          completed([widget.goal[index]]),
                          // Pass a list with a single Goal object here
                          const SizedBox(height: 2.5),
                          text([widget.goal[index]])
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
      );
          }
        ),
              Card(
                child: SizedBox(
                  height: 100,
                  width: 100,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: () {
                          _showDialog();
                        },
                        icon: const Icon(Icons.add),
                      ),
                      const Text("Add new Goal")
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
