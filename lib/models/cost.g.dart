// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cost.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CostAdapter extends TypeAdapter<Cost> {
  @override
  final int typeId = 1;

  @override
  Cost read(BinaryReader reader) {
    final int numOfFields = reader.readByte();
    final Map<int, dynamic> fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Cost(
      id: fields[0] as String,
      jobId: fields[1] as String,
      name: fields[2] as String,
      amount: fields[3] as num,
    );
  }

  @override
  void write(BinaryWriter writer, Cost obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.jobId)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.amount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CostAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
