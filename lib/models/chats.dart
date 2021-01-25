import 'package:flutter/material.dart';

import 'chat.dart';
import 'message.dart';
import 'package:hive/hive.dart';
class Chats extends ChangeNotifier{

  Set<Chat> chats;

  void setchat(String id,String lastMessage,List<Message> messages,String time){
    Chat chat=new Chat(id);
    
    chat.lastmessage=lastMessage;
    chat.messages=messages;
    chat.time=time;
    chats.add(chat);
    notifyListeners();
  }
  
  get chat{
    return chats;
  }
}