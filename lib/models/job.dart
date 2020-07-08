import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:income_tracker/models/cost.dart';

class Job extends Equatable {
  final int id;
  final String name;
  final DateTime date;
  final num fee;
  final num commission;
  final List<Cost> cost;
  final num netEarn;

  Job({
    this.id,
    this.name,
    this.date,
    this.fee,
    this.commission,
    this.cost,
    this.netEarn,
  });

  @override
  List<Object> get props => [
        id,
        name,
        date,
        fee,
        commission,
        cost,
        netEarn,
      ];

  Job copyWith({
    int id,
    String name,
    DateTime date,
    num fee,
    num commission,
    List<Cost> cost,
    num netEarn,
  }) {
    return Job(
      id: id ?? this.id,
      name: name ?? this.name,
      date: date ?? this.date,
      fee: fee ?? this.fee,
      commission: commission ?? this.commission,
      cost: cost ?? this.cost,
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
      'cost': cost?.map((x) => x?.toMap())?.toList(),
      'netEarn': netEarn,
    };
  }

  static Job fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Job(
      id: map['id'],
      name: map['name'],
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      fee: map['fee'],
      commission: map['commission'],
      cost: List<Cost>.from(map['cost']?.map((x) => Cost.fromMap(x))),
      netEarn: map['netEarn'],
    );
  }

  String toJson() => json.encode(toMap());

  static Job fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'Job(id: $id, name: $name, date: $date, fee: $fee, commission: $commission, cost: $cost, netEarn: $netEarn)';
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
        listEquals(o.cost, cost) &&
        o.netEarn == netEarn;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        date.hashCode ^
        fee.hashCode ^
        commission.hashCode ^
        cost.hashCode ^
        netEarn.hashCode;
  }
}
