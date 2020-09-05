import 'dart:async';

import 'package:income_tracker/utils/app_utils.dart';
import 'package:meta/meta.dart';

import 'package:income_tracker/models/models.dart';

import 'api_client.dart';
import 'hive_database_service.dart';

class IncomeTrackerService {
  final ApiClient apiClient;
  final HiveDatabaseService hiveDatabaseService;

  IncomeTrackerService({
    @required this.apiClient,
    @required this.hiveDatabaseService,
  }) : assert(apiClient != null && hiveDatabaseService != null);

  Future<void> initialSync() async {
    final isSynced = await getIsSyncedFlag();
    if (isSynced) return;

    final jobList = await apiClient.fetchJobHistory();
    hiveDatabaseService.insertAll(jobList);
    updateIsSyncedFlag(isSynced: true);
  }

  Future<List<Job>> getDailyJobs(DateTime date) async {
    final lastMidnight = DateTime(date.year, date.month, date.day);
    final nextMidnight = DateTime(date.year, date.month, date.day + 1);
    final jobList =
        await hiveDatabaseService.getJobs(lastMidnight, nextMidnight);
    jobList.sort((a, b) => (b.date).compareTo(a.date));
    return jobList;
  }

  Future<List<Job>> getWeeklyJobs(DateTime date) async {
    final startWeek = date.subtract(Duration(days: date.weekday - 1));
    final endWeek =
        date.add(Duration(days: DateTime.daysPerWeek - date.weekday));
    final jobList = await hiveDatabaseService.getJobs(startWeek, endWeek);
    jobList.sort((a, b) => (b.date).compareTo(a.date));
    return jobList;
  }

  Future<List<Job>> getMonthlyJobs(DateTime date) async {
    // final startMonth = (date.month > 1)
    //     ? DateTime(date.year, date.month - 1, 0, 0)
    //     : DateTime(date.year - 1, 12, 0, 0);
    // final endMonth = (date.month < 12)
    //     ? DateTime(date.year, date.month + 1, 0, 0)
    //     : DateTime(date.year + 1, 1, 0, 0);

    // No need to check overflow/underflow since it's handled by Dart's DateTime
    final startMonth = DateTime(date.year, date.month);
    final endMonth = DateTime(date.year, date.month + 1, 0, 23, 59, 59);
    final jobList = await hiveDatabaseService.getJobs(startMonth, endMonth);
    jobList.sort((a, b) => (b.date).compareTo(a.date));
    return jobList;
  }

  Future<Job> getJob(String jobId) async {
    final job = await hiveDatabaseService.getJob(jobId);
    return job;
  }

  Future<Job> upsertJob(Job job) async {
    await hiveDatabaseService.upsert(job);
    return job;
  }

  Future<void> updateGoal(Duration duration, num amount) async {
    await hiveDatabaseService.upsertMiscData(duration.toString(), amount);
    return;
  }

  Future<num> getGoal(Duration duration) async {
    return await hiveDatabaseService.getMiscData(duration.toString()) as num;
  }

  Future<void> updateIsSyncedFlag({bool isSynced}) async {
    await hiveDatabaseService.upsertMiscData(AppUtil.initialSyncKey, isSynced);
    return;
  }

  Future<bool> getIsSyncedFlag() async {
    final flag =
        await hiveDatabaseService.getMiscData(AppUtil.initialSyncKey) as bool;
    return flag ?? false;
  }
}
