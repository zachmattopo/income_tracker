import 'package:income_tracker/services/database_provider.dart';
import 'package:income_tracker/models/job.dart';
import 'package:income_tracker/services/database_service.dart';
import 'package:income_tracker/utils/app_utils.dart';

class HiveDatabaseService implements DatabaseService {
  @override
  DatabaseProvider databaseProvider;

  HiveDatabaseService(this.databaseProvider);

  @override
  Future<Job> insert(Job job) async {
    final jobDb = await databaseProvider.jobDb();
    jobDb.add(job);
    return job;
  }

  @override
  Future<List<Job>> insertAll(List<Job> jobList) async {
    final jobDb = await databaseProvider.jobDb();
    jobDb.addAll(jobList);
    return jobList;
  }

  @override
  Job update(Job job) {
    job.save();
    return job;
  }

  @override
  Job delete(Job job) {
    job.delete();
    return job;
  }

  @override
  Future<List<Job>> getJobs(DateTime start, DateTime end) async {
    final jobDb = await databaseProvider.jobDb();
    final jobList = jobDb.values
        .where((job) => job.date.isAfter(start) && job.date.isBefore(end))
        .toList();
    return jobList;
  }

  @override
  Future<dynamic> upsertMiscData(String key, dynamic value) async {
    final miscDb = await databaseProvider.miscDb();
    miscDb.put(key, value);
    return value;
  }

  @override
  Future<dynamic> getMiscData(String key) async {
    final miscDb = await databaseProvider.miscDb();
    return (key == AppUtil.initialSyncKey)
        ? miscDb.get(key, defaultValue: false)
        : miscDb.get(key);
  }

  @override
  Future<String> deleteMiscData(String key) async {
    final miscDb = await databaseProvider.miscDb();
    miscDb.delete(key);
    return key;
  }
}
