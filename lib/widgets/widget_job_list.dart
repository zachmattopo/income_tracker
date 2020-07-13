import 'package:flutter/material.dart';
import 'package:income_tracker/models/job.dart';
import 'package:income_tracker/widgets/page_earning_details.dart';
import 'package:intl/intl.dart';

class JobListWidget extends StatelessWidget {
  const JobListWidget({
    Key key,
    @required this.mockJob,
  }) : super(key: key);

  final Job mockJob;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
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
                    // flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        DateFormat('dd/MM/yy, kk:mm').format(mockJob.date),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        mockJob.name + index.toString(),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'RM ${mockJob.fee}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Expanded(
                    // flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'RM ${mockJob.commission}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
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
    );
  }
}
