// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bike.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BikeAdapter extends TypeAdapter<Bike> {
  @override
  final int typeId = 0;

  @override
  Bike read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Bike(
      ownerName: fields[0] as String,
      bikeType: fields[1] as String,
      make: fields[2] as String,
      model: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Bike obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.ownerName)
      ..writeByte(1)
      ..write(obj.bikeType)
      ..writeByte(2)
      ..write(obj.make)
      ..writeByte(3)
      ..write(obj.model);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BikeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
