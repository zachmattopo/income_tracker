import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:income_tracker/models/cost.dart';
import 'package:income_tracker/models/job.dart';
import 'package:income_tracker/services/api_client.dart';
import 'package:income_tracker/utils/app_utils.dart';
import 'package:income_tracker/widgets/page_job_earnings.dart';
import 'package:http/http.dart' as http;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // final apiClient = ApiClient(httpClient: http.Client());
  // final list = await apiClient.fetchJobHistory();
  // print(list.toString());

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await Hive.initFlutter();
  Hive.registerAdapter<Job>(JobAdapter());
  Hive.registerAdapter<Cost>(CostAdapter());
  await Hive.openBox<Job>(AppUtil.jobsBoxName);
  await Hive.openBox(AppUtil.miscBoxName);

  runApp(IncomeTrackerApp());
}

class IncomeTrackerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Income Tracker',
      theme: ThemeData(
        primarySwatch: AppUtil.primarySwatch,
        accentColor: AppUtil.secondaryColor,
        accentColorBrightness: Brightness.dark,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        brightness: Brightness.dark,
      ),
      home: const PageJobEarnings(),
    );
  }
}
