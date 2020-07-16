import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:income_tracker/models/models.dart';
import 'package:income_tracker/utils/app_utils.dart';

class DatabaseProvider {
  static final DatabaseProvider _instance =
      DatabaseProvider._privateConstructor();
  bool _isInitialized = false;

  DatabaseProvider._privateConstructor();

  // ignore: sort_unnamed_constructors_first
  factory DatabaseProvider() {
    return _instance;
  }

  Future<Box<Job>> jobDb() async {
    if (!_isInitialized) await _init();
    return Hive.box(AppUtil.jobsBoxName);
  }

  Future<Box> miscDb() async {
    if (!_isInitialized) await _init();
    return Hive.box(AppUtil.miscBoxName);
  }

  Future _init() async {
    await Hive.initFlutter();
    Hive.registerAdapter<Job>(JobAdapter());
    Hive.registerAdapter<Cost>(CostAdapter());
    await Hive.openBox<Job>(AppUtil.jobsBoxName);
    await Hive.openBox(AppUtil.miscBoxName);
    _isInitialized = true;
  }
}
