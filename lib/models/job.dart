import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import 'cost.dart';

part 'job.g.dart';

// TODO: Move these 2 lines to appropriate file
// Run a python simple http server in assets/json/ folder to retrieve data
final String server =
    defaultTargetPlatform == TargetPlatform.android ? '10.0.2.2' : 'localhost';
final String jsonUrl = 'http://$server:8000/mock_data.json';

@HiveType(typeId: 0)
class Job extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final DateTime date;
  @HiveField(3)
  final num fee;
  @HiveField(4)
  final num commission;
  @HiveField(5)
  final List<Cost> costList;
  @HiveField(6)
  final num netEarn;

  Job({
    @required this.id,
    @required this.name,
    @required this.date,
    @required this.fee,
    @required this.commission,
    this.costList,
    @required this.netEarn,
  });

  Job copyWith({
    String id,
    String name,
    DateTime date,
    num fee,
    num commission,
    List<Cost> costList,
    num netEarn,
  }) {
    return Job(
      id: id ?? this.id,
      name: name ?? this.name,
      date: date ?? this.date,
      fee: fee ?? this.fee,
      commission: commission ?? this.commission,
      costList: costList ?? this.costList,
      netEarn: netEarn ?? this.netEarn,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'date': date?.millisecondsSinceEpoch,
      'fee': fee,
      'commission': commission,
      'costList': costList?.map((x) => x?.toMap())?.toList(),
      'netEarn': netEarn,
    };
  }

  static Job fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Job(
      id: map['id'] as String,
      name: map['name'] as String,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      fee: map['fee'] as num,
      commission: map['commission'] as num,
      costList: List<Cost>.from(
          map['costList']?.map((x) => Cost.fromMap(x as Map<String, dynamic>))
              as Iterable<dynamic>),
      netEarn: map['netEarn'] as num,
    );
  }

  String toJson() => json.encode(toMap());

  static Job fromJson(String source) =>
      fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    // ignore: lines_longer_than_80_chars
    return 'Job(id: $id, name: $name, date: $date, fee: $fee, commission: $commission, costList: $costList, netEarn: $netEarn)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Job &&
        o.id == id &&
        o.name == name &&
        o.date == date &&
        o.fee == fee &&
        o.commission == commission &&
        listEquals(o.costList, costList) &&
        o.netEarn == netEarn;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        date.hashCode ^
        fee.hashCode ^
        commission.hashCode ^
        costList.hashCode ^
        netEarn.hashCode;
  }
}
