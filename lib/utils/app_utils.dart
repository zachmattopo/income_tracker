import 'package:flutter/material.dart';

enum IncomeDuration {
  daily,
  weekly,
  monthly,
}

class AppUtil {
  static MaterialColor primarySwatch = Colors.teal;

  static Color primaryColor = Colors.teal[300];

  static Color secondaryColor = Colors.deepPurple[200];
  // const Color(0xff5e35b0);

  static Image appLogo = const Image(
    image: AssetImage('assets/images/logo_get.png'),
    height: 32.0,
    fit: BoxFit.contain,
  );

  static String jobsBoxName = 'jobsBox';

  static String miscBoxName = 'miscBox';

  static String initialSyncKey = 'firstTimeSyncDone';
}
