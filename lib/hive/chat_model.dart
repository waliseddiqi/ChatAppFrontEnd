import 'package:chat_app/models/message.dart';
import 'package:hive/hive.dart';
part 'chat_model.g.dart';

  @HiveType(typeId: 0)
class ChatModelHive{
@HiveField(0)
final String username;
@HiveField(1)
final String id;

@HiveField(2)
final List<Message> messages;

  ChatModelHive( {this.messages,this.username, this.id});

}