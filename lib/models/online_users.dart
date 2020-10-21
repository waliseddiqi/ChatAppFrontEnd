import 'package:chat_app/models/user.dart';
import 'package:flutter/cupertino.dart';

class OnlineUsers extends ChangeNotifier{



List<User> onlineUsers=[];


void setUsers(String name,String id,bool isOnline){

User user=new User();

user.id=id;
user.name=name;
user.isOnline=isOnline;

onlineUsers.add(user);
notifyListeners();


}

get getOnlineUsers{
  return onlineUsers;
}



}