// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'menus.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MenusAdapter extends TypeAdapter<Menus> {
  @override
  final int typeId = 1;

  @override
  Menus read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Menus(
      foods: (fields[0] as List)?.cast<Menu>(),
      drinks: (fields[1] as List)?.cast<Menu>(),
    );
  }

  @override
  void write(BinaryWriter writer, Menus obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.foods)
      ..writeByte(1)
      ..write(obj.drinks);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MenusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
