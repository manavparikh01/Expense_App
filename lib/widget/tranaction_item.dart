import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key key,
    @required this.transactions,
    @required this.deleteTransaction,
  }) : super(key: key);

  final transactions;
  final deleteTransaction;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      child: ListTile(
        leading: CircleAvatar(
          //foregroundColor: Theme.of(context).primaryColor,
          backgroundColor: Colors.purple,
          foregroundColor: Colors.white,
          radius: 30,
          child: Container(
            padding: EdgeInsets.all(6),
            child: FittedBox(
              child: Text(
                '\$${transactions.amount.toStringAsFixed(2)}',
              ),
            ),
          ),
        ),
        title: Text(
          '${transactions.title}',
          style:
              TextStyle(fontFamily: 'Quicksand', fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          '${DateFormat.yMMMd().format(transactions.date)}',
          style: TextStyle(
            fontFamily: 'Quicksand',
          ),
        ),
        trailing: MediaQuery.of(context).size.width > 400
            ? FlatButton.icon(
                onPressed: () => deleteTransaction(transactions.id),
                icon: Icon(Icons.delete),
                label: Text('Delete'),
                textColor: Theme.of(context).errorColor,
              )
            : IconButton(
                icon: Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: () => deleteTransaction(transactions.id),
              ),
      ),
    );
  }
}
