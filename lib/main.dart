import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:income_tracker/models/cost.dart';
import 'package:income_tracker/models/job.dart';
import 'package:income_tracker/utils/app_utils.dart';
import 'package:income_tracker/widgets/page_job_earnings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
