import 'package:chat_app/models/messages.dart';
import 'package:flutter/material.dart';

import 'message.dart';

class Chat extends ChangeNotifier{

final String id;
String lastmessage;
String time;


List<Message> messages=[];


  Chat(this.id);



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