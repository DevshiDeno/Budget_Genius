import 'package:flutter/material.dart';

class Transaction {
  final String title;
  final String amount;
  final String imageUrl;
  final DateTime date;

  const Transaction(
      {required this.title,
      required this.amount,
      required this.imageUrl,
      required this.date});
}

final List<Transaction> transactions = [
  Transaction(
    date: DateTime.now(),
    title: "Groceries",
    amount: "Ksh. 2,500",
    imageUrl: "https://picsum.photos/200",
  ),
  Transaction(
    date: DateTime.now(),
    title: "Gas",
    amount: "Ksh. 1,000",
    imageUrl: "https://picsum.photos/200",
  ),
  Transaction(
    date: DateTime.now(),
    title: "Gas",
    amount: "Ksh. 1,000",
    imageUrl: "https://picsum.photos/200",
  ),
  Transaction(
    date: DateTime.now(),
    title: "Clothes",
    amount: "Ksh. 1,000",
    imageUrl: "https://picsum.photos/200",
  ),
  Transaction(
    date: DateTime.now(),
    title: "Clothes",
    amount: "Ksh. 7,000",
    imageUrl: "https://picsum.photos/200",
  ),
  Transaction(
    date: DateTime.now(),
    title: "Clothes",
    amount: "Ksh. 2,000",
    imageUrl: "https://picsum.photos/200",
  ),
  Transaction(
    date: DateTime.now(),
    title: "Accessories",
    amount: "Ksh. 8,000",
    imageUrl: "https://picsum.photos/200",
  ),
  Transaction(
    date: DateTime.now(),
    title: "Food",
    amount: "Ksh. 5,000",
    imageUrl: "https://picsum.photos/200",
  ),
];

class Goals {
  final String title;
  final double amount;
  final double target;

  Goals({required this.target, required this.title, required this.amount});
}

final List<Goals> goal = [
  Goals(amount: 500, title: 'Bike', target: 500),
  Goals(amount: 200, title: 'Phone', target: 1000),
  Goals(amount: 200, title: 'Laptop', target: 2000),
  Goals(amount: 900, title: 'Airforce', target: 900),
  Goals(amount: 2220, title: 'Cooker', target: 2220),
  Goals(amount: 200, title: 'Cooker', target: 600),
];
