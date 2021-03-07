import 'dart:convert';

//import 'package:chat_app/hive/chat_model.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/models/local_chat.dart';
import 'package:chat_app/models/message.dart';
import 'package:chat_app/models/onlineUsers.dart';
import 'package:chat_app/viewModels/socketConnet.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api.dart';
import 'chat_main.dart';
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
void _createChat(String username,String id)async{
   var box = await Hive.box(chat_Box);
  LocalChat chat=new LocalChat(id: id,userName: username);
 

 await box.put(id, chat).then((value){
   Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatMain()));
 });
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
   return
        Stack(
          children: [
                 Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                 height: size.height/5,
                  width: size.width,
                  child: Center(
                    child: Container(
                      margin: EdgeInsets.only(top: size.height/45),
                      child: Center(child: Text("Contacts",style: TextStyle(fontSize: size.height/35,color: Colors.white))),
                    ),
                  ),
                  decoration: BoxDecoration(
                  color: Colors.green[400],
                  ///borderRadius: BorderRadius.only(bottomLeft: Radius.circular(300)),
                  ),
                ),
                ),
            Container(
               margin: EdgeInsets.only(top: size.height/20),
               height: size.height/1.15,
              width: size.width,
               color: Colors.white,
              child: ListView.builder(
              
                itemCount: users.length,
                itemBuilder: (context,index){
                  return 
                  
                  users[index].userid==userid?SizedBox():Container(
                    child: GestureDetector(
                      onTap: (){
                       
                                    //to create chat inside chats 
                                   _createChat(users[index].username,users[index].userid);

                      },
                                    child:
                         Center(
                           child: Container(
                              height: size.height/10,
                              width: size.width/1.1,
                        margin: EdgeInsets.only(top: size.height/35),
                        child: ListTile(
                            title: Text(users[index].username,style: TextStyle(fontWeight: FontWeight.w600),),
                            //tileColor: Colors.white,
                           
                            trailing: Text(users[index].onlineStatus?"Online":"Offline"),
                        ),
                      ),
                         ),
                    ),
                  );
              })
            
      
    ),
          ],
        );
  }
}