import 'package:income_tracker/models/job.dart';
import 'package:income_tracker/services/database_provider.dart';

abstract class DatabaseService {
  DatabaseProvider databaseProvider;

  Future<Job> insert(Job job);

  Future<List<Job>> insertAll(List<Job> jobList);

  Job update(Job job);

  Job delete(Job job);

  Future<List<Job>> getJobs(DateTime start, DateTime end);

  Future<dynamic> upsertMiscData(String key, dynamic value);

  Future<dynamic> getMiscData(String key);

  Future<String> deleteMiscData(String key);
}
