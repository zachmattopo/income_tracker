import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import 'cost.dart';

part 'job.g.dart';

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

  static Job fromJson(Map<String, dynamic> map) {
    if (map == null) return null;

    final stringDate = map['date'] as String;
    final date = DateTime.fromMillisecondsSinceEpoch(int.parse(stringDate));
    final num commission = map['commission'] as num;
    final num twoDecimalCommission = num.parse(commission.toStringAsFixed(2));
    final List<Cost> costs = List<Cost>.from(
        map['costList']?.map((x) => Cost.fromMap(x as Map<String, dynamic>))
            as Iterable<dynamic>);

    // Calculate net earning = commission - costs
    final costsIter = costs.iterator;
    num netEarn = twoDecimalCommission;
    while (costsIter.moveNext()) {
      netEarn -= costsIter.current.amount;
    }

    return Job(
      id: map['id'] as String,
      name: map['name'] as String,
      date: date,
      fee: map['fee'] as num,
      commission: twoDecimalCommission,
      costList: costs,
      netEarn: netEarn,
    );
  }

  String toJson() => json.encode(toMap());

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
