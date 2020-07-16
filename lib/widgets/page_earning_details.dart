import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:income_tracker/models/cost.dart';
import 'package:income_tracker/models/job.dart';
import 'package:intl/intl.dart';

class PageEarningDetails extends StatelessWidget {
  final Job jobObj;
  final _formKey = GlobalKey<FormState>();
  // final TextEditingController _textFieldController = TextEditingController();

  PageEarningDetails({
    Key key,
    @required this.jobObj,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Earning Details')),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        children: <Widget>[
          const SizedBox(height: 20.0),
          Hero(
              tag: jobObj.id,
              child: _buildTextGroup(context, 'Job name', jobObj.name)),
          const SizedBox(height: 40.0),
          _buildTextGroup(context, 'Date and time',
              DateFormat('dd/MM/yy, kk:mm').format(jobObj.date)),
          const SizedBox(height: 40.0),
          _buildTextGroup(context, 'Fee', 'RM ${jobObj.fee}'),
          const SizedBox(height: 40.0),
          _buildTextGroup(context, 'Commission', 'RM ${jobObj.commission}'),
          const SizedBox(height: 40.0),
          _buildCostList(context, jobObj.costList),
          const SizedBox(height: 40.0),
          _buildTextGroup(context, 'Net Earning', 'RM ${jobObj.netEarn}'),
          const SizedBox(height: 20.0),
        ],
      ),
    );
  }

  Column _buildTextGroup(
      BuildContext context, String groupName, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          groupName,
          style: Theme.of(context).textTheme.bodyText2,
        ),
        const SizedBox(height: 2.0),
        AutoSizeText(
          content,
          style: Theme.of(context).textTheme.headline4,
          maxLines: 1,
        ),
      ],
    );
  }

  Widget _buildCostList(BuildContext context, List<Cost> costList) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Cost(s)',
          style: Theme.of(context).textTheme.bodyText2,
        ),
        const SizedBox(height: 2.0),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: costList.length,
          itemBuilder: (context, index) {
            final cost = costList[index];
            return Card(
              child: ListTile(
                title: Text(cost.name),
                subtitle: Text('RM ${cost.amount}'),
                trailing: Wrap(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return _buildAddEditAlert(context, editMode: true);
                          },
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete_outline),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return _buildDeleteAlert(context);
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(width: 5.0);
          },
        ),
        Card(
          child: ListTile(
            title: const Text('Add Expense'),
            trailing: IconButton(
              icon: Icon(Icons.note_add),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return _buildAddEditAlert(context, editMode: false);
                  },
                );
              },
            ),
          ),
        )
      ],
    );
  }

  AlertDialog _buildAddEditAlert(BuildContext context, {bool editMode}) {
    return AlertDialog(
      title: editMode ? const Text('Edit Expense') : const Text('Add Expense'),
      content: ExpenseForm(formKey: _formKey),
      actions: [
        _buildCancelButton(context),
        if (editMode) _buildEditButton() else _buildAddButton(),
      ],
    );
  }

  AlertDialog _buildDeleteAlert(BuildContext context) {
    return AlertDialog(
      title: const Text('Delete this expense?'),
      actions: [
        _buildCancelButton(context),
        _buildDeleteButton(),
      ],
    );
  }

  FlatButton _buildAddButton() {
    return FlatButton(
      onPressed: () {
        if (_formKey.currentState.validate()) {
          // If the form is valid, display a snackbar. In the real world,
          // you'd often call a server or save the information in a database.
          // TODO: Add expense
        }
      },
      child: const Text('Add'),
    );
  }

  FlatButton _buildEditButton() {
    return FlatButton(
      onPressed: () {
        if (_formKey.currentState.validate()) {
          // TODO: Edit expense
          // If the form is valid, display a snackbar. In the real world,
          // you'd often call a server or save the information in a database.
        }
      },
      child: const Text('Edit'),
    );
  }

  FlatButton _buildDeleteButton() {
    return FlatButton(
      onPressed: () {
        // TODO: Delete expense
      },
      child: const Text('Delete'),
    );
  }

  FlatButton _buildCancelButton(BuildContext context) {
    return FlatButton(
      onPressed: () => Navigator.of(context).pop(),
      child: const Text('Cancel'),
    );
  }
}

class ExpenseForm extends StatefulWidget {
  final GlobalKey formKey;

  const ExpenseForm({Key key, this.formKey}) : super(key: key);

  @override
  ExpenseFormState createState() {
    return ExpenseFormState();
  }
}

class ExpenseFormState extends State<ExpenseForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextFormField(
            // controller: _textFieldController,
            decoration: const InputDecoration(labelText: 'Name'),
            keyboardType: TextInputType.text,
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter a name';
              }
              return null;
            },
          ),
          TextFormField(
            // controller: _textFieldController,
            decoration: const InputDecoration(labelText: 'Amount'),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter an amount';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
