import 'package:hive/hive.dart';
part 'local_message.g.dart';
@HiveType(typeId: 1)
class LocalMessage{
 @HiveField(0)
  String messagebody;
 @HiveField(1)
  String sender;
 @HiveField(2)
  String time;
 @HiveField(3)
  bool isOwn;
 @HiveField(4)
  bool isPhoto;
  
  LocalMessage({this.messagebody, this.sender, this.time, this.isOwn, this.isPhoto});
  
}