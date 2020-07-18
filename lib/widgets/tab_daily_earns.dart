import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:income_tracker/bloc/income_bloc.dart';
import 'package:income_tracker/utils/app_utils.dart';
import 'package:income_tracker/widgets/widgets.dart';

class TabDailyEarns extends StatelessWidget {
  const TabDailyEarns({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // BlocProvider.of<IncomeBloc>(context).add(
    //   const IncomeForDurationRequested(duration: IncomeDuration.daily),
    // );
    // final mockJob = Job(
    //     id: '12345abc',
    //     name: 'Food Delivery',
    //     date: DateTime.now(),
    //     fee: 1.45,
    //     commission: 25.06,
    //     costList: [
    //       Cost(
    //         id: '4545sd',
    //         jobId: '12345abc',
    //         name: 'Petrol',
    //         amount: 1.25,
    //       ),
    //       Cost(
    //         id: '32jk4hjk',
    //         jobId: '12345abc',
    //         name: 'Toll',
    //         amount: 2.40,
    //       ),
    //       Cost(
    //         id: '4354lj',
    //         jobId: '12345abc',
    //         name: 'Parking',
    //         amount: 0.50,
    //       ),
    //     ],
    //     netEarn: 25.06);

    return BlocBuilder<IncomeBloc, IncomeState>(
      buildWhen: (prevState, currState) =>
          currState is! IncomeLoadSuccess && currState is! IncomeDummyState,
      builder: (context, state) {
        if (state is IncomeLoadInProgress) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is IncomeForDurationsLoadSuccess) {
          return Scrollbar(
            child: ListView(
              children: <Widget>[
                const GoalIndicatorWidget(),
                const JobListHeaderWidget(),
                JobListWidget(
                  jobList: state.jobMap[IncomeDuration.daily],
                  duration: IncomeDuration.daily,
                ),
              ],
            ),
          );
        }

        if (state is IncomeLoadFailure) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                // ignore: lines_longer_than_80_chars
                'Something went wrong!\nMock data was not available from HTTP request.',
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          );
        }

        return Container();
      },
    );
  }
}
