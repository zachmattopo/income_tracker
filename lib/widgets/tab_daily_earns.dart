import 'package:flutter/material.dart';
import 'package:income_tracker/models/models.dart';
import 'package:income_tracker/widgets/widgets.dart';

class TabDailyEarns extends StatelessWidget {
  const TabDailyEarns({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mockJob = Job(
        id: '12345abc',
        name: 'Food Delivery',
        date: DateTime.now(),
        fee: 1.45,
        commission: 25.06,
        costList: [
          Cost(id: '4545sd', jobId: '12345abc', name: 'Petrol', amount: 1.25),
          Cost(id: '32jk4hjk', jobId: '12345abc', name: 'Toll', amount: 2.40),
          Cost(id: '4354lj', jobId: '12345abc', name: 'Parking', amount: 0.50),
        ],
        netEarn: 25.06);

    return ListView(
      children: <Widget>[
        const GoalIndicatorWidget(),
        const JobListHeaderWidget(),
        JobListWidget(mockJob: mockJob),
      ],
    );
  }
}
