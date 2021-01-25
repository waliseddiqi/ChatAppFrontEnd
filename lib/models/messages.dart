import 'package:chat_app/core/enums.dart';
import 'package:flutter/cupertino.dart';

import 'message.dart';

class Messages extends ChangeNotifier{
  static String id;
  List<Message> messages=List<Message>();
  PresentState _presentState=PresentState.Idle;

    PresentState get state => _presentState;

  void setmessage(String body,String sender,bool isOwn,String time){
    Message message=new Message();
    message.isOwn=isOwn;
    message.sender=sender;
    message.messagebody=body;
    message.time=time;
    messages.add(message);
 
    notifyListeners();
  }

  void addmessages(List<Message> messages){
   // print(messages[0].messagebody+"isown");
 Message message=new Message();
    message.isOwn=false;
    message.sender="you";
    message.messagebody="hyeeye";
    message.time="Dsdf";
    messages.add(message);
   // messages.add(messages[0]);
    
    notifyListeners();
    
  }
  
  get message{
    return messages;
  }
}