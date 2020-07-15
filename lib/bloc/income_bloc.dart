import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:income_tracker/models/models.dart';
import 'package:income_tracker/utils/app_utils.dart';
import 'package:meta/meta.dart';

part 'income_event.dart';
part 'income_state.dart';

class IncomeBloc extends Bloc<IncomeEvent, IncomeState> {
  IncomeBloc() : super(IncomeInitial());

  @override
  Stream<IncomeState> mapEventToState(IncomeEvent event) async* {
    if (event is IncomeHistoryRequested) {
      yield IncomeLoadInProgress();
    }
  }
}
