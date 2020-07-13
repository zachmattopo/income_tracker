import 'package:flutter/material.dart';
import 'package:income_tracker/utils/app_utils.dart';
import 'package:income_tracker/widgets/tab_daily_earns.dart';
import 'package:income_tracker/widgets/tab_monthly_earns.dart';
import 'package:income_tracker/widgets/tab_weekly_earns.dart';

class PageJobEarnings extends StatelessWidget {
  const PageJobEarnings({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: AppUtil.appLogo,
          centerTitle: true,
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                child: Text('Daily'),
              ),
              Tab(
                child: Text('Weekly'),
              ),
              Tab(
                child: Text('Monthly'),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: <Widget>[
            TabDailyEarns(),
            TabWeeklyEarns(),
            TabMonthlyEarns(),
          ],
        ),
      ),
    );
  }
}
