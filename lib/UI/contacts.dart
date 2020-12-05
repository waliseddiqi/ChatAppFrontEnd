import 'dart:convert';

import 'package:chat_app/models/onlineUsers.dart';
import 'package:flutter/material.dart';

import '../api.dart';

class Contacts extends StatefulWidget{
  @override
  _ContactsState createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
API api=new API();
List<OnlineUser> users=[];
/* 
 final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed
          .map<PlayerActiveSurvey>(
              (json) => new PlayerActiveSurvey.fromJson(json))
          .toList();


*/
@override
  void initState() {
   getUsers();
    super.initState();
  }
void getUsers()async{
var response=await api.getUsers();
if(response.statusCode==200){
var parsed=json.decode(response.body).cast<Map<String, dynamic>>();
setState(() {
  users=parsed.map<OnlineUser>(
              (json) => new OnlineUser.fromJson(json))
          .toList();
});
}


}

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
   return Scaffold(
      body: Center(
        child: Container(
          width: size.width,
          height: size.height,
          
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: users.length,
            itemBuilder: (context,index){
              return Container(
                margin: EdgeInsets.only(top: size.height/35),
                child: ListTile(
                  title: Text(users[index].username,style: TextStyle(fontWeight: FontWeight.w600),),
                  tileColor: Colors.green,
                  subtitle: Text("BirthDay: "+users[index].age),
                  trailing: Text(users[index].onlineStatus?"Online":"Offline"),
                ),
              );
          })
        ),
      ),
    );
  }
}