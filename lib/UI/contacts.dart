import 'dart:convert';

import 'package:chat_app/models/onlineUsers.dart';
import 'package:chat_app/viewModels/socketConnet.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api.dart';
import 'chat_message_page.dart';

class Contacts extends StatefulWidget{
  @override
  _ContactsState createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
API api=new API();
SocketConnect socketConnect=new SocketConnect();
List<OnlineUser> users=[];
/* 
 final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
      return parsed
          .map<PlayerActiveSurvey>(
              (json) => new PlayerActiveSurvey.fromJson(json))
          .toList();


*/
String userid="";
String username="";
@override
  void initState() {
   getUsers();
    super.initState();
    getuserid();
   
     
    
  }

  void connectsocket(){
  SocketConnect.connect();
  onconnected();
}
void onconnected(){
  socketConnect.onConnected(userid);
  
 
}
void getuserid()async{
  SharedPreferences prefs=await SharedPreferences.getInstance();
 userid= prefs.getString("userid");
 username=prefs.getString("username");
  print(userid);
  setState(() {
    this.userid=userid;
  });
   connectsocket();
  //print(userid);
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
              return 
              
              users[index].userid==userid?Container(color: Colors.red,
              child: Text("Yourself"),
              height: size.height/8
              ):Container(
                child: GestureDetector(
                  onTap: (){
                     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)
                                =>ChatMessagePage(username: users[index].username,
                                id: users[index].userid,
                                onlineStatus:"Online",
                                selfid: userid,
                                selfname: username,
                                ))); 
                  },
                                child:
                     Container(
                    margin: EdgeInsets.only(top: size.height/35),
                    child: ListTile(
                      title: Text(users[index].username,style: TextStyle(fontWeight: FontWeight.w600),),
                      tileColor: Colors.green,
                      subtitle: Text("BirthDay: "+users[index].userid),
                      trailing: Text(users[index].onlineStatus?"Online":"Offline"),
                    ),
                  ),
                ),
              );
          })
        ),
      ),
    );
  }
}