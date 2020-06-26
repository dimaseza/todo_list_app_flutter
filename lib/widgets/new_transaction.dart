import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  DateTime _selectedDate;

  void submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }

    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget.addTx(
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }

      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                labelText: "Title",
              ),
              controller: _titleController,
              onSubmitted: (_) => submitData,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: "Amount",
              ),
              controller: _amountController,
              onSubmitted: (_) => submitData,
              keyboardType: TextInputType.number,
            ),
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text((_selectedDate == null)
                        ? "No Date Chosen!"
                        : "Picked Date: ${DateFormat.yMMMd().format(_selectedDate)}"),
                  ),
                  FlatButton(
                    child: Text("Choose Date"),
                    textColor: Theme.of(context).primaryColor,
                    onPressed: _presentDatePicker,
                  ),
                ],
              ),
            ),
            RaisedButton(
              child: Text("Add Transaction"),
              onPressed: submitData,
              color: Theme.of(context).primaryColor,
              textColor: Theme.of(context).textTheme.button.color,
            )
          ],
        ),
      ),
    );
  }
}
