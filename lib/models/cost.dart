import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

part 'cost.g.dart';

@HiveType(typeId: 1)
class Cost extends HiveObject with EquatableMixin {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String jobId;
  @HiveField(2)
  final String name;
  @HiveField(3)
  final num amount;

  Cost({
    @required this.id,
    this.jobId,
    @required this.name,
    @required this.amount,
  });

  Cost copyWith({
    String id,
    String jobId,
    String name,
    num amount,
  }) {
    return Cost(
      id: id ?? this.id,
      jobId: jobId ?? this.jobId,
      name: name ?? this.name,
      amount: amount ?? this.amount,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'jobId': jobId,
      'name': name,
      'amount': amount,
    };
  }

  static Cost fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    final amount = map['amount'] as num;
    final twoDecimalAmount = num.parse(amount.toStringAsFixed(2));

    return Cost(
      id: map['id'] as String,
      jobId: map['jobId'] as String,
      name: map['name'] as String,
      amount: twoDecimalAmount,
    );
  }

  String toJson() => json.encode(toMap());

  static Cost fromJson(String source) =>
      fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Cost(id: $id, jobId: $jobId, name: $name, amount: $amount)';
  }

  // @override
  // bool operator ==(Object o) {
  //   if (identical(this, o)) return true;

  //   return o is Cost &&
  //       o.id == id &&
  //       o.jobId == jobId &&
  //       o.name == name &&
  //       o.amount == amount;
  // }

  // @override
  // int get hashCode {
  //   return id.hashCode ^ jobId.hashCode ^ name.hashCode ^ amount.hashCode;
  // }

  @override
  List<Object> get props => [
        id,
        jobId,
        name,
        amount,
      ];
}
