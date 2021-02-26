import 'package:hive/hive.dart';
part 'local_users.g.dart';
@HiveType(typeId: 1)
class LocalUsers{
 @HiveField(0)
  String userName;
 @HiveField(1)
  String userId;
 @HiveField(2)
  String notificationId;

  
  LocalUsers({this.userName, this.userId, this.notificationId,});
  
}