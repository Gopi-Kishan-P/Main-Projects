import 'package:Expense_Manager_2/widgets/transaction_item.dart';
import 'package:flutter/material.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  // ignore: unused_field

  final List<Transaction> transactions;

  final Function deleteTransaction;

  

  TransactionList({this.transactions, this.deleteTransaction});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: transactions.isEmpty
          ? Column(
              children: [
                SizedBox(
                  height: 18,
                ),
                Text(
                  "No Transaction Added Yet",
                  style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 18,
                ),
                Container(
                  height: 180,
                  child: Image.asset(
                    "assets/images/waiting.png",
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ],
            )
          : ListView.builder(
              itemBuilder: (context, index) {
                return TransactionItem(transactions: transactions[index], deleteTransaction: deleteTransaction);
              },
              itemCount: transactions.length,
            ),
    );
  }
}


