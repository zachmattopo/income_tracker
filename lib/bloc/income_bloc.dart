import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
// import 'package:rxdart/rxdart.dart';

import 'package:income_tracker/models/models.dart';
import 'package:income_tracker/services/income_tracker_service.dart';
import 'package:income_tracker/utils/app_utils.dart';

part 'income_event.dart';
part 'income_state.dart';

class IncomeBloc extends Bloc<IncomeEvent, IncomeState> {
  final IncomeTrackerService incomeService;

  IncomeBloc({@required this.incomeService})
      : assert(incomeService != null),
        super(IncomeInitial());

  // https://github.com/felangel/bloc/issues/524#issuecomment-625296803
  // @override
  // Stream<Transition<IncomeEvent, IncomeState>> transformEvents(
  //   Stream<IncomeEvent> events,
  //   TransitionFunction<IncomeEvent, IncomeState> transitionFn,
  // ) {
  //   final nonDebounceStream =
  //       events.where((event) => event is! IncomeHistoryRequested);

  //   final debounceStream = events
  //       .where((event) => event is IncomeHistoryRequested)
  //       .debounceTime(const Duration(milliseconds: 500));

  //   return super.transformEvents(
  //       MergeStream([nonDebounceStream, debounceStream]), transitionFn);
  // }

  @override
  Stream<IncomeState> mapEventToState(IncomeEvent event) async* {
    if (event is IncomeForDurationsRequested) {
      yield* _mapIncomeForDurationRequestedToState(event);
    } else if (event is IncomeRequested) {
      yield* _mapIncomeRequestedtoState(event);
    } else if (event is IncomeCostDeleted) {
      yield* _mapIncomeCostDeletedtoState(event);
    }
  }

  Stream<IncomeState> _mapIncomeRequestedtoState(IncomeRequested event) async* {
    final job = await incomeService.getJob(event.jobId);
    yield IncomeLoadSuccess(job: job);
  }

  Stream<IncomeState> _mapIncomeCostDeletedtoState(
      IncomeCostDeleted event) async* {
    final job = event.job;

    // Recalculate net earn with new costs
    job.costList.removeWhere((cost) => cost.id == event.costId);
    num newNetEarn = job.commission;
    final costsIter = job.costList.iterator;
    while (costsIter.moveNext()) {
      newNetEarn -= costsIter.current.amount;
    }
    final Job newJob = job.copyWith(netEarn: newNetEarn);
    await incomeService.upsertJob(newJob);

    yield IncomeLoadSuccess(job: newJob);
  }

  // Stream<IncomeState> _mapIncomeHistoryRequestedToState() async* {
  //   // yield IncomeLoadInProgress();

  //   try {
  //     await incomeService.initialSync();
  //     // yield IncomeSyncSuccess();
  //   } catch (_) {
  //     // yield IncomeLoadFailure();
  //   }
  // }

  Stream<IncomeState> _mapIncomeForDurationRequestedToState(
      IncomeForDurationsRequested event) async* {
    yield IncomeLoadInProgress();

    try {
      await incomeService.initialSync();
      final jobsDaily = await incomeService.getDailyJobs(DateTime.now());
      final jobsWeekly = await incomeService.getWeeklyJobs(DateTime.now());
      final jobsMonthly = await incomeService.getMonthlyJobs(DateTime.now());

      final jobsMap = {
        IncomeDuration.daily: jobsDaily,
        IncomeDuration.weekly: jobsWeekly,
        IncomeDuration.monthly: jobsMonthly,
      };

      yield IncomeForDurationsLoadSuccess(jobMap: jobsMap);
    } catch (_) {
      yield IncomeLoadFailure();
    }
  }
}
