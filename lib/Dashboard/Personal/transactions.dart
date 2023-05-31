import 'package:flutter/material.dart';

class Transaction {
  final String title;
  final String amount;
  final String imageUrl;
final DateTime date;
  const Transaction( {
    required this.title,
    required this.amount,
    required this.imageUrl,
    required this.date
  });
}

final List<Transaction> transactions = [
   Transaction(
    date:DateTime.now(),
    title: "Groceries",
    amount: "Ksh. 2,500",
    imageUrl: "https://picsum.photos/200",
  ),
  Transaction(
    date:DateTime.now(),
    title: "Gas",
    amount: "Ksh. 1,000",
    imageUrl: "https://picsum.photos/200",
  ),
  Transaction(
    date:DateTime.now(),
    title: "Gas",
    amount: "Ksh. 1,000",
    imageUrl: "https://picsum.photos/200",
  ),
  Transaction(
    date:DateTime.now(),
    title: "Clothes",
    amount: "Ksh. 1,000",
    imageUrl: "https://picsum.photos/200",
  ),
  Transaction(
    date:DateTime.now(),
    title: "Clothes",
    amount: "Ksh. 7,000",
    imageUrl: "https://picsum.photos/200",
  ),
  Transaction(
    date:DateTime.now(),
    title: "Clothes",
    amount: "Ksh. 2,000",
    imageUrl: "https://picsum.photos/200",
  ),
  Transaction(
    date:DateTime.now(),
    title: "Accessories",
    amount: "Ksh. 8,000",
    imageUrl: "https://picsum.photos/200",
  ),
  Transaction(
    date:DateTime.now(),
    title: "Food",
    amount: "Ksh. 5,000",
    imageUrl: "https://picsum.photos/200",
  ),
];

