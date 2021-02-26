// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_messages.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocalMessagesAdapter extends TypeAdapter<LocalMessages> {
  @override
  final int typeId = 2;

  @override
  LocalMessages read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocalMessages(
      id: fields[0] as String,
      userName: fields[1] as String,
      messages: (fields[2] as List)?.cast<LocalMessage>(),
    );
  }

  @override
  void write(BinaryWriter writer, LocalMessages obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.userName)
      ..writeByte(2)
      ..write(obj.messages);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocalMessagesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
