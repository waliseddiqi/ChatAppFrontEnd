// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_chat.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocalChatAdapter extends TypeAdapter<LocalChat> {
  @override
  final int typeId = 0;

  @override
  LocalChat read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocalChat(
      id: fields[0] as String,
      userName: fields[1] as String,
      isread: fields[2] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, LocalChat obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.userName)
      ..writeByte(2)
      ..write(obj.isread);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocalChatAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
