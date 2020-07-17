part of 'income_bloc.dart';

abstract class IncomeEvent extends Equatable {
  const IncomeEvent();

  @override
  List<Object> get props => [];
}

// class IncomeHistoryRequested extends IncomeEvent {}

class IncomeForDurationsRequested extends IncomeEvent {
  // final IncomeDuration duration;

  // const IncomeForDurationsRequested({@required this.duration})
  //     : assert(duration != null);

  // @override
  // List<Object> get props => [duration];
}

class IncomeRequested extends IncomeEvent {
  final String jobId;

  const IncomeRequested({@required this.jobId}) : assert(jobId != null);

  @override
  List<Object> get props => [jobId];
}

class IncomeUpdated extends IncomeEvent {
  final Job job;

  const IncomeUpdated({@required this.job}) : assert(job != null);

  @override
  List<Object> get props => [job];
}

class IncomeCostDeleted extends IncomeEvent {
  final Job job;
  final String costId;

  const IncomeCostDeleted({@required this.costId, @required this.job})
      : assert(costId != null && job != null);

  @override
  List<Object> get props => [
        job,
        costId,
      ];
}

class GoalUpdated extends IncomeEvent {
  final IncomeDuration duration;
  final num amount;

  const GoalUpdated({@required this.duration, @required this.amount})
      : assert(duration != null && amount != null);

  @override
  List<Object> get props => [
        duration,
        amount,
      ];
}

class GoalDeleted extends IncomeEvent {
  final IncomeDuration duration;

  const GoalDeleted({@required this.duration}) : assert(duration != null);
}
