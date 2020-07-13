import 'package:flutter/material.dart';
import 'package:income_tracker/models/job.dart';
import 'package:income_tracker/models/cost.dart';
import 'package:income_tracker/utils/app_utils.dart';
import 'package:income_tracker/widgets/page_earning_details.dart';
import 'package:intl/intl.dart';

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
        // GOAL INDICATOR
        Container(
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
                  valueColor:
                      AlwaysStoppedAnimation<Color>(AppUtil.primaryColor),
                  value: 0.6,
                ),
              ),
            ],
          ),
        ),
        // JOB EARNINGS LIST
        ListTile(
          title: Row(
            children: const <Widget>[
              Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 8.0,
                    top: 8.0,
                    bottom: 8.0,
                  ),
                  child: Text('Date'),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.only(
                    right: 8.0,
                    top: 8.0,
                    bottom: 8.0,
                  ),
                  child: Text('Job'),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Fee'),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Commission'),
                ),
              ),
            ],
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 15,
          itemBuilder: (context, index) {
            return Hero(
              tag: mockJob.name + index.toString(),
              child: Card(
                child: ListTile(
                  title: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 8.0,
                            top: 8.0,
                            bottom: 8.0,
                          ),
                          child: Text(
                            DateFormat('dd/MM/yy,\nkk:mm').format(mockJob.date),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            right: 8.0,
                            top: 8.0,
                            bottom: 8.0,
                          ),
                          child: Text(
                            mockJob.name + index.toString(),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('RM ${mockJob.fee}'),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('RM ${mockJob.commission}'),
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PageEarningDetails(
                          jobObj: mockJob,
                          jobTitle: mockJob.name + index.toString(),
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
