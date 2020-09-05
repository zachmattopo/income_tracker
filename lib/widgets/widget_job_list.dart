import 'package:flutter/material.dart';
import 'package:income_tracker/models/job.dart';
import 'package:income_tracker/utils/app_utils.dart';
import 'package:income_tracker/widgets/widget_job_card.dart';

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
        return JobCardWidget(job: jobList[index]);
      },
    );
  }
}
