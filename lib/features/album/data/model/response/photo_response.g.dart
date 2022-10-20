// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo_response.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PhotoResponseAdapter extends TypeAdapter<PhotoResponse> {
  @override
  final int typeId = 0;

  @override
  PhotoResponse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PhotoResponse(
      albumId: fields[0] as int,
      id: fields[1] as int,
      title: fields[2] as String,
      url: fields[3] as String,
      thumbnailUrl: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PhotoResponse obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.albumId)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.url)
      ..writeByte(4)
      ..write(obj.thumbnailUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PhotoResponseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class AllPhotoResponsesAdapter extends TypeAdapter<AllPhotoResponses> {
  @override
  final int typeId = 3;

  @override
  AllPhotoResponses read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AllPhotoResponses(
      photoResponses: (fields[1] as List).cast<PhotoResponse>(),
    );
  }

  @override
  void write(BinaryWriter writer, AllPhotoResponses obj) {
    writer
      ..writeByte(1)
      ..writeByte(1)
      ..write(obj.photoResponses);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AllPhotoResponsesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
