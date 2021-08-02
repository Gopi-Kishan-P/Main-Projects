import 'package:Expense_Manager_2/models/transaction.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key key,
    @required this.transactions,
    @required this.deleteTransaction,
  }) : super(key: key);

  final Transaction transactions;
  final Function deleteTransaction;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      elevation: 3,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: ListTile(
          leading: Padding(
            padding: EdgeInsets.all(3),
            child: CircleAvatar(
              radius: 30,
              child: Padding(
                padding: EdgeInsets.all(8),
                child: FittedBox(
                  child: Text(
                    '₹${transactions.amount}',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          ),
          title: Text(
            transactions.title,
            style: Theme.of(context).textTheme.title,
          ),
          subtitle: Text(
            DateFormat.yMMMMEEEEd()
                .format(transactions.date),
          ),
          trailing: MediaQuery.of(context).size.width < 420 ?
          IconButton(
            icon: Icon(Icons.delete_forever_outlined, size: 30,),
            color: Colors.orange[700],
            onPressed: () => deleteTransaction(transactions.id),
          ) : 
          FlatButton.icon(
            icon: Icon(Icons.delete_forever_outlined, size: 30,),
            label: Text('Delete'),
            textColor: Colors.orange[700],
            onPressed: () => deleteTransaction(transactions.id),
          ),
        ),
      ),
    );
  }
}