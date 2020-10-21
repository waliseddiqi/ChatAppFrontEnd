import 'package:flutter/cupertino.dart';

import 'message.dart';

class Messages extends ChangeNotifier{
  static String id;
  List<Message> messages=[];


  void setmessage(String body,String sender,bool isOwn,String time){
    Message message=new Message();
    message.isOwn=isOwn;
    message.sender=sender;
    message.messagebody=body;
    message.time=time;
    messages.add(message);
 
    notifyListeners();
  }
  
  get message{
    return messages;
  }
}