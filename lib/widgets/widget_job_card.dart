import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:income_tracker/bloc/income_bloc.dart';
import 'package:income_tracker/models/job.dart';
import 'package:income_tracker/widgets/page_earning_details.dart';
import 'package:intl/intl.dart';

class JobCardWidget extends StatelessWidget {
  const JobCardWidget({
    Key key,
    @required this.job,
  }) : super(key: key);

  final Job job;

  @override
  Widget build(BuildContext context) {
    // return Padding(
    //   padding: const EdgeInsets.all(4.0),
    //   child: OpenContainer(
    //     closedColor:
    //         ThemeData.dark().cardTheme.color ?? ThemeData.dark().cardColor,
    //     closedElevation: 3.0,
    //     openElevation: 6.0,
    //     closedBuilder: (context, action) {
    //       return ListTile(
    //         title: Row(
    //           children: <Widget>[
    //             Expanded(
    //               // flex: 2,
    //               child: Padding(
    //                 padding: const EdgeInsets.all(8.0),
    //                 child: Text(
    //                   DateFormat('dd/MM/yy, kk:mm').format(job.date),
    //                   maxLines: 3,
    //                   overflow: TextOverflow.ellipsis,
    //                 ),
    //               ),
    //             ),
    //             Expanded(
    //               flex: 2,
    //               child: Padding(
    //                 padding: const EdgeInsets.all(8.0),
    //                 child: Text(
    //                   job.name,
    //                   maxLines: 3,
    //                   overflow: TextOverflow.ellipsis,
    //                 ),
    //               ),
    //             ),
    //             Expanded(
    //               child: Padding(
    //                 padding: const EdgeInsets.all(8.0),
    //                 child: Text(
    //                   'RM ${job.fee.toStringAsFixed(2)}',
    //                   maxLines: 2,
    //                   overflow: TextOverflow.ellipsis,
    //                 ),
    //               ),
    //             ),
    //             Expanded(
    //               // flex: 2,
    //               child: Padding(
    //                 padding: const EdgeInsets.all(8.0),
    //                 child: Text(
    //                   'RM ${job.commission.toStringAsFixed(2)}',
    //                   maxLines: 2,
    //                   overflow: TextOverflow.ellipsis,
    //                 ),
    //               ),
    //             ),
    //           ],
    //         ),
    //       );
    //     },
    //     openBuilder: (context, action) {
    //       return PageEarningDetails(jobId: job.id);

    //       // TODO: Fix this bloc state issue, list not visible if not this state!
    //       BlocProvider.of<IncomeBloc>(context)
    //           .add(IncomeForDurationsRequested());
    //     },
    //   ),
    // );

    return Card(
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
                  'RM ${job.fee.toStringAsFixed(2)}',
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
                  'RM ${job.commission.toStringAsFixed(2)}',
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
    );
  }
}
