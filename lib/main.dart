import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:income_tracker/utils/app_utils.dart';
import 'package:income_tracker/widgets/page_job_earnings.dart';
import 'package:income_tracker/services/api_client.dart';
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
        primaryColorBrightness: Brightness.dark,
        accentColorBrightness: Brightness.dark,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        brightness: Brightness.dark,
      ),
      home: const PageJobEarnings(),
    );
  }
}
