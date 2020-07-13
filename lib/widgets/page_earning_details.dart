import 'package:flutter/material.dart';
import 'package:income_tracker/models/cost.dart';
import 'package:income_tracker/models/job.dart';
import 'package:intl/intl.dart';

class PageEarningDetails extends StatelessWidget {
  final Job jobObj;
  final String jobTitle; // For Hero tag only
  // final TextEditingController _textFieldController = TextEditingController();

  const PageEarningDetails({
    Key key,
    @required this.jobObj,
    this.jobTitle,
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
              tag: jobTitle,
              // flightShuttleBuilder: AppUtil.flightShuttleBuilder,
              child: _buildTextGroup(context, 'Job name', jobTitle)),
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
        Text(
          content,
          style: Theme.of(context).textTheme.headline4,
        ),
        if (content == 'Net Earning')
          Icon(Icons.monetization_on)
        else
          Container(),
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
                      // TODO: Edit expense
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
                      // TODO: Delete expense
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
              // TODO: Add expense
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
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: const <Widget>[
          TextField(
            // controller: _textFieldController,
            decoration: InputDecoration(labelText: 'Name'),
          ),
          TextField(
            // controller: _textFieldController,
            decoration: InputDecoration(labelText: 'Amount'),
          ),
        ],
      ),
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
      onPressed: () {},
      child: const Text('Add'),
    );
  }

  FlatButton _buildEditButton() {
    return FlatButton(
      onPressed: () {},
      child: const Text('Edit'),
    );
  }

  FlatButton _buildDeleteButton() {
    return FlatButton(
      onPressed: () {},
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
