import 'package:flutter/material.dart';
import 'package:income_tracker/utils/app_utils.dart';

class GoalIndicatorWidget extends StatelessWidget {
  const GoalIndicatorWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.0,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          const Expanded(
            child: Text('Goal Today'),
          ),
          Expanded(
            flex: 2,
            child: Text('RM60 of RM100',
                style: Theme.of(context).textTheme.headline6),
          ),
          Expanded(
            flex: 2,
            child: LinearProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppUtil.primaryColor),
              value: 0.6,
            ),
          ),
        ],
      ),
    );
  }
}
