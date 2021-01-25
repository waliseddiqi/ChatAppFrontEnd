// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_message.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocalMessageAdapter extends TypeAdapter<LocalMessage> {
  @override
  final int typeId = 1;

  @override
  LocalMessage read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocalMessage(
      messagebody:fields[0] as String,
      sender:fields[1] as String,
      time:fields[2] as String,
      isOwn:fields[3] as bool,
      isPhoto:fields[4] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, LocalMessage obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.messagebody)
      ..writeByte(1)
      ..write(obj.sender)
      ..writeByte(2)
      ..write(obj.time)
      ..writeByte(3)
      ..write(obj.isOwn)
      ..writeByte(4)
      ..write(obj.isPhoto);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocalMessageAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
