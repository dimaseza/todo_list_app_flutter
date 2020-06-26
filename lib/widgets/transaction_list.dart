import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteChosen;

  TransactionList(this.transactions, this.deleteChosen);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      child: transactions.isEmpty
          ? Column(
              children: <Widget>[
                Text(
                  "No transactions added yet!",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Container(
                  height: 200,
                  child: Image.asset(
                    "assets/online_work.gif",
                    fit: BoxFit.cover,
                  ),
                )
              ],
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 5,
                  ),
                  child: ListTile(
                    leading: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: FittedBox(
                        child: CircleAvatar(
                          radius: 30,
                          child: Text("\$${transactions[index].amount}"),
                        ),
                      ),
                    ),
                    title: Text(
                      transactions[index].title,
                      style: Theme.of(context).textTheme.title,
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd().format(transactions[index].date),
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Theme.of(context).errorColor,
                      ),
                      onPressed: () => deleteChosen(transactions[index].id),
                    ),
                  ),
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
