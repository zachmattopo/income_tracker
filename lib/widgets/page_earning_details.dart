import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:income_tracker/bloc/income_bloc.dart';
import 'package:income_tracker/models/models.dart';

class PageEarningDetails extends StatelessWidget {
  final String jobId;

  const PageEarningDetails({
    Key key,
    @required this.jobId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<IncomeBloc>(context).add(IncomeRequested(jobId: jobId));

    return Scaffold(
      appBar: AppBar(title: const Text('Earning Details')),
      body: BlocBuilder<IncomeBloc, IncomeState>(
        builder: (context, state) {
          if (state is IncomeLoadInProgress) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is IncomeLoadSuccess) {
            final job = state.job;
            return ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              children: <Widget>[
                const SizedBox(height: 20.0),
                _buildTextGroup(context, 'Job name', job.name),
                const SizedBox(height: 40.0),
                _buildTextGroup(context, 'Date and time',
                    DateFormat('dd/MM/yy, kk:mm').format(job.date)),
                const SizedBox(height: 40.0),
                _buildTextGroup(
                    context, 'Fee', 'RM ${job.fee.toStringAsFixed(2)}'),
                const SizedBox(height: 40.0),
                _buildTextGroup(context, 'Commission',
                    'RM ${job.commission.toStringAsFixed(2)}'),
                const SizedBox(height: 40.0),
                _buildCostList(context, job),
                const SizedBox(height: 40.0),
                _buildTextGroup(context, 'Net Earning',
                    'RM ${job.netEarn.toStringAsFixed(2)}'),
                const SizedBox(height: 20.0),
              ],
            );
          }

          if (state is IncomeLoadFailure) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Something went wrong!',
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
            );
          }

          return Container();
        },
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

  Widget _buildCostList(BuildContext context, Job job) {
    final costList = job.costList;

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
                subtitle: Text('RM ${cost.amount.toStringAsFixed(2)}'),
                trailing: Wrap(
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AddOrEditAlertDialog(
                              editMode: true,
                              job: job,
                              cost: cost,
                            );
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
                            return _buildDeleteAlert(context, job, cost.id);
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
                    return AddOrEditAlertDialog(
                      editMode: false,
                      job: job,
                      cost: null,
                    );
                  },
                );
              },
            ),
          ),
        )
      ],
    );
  }

  AlertDialog _buildDeleteAlert(BuildContext context, Job job, String costId) {
    return AlertDialog(
      title: const Text('Delete this expense?'),
      actions: [
        _buildCancelButton(context),
        _buildDeleteButton(context, job, costId),
      ],
    );
  }

  FlatButton _buildDeleteButton(BuildContext context, Job job, String costId) {
    return FlatButton(
      onPressed: () {
        BlocProvider.of<IncomeBloc>(context).add(
          IncomeCostDeleted(
            costId: costId,
            job: job,
          ),
        );
        Navigator.of(context).pop();
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
          _buildEditButton(context)
        else
          _buildAddButton(context),
      ],
    );
  }

  FlatButton _buildAddButton(BuildContext context) {
    return FlatButton(
      onPressed: () {
        if (_formKey.currentState.validate()) {
          // If the form is valid, display a snackbar. In the real world,
          // you'd often call a server or save the information in a database.
          // TODO: Add expense
          // Navigator.of(context).pop();
        }
      },
      child: const Text('Add'),
    );
  }

  FlatButton _buildEditButton(BuildContext context) {
    return FlatButton(
      onPressed: () {
        if (_formKey.currentState.validate()) {
          // If the form is valid, display a snackbar. In the real world,
          // you'd often call a server or save the information in a database.
          // TODO: Edit expense
          // Navigator.of(context).pop();
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
