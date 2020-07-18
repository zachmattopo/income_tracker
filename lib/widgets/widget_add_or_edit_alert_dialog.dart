import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:income_tracker/bloc/income_bloc.dart';
import 'package:income_tracker/models/models.dart';
import 'package:uuid/uuid.dart';

class AddOrEditAlertDialog extends StatefulWidget {
  final bool editMode;
  final Job job;
  final Cost cost;

  const AddOrEditAlertDialog({
    Key key,
    @required this.job,
    @required this.cost,
    @required this.editMode,
  }) : super(key: key);

  @override
  AddOrEditAlertDialogState createState() {
    return AddOrEditAlertDialogState();
  }
}

class AddOrEditAlertDialogState extends State<AddOrEditAlertDialog> {
  TextEditingController _nameController;
  TextEditingController _amountController;
  final _uuid = Uuid();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(
      text: widget.editMode ? widget.cost.name : null,
    );
    _amountController = TextEditingController(
      text: widget.editMode ? widget.cost.amount.toString() : null,
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: widget.editMode
          ? const Text('Edit Expense')
          : const Text('Add Expense'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Name'),
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.words,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter a name';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _amountController,
              decoration: const InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
              enableInteractiveSelection: false,
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please enter an amount';
                } else if (value.contains(',')) {
                  return "Do not use the ',' char.";
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: [
        _buildCancelButton(context),
        if (widget.editMode)
          _buildEditButton(context, job: widget.job, costId: widget.cost.id)
        else
          _buildAddButton(context, job: widget.job, cost: widget.cost),
      ],
    );
  }

  FlatButton _buildAddButton(BuildContext context,
      {@required Job job, @required Cost cost}) {
    return FlatButton(
      onPressed: () {
        if (_formKey.currentState.validate()) {
          BlocProvider.of<IncomeBloc>(context).add(
            IncomeCostUpdated(
              job: job,
              cost: Cost(
                id: _uuid.v4(),
                name: _nameController.text,
                amount: num.parse(_amountController.text),
              ),
            ),
          );
          Navigator.of(context).pop();
        }
      },
      child: const Text('Add'),
    );
  }

  FlatButton _buildEditButton(BuildContext context,
      {@required Job job, @required String costId}) {
    return FlatButton(
      onPressed: () {
        if (_formKey.currentState.validate()) {
          BlocProvider.of<IncomeBloc>(context).add(
            IncomeCostUpdated(
              job: job,
              cost: Cost(
                id: costId,
                name: _nameController.text,
                amount: num.parse(_amountController.text),
              ),
            ),
          );
          Navigator.of(context).pop();
        }
      },
      child: const Text('Edit'),
    );
  }

  FlatButton _buildCancelButton(BuildContext context) {
    return FlatButton(
      onPressed: () => Navigator.of(context).pop(),
      child: const Text('Cancel'),
    );
  }
}
