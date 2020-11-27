// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ChatModelHiveAdapter extends TypeAdapter<ChatModelHive> {
  @override
  final int typeId = 0;

  @override
  ChatModelHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChatModelHive(
    username:  fields[0] as String,
    id:  fields[1] as String,
    messages: fields[2] as List<Message>
    );
  }

  @override
  void write(BinaryWriter writer, ChatModelHive obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.username)
      ..writeByte(1)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChatModelHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
