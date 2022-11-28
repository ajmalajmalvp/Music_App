// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'play_list_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlayListerModelAdapter extends TypeAdapter<PlayListerModel> {
  @override
  final int typeId = 1;

  @override
  PlayListerModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PlayListerModel(
      name: fields[0] as String,
      songIds: (fields[1] as List).cast<int>(),
    );
  }

  @override
  void write(BinaryWriter writer, PlayListerModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.songIds);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlayListerModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
