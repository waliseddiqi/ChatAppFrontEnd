
import 'package:hive/hive.dart';
import 'local_message.dart';
part 'local_messages.g.dart';
@HiveType(typeId: 2)
class LocalMessages{
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String userName;
  @HiveField(2)
 List<LocalMessage> messages=List<LocalMessage>();
  LocalMessages({this.id, this.userName, this.messages});


}