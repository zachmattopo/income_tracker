import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:income_tracker/bloc/income_bloc.dart';
import 'package:income_tracker/models/job.dart';
import 'package:income_tracker/utils/app_utils.dart';
import 'package:income_tracker/widgets/page_earning_details.dart';
import 'package:intl/intl.dart';

class JobListWidget extends StatelessWidget {
  final List<Job> jobList;
  final IncomeDuration duration;

  const JobListWidget({
    Key key,
    @required this.jobList,
    @required this.duration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (jobList.isEmpty) {
      String durationString;
      switch (duration) {
        case IncomeDuration.daily:
          durationString = 'today';
          break;
        case IncomeDuration.weekly:
          durationString = 'this week';
          break;
        case IncomeDuration.monthly:
          durationString = 'this month';
          break;
      }
      return Padding(
        padding: const EdgeInsets.only(top: 24.0),
        child: Center(
          child: Text(
            "You haven't completed any jobs $durationString.\nGoGet going now!",
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: jobList.length,
      itemBuilder: (context, index) {
        final job = jobList[index];

        return Hero(
          tag: job.id,
          child: Card(
            child: ListTile(
              title: Row(
                children: <Widget>[
                  Expanded(
                    // flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        DateFormat('dd/MM/yy, kk:mm').format(job.date),
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
                        job.name,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'RM ${job.fee}',
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
                        'RM ${job.commission}',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PageEarningDetails(jobId: job.id),
                  ),
                );
                BlocProvider.of<IncomeBloc>(context)
                    .add(IncomeForDurationsRequested());
              },
            ),
          ),
        );
      },
    );
  }
}
