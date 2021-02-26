// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_users.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocalUsersAdapter extends TypeAdapter<LocalUsers> {
  @override
  final int typeId = 1;

  @override
  LocalUsers read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocalUsers(
      userName: fields[0] as String,
      userId: fields[1] as String,
      notificationId: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, LocalUsers obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.userName)
      ..writeByte(1)
      ..write(obj.userId)
      ..writeByte(2)
      ..write(obj.notificationId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocalUsersAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
