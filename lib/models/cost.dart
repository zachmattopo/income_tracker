import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Cost extends Equatable {
  final int id;
  final String name;
  final num amount;

  Cost({
    @required this.id,
    @required this.name,
    @required this.amount,
  });

  @override
  List<Object> get props => [
        id,
        name,
        amount,
      ];

  Cost copyWith({
    int id,
    String name,
    num amount,
  }) {
    return Cost(
      id: id ?? this.id,
      name: name ?? this.name,
      amount: amount ?? this.amount,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'amount': amount,
    };
  }

  static Cost fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Cost(
      id: map['id'],
      name: map['name'],
      amount: map['amount'],
    );
  }

  String toJson() => json.encode(toMap());

  static Cost fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() => 'Cost(id: $id, name: $name, amount: $amount)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Cost && o.id == id && o.name == name && o.amount == amount;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ amount.hashCode;
}
