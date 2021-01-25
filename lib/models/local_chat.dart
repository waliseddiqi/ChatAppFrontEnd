
import 'package:hive/hive.dart';
part 'local_chat.g.dart';
@HiveType(typeId: 0)
class LocalChat{
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String userName;

  LocalChat({this.id, this.userName});


}