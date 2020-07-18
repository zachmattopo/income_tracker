part of 'income_bloc.dart';

abstract class IncomeState extends Equatable {
  const IncomeState();

  @override
  List<Object> get props => [];
}

class IncomeInitial extends IncomeState {}

class IncomeLoadInProgress extends IncomeState {}

// class IncomeSyncSuccess extends IncomeState {}

// Workaround for cost name not updating when edited
// https://stackoverflow.com/a/60869187/9166207
class IncomeDummyState extends IncomeState {}

class IncomeLoadSuccess extends IncomeState {
  final Job job;

  const IncomeLoadSuccess({@required this.job}) : assert(job != null);

  @override
  List<Object> get props => [job];
}

// class IncomeForDurationDayLoadSuccess extends IncomeState {
//   final List<Job> jobList;

//   const IncomeForDurationDayLoadSuccess({@required this.jobList})
//       : assert(jobList != null);

//   @override
//   List<Object> get props => [jobList];
// }

// class IncomeForDurationWeekLoadSuccess extends IncomeState {
//   final List<Job> jobList;

//   const IncomeForDurationWeekLoadSuccess({@required this.jobList})
//       : assert(jobList != null);

//   @override
//   List<Object> get props => [jobList];
// }

// class IncomeForDurationMonthLoadSuccess extends IncomeState {
//   final List<Job> jobList;

//   const IncomeForDurationMonthLoadSuccess({@required this.jobList})
//       : assert(jobList != null);

//   @override
//   List<Object> get props => [jobList];
// }

class IncomeForDurationsLoadSuccess extends IncomeState {
  final Map<IncomeDuration, List<Job>> jobMap;

  const IncomeForDurationsLoadSuccess({@required this.jobMap})
      : assert(jobMap != null);

  @override
  List<Object> get props => [jobMap];
}

// TODO: Need this?
class IncomeGoalLoadSuccess extends IncomeState {}

class IncomeLoadFailure extends IncomeState {}
