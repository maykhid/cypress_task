// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'album_response.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AlbumResponseAdapter extends TypeAdapter<AlbumResponse> {
  @override
  final int typeId = 1;

  @override
  AlbumResponse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AlbumResponse(
      userId: fields[0] as int,
      id: fields[1] as int,
      title: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AlbumResponse obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.title);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AlbumResponseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
