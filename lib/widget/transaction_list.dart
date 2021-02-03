import 'package:flutter/material.dart';

import '../model/transaction.dart';
import './tranaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final deleteTransaction;

  TransactionList(this.transactions, this.deleteTransaction);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'No transactions added yet!',
                    //style: Theme.of(context).textTheme.headline5,
                    style: TextStyle(
                      fontFamily: 'Quicksand',
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'assests/fonts/image/image/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            },
          )
        : ListView.builder(
            //children: [Column(
            itemBuilder: (context, index) {
              return TransactionItem(
                  transactions: transactions[index],
                  deleteTransaction: deleteTransaction);
              //return Card(
              //  child: Row(
              //children: [
              //Container(
              //margin: EdgeInsets.symmetric(
              //vertical: 10,
              //horizontal: 15,
              //),
              //decoration: BoxDecoration(
              //border: Border.all(
              //color: Theme.of(context).primaryColor,
              //color: Colors.purple,
              //width: 2,
              //),
              //),
              //padding: EdgeInsets.all(10),
              //child: Text(
              //'\$' + tx.amount.toString(),
              //'\$${transactions[index].amount.toStringAsFixed(2)}',
              //style: TextStyle(
              //fontWeight: FontWeight.bold,
              //fontSize: 20,
              //color: Theme.of(context).primaryColor,
              //color: Colors.purple,
              //fontFamily: 'Quicksand',
              //),
              //),
              //),
              //Column(
              //crossAxisAlignment: CrossAxisAlignment.start,
              //children: [
              //Text(
              //transactions[index].title,
              //style: TextStyle(
              //fontSize: 18,
              //fontWeight: FontWeight.bold,
              //fontFamily: 'Quicksand',
              //),
              //style: Theme.of(context).textTheme.title,
              //),
              //Text(
              //tx.date.toString(),
              //DateFormat.yMMMd().format(transactions[index].date),
              //style: TextStyle(
              //color: Colors.grey,
              //fontFamily: 'Quicksand',
              //),
              //),
              //],
              //)
              //],
              //));
            },
            itemCount: transactions.length,
            //children: transactions.map((tx) {
            //
            //}).toList(),
          );
  }
}
