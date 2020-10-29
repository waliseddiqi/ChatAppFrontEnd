import 'dart:convert';

import 'package:chat_app/models/onlineUsers.dart';
import 'package:flutter/material.dart';

import '../api.dart';

class ChatMainPage extends StatefulWidget{

  @override
  _ChatMainPageState createState() => _ChatMainPageState();
}

class _ChatMainPageState extends State<ChatMainPage> {


List<OnlineUser> list=new List<OnlineUser>();
API api=new API();


  void getUsers()async{
     
   await api.getUsers().then((res) => {
  setState(() {
       list= (json.decode(res.body) as List).map((i) =>
              OnlineUser.fromJson(i)).toList();
      //_isfirst=List.generate(list.length, (index) => true);
      
    }),
    });
   
  }
  @override
  void initState() {
    getUsers();
        super.initState();
  }





  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            title: Text("Messages")
            ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
              title: Text("Settings")
            ),
            
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
              title: Text("Account")
            
            )
      ]),
        body: Center(
          child: Container(
            child: 
            list.length==0?Center(child: CircularProgressIndicator(),):
            ListView.builder(
              itemCount: list.length??0,
              itemBuilder: (_,index)=>
            Container(
              margin: EdgeInsets.all(size.height/55),
              height: size.height/9,
              decoration: BoxDecoration(
                  color: Colors.blue,
                borderRadius: BorderRadius.circular(size.height/35)),
                child: Center(child: ListTile(
                  title: Text("${list[index].username}"),
                  subtitle: Text("age: ${list[index].age}",style: TextStyle(color: Colors.white),),
                  trailing: Text("gender: ${list[index].gender}")
                )),
            )
            
            ),
          ),
        ),
    );
  }
}