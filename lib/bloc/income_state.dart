part of 'income_bloc.dart';

abstract class IncomeState extends Equatable {
  const IncomeState();

  @override
  List<Object> get props => [];
}

class IncomeInitial extends IncomeState {}

class IncomeLoadInProgress extends IncomeState {}

class IncomeLoadSuccess extends IncomeState {
  final Job job;

  const IncomeLoadSuccess({@required this.job}) : assert(job != null);

  @override
  List<Object> get props => [job];
}

class IncomeForDurationLoadSuccess extends IncomeState {
  final List<Job> jobList;

  const IncomeForDurationLoadSuccess({@required this.jobList})
      : assert(jobList != null);

  @override
  List<Object> get props => [jobList];
}

// TODO: Need this?
class IncomeGoalLoadSuccess extends IncomeState {}

class IncomeLoadFailure extends IncomeState {}
