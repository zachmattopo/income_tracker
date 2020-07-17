import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:income_tracker/bloc/income_bloc.dart';
import 'package:income_tracker/utils/app_utils.dart';
import 'package:income_tracker/widgets/widgets.dart';

class TabWeeklyEarns extends StatelessWidget {
  const TabWeeklyEarns({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // BlocProvider.of<IncomeBloc>(context).add(
    //   const IncomeForDurationRequested(duration: IncomeDuration.weekly),
    // );

    return BlocBuilder<IncomeBloc, IncomeState>(
      buildWhen: (prevState, currState) => currState is! IncomeLoadSuccess,
      builder: (context, state) {
        if (state is IncomeLoadInProgress) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is IncomeForDurationsLoadSuccess) {
          return Scrollbar(
            child: ListView(
              children: <Widget>[
                const GoalIndicatorWidget(),
                // TODO: Insert weekly summary chart here.
                const JobListHeaderWidget(),
                JobListWidget(
                  jobList: state.jobMap[IncomeDuration.weekly],
                  duration: IncomeDuration.weekly,
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
