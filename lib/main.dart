import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:income_tracker/bloc/income_bloc.dart';
import 'package:income_tracker/services/api_client.dart';
import 'package:income_tracker/services/database_provider.dart';
import 'package:income_tracker/services/hive_database_service.dart';
import 'package:income_tracker/services/income_tracker_service.dart';
import 'package:income_tracker/utils/app_utils.dart';
import 'package:income_tracker/widgets/page_job_earnings.dart';

import 'main_bloc_delegate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  Bloc.observer = MainBlocObserver();

  final IncomeTrackerService incomeTrackerService = IncomeTrackerService(
    apiClient: ApiClient(
      httpClient: http.Client(),
    ),
    hiveDatabaseService: HiveDatabaseService(
      databaseProvider: DatabaseProvider(),
    ),
  );

  runApp(IncomeTrackerApp(incomeTrackerService: incomeTrackerService));
}

class IncomeTrackerApp extends StatelessWidget {
  final IncomeTrackerService incomeTrackerService;

  const IncomeTrackerApp({Key key, @required this.incomeTrackerService})
      : assert(incomeTrackerService != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Income Tracker',
      theme: ThemeData(
        primarySwatch: AppUtil.primarySwatch,
        accentColor: AppUtil.secondaryColor,
        primaryColorBrightness: Brightness.dark,
        accentColorBrightness: Brightness.dark,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        brightness: Brightness.dark,
      ),
      home: BlocProvider(
        create: (context) => IncomeBloc(incomeService: incomeTrackerService)
          ..add(IncomeForDurationsRequested()),
        child: const PageJobEarnings(),
      ),
    );
  }
}
