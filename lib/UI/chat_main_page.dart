import 'dart:convert';

import 'package:chat_app/UI/chat_message_page.dart';
import 'package:chat_app/core/colors.dart';
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
      backgroundColor:ColorsPallete.colorg,
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
            margin: EdgeInsets.only(top: size.height/45),
            child: 
            list.length==0?Center(child: CircularProgressIndicator(),):
            RefreshIndicator(
              onRefresh: (){
              
              setState(() {
                getUsers();
              });  
                
              },
                          child: ListView.builder(
              
                itemCount: list.length??0,
                itemBuilder: (_,index)=>
              GestureDetector(
                onTap: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)
                  =>ChatMessagePage(username: list[index].username,onlineStatus:list[index].onlineStatus?"Online":"Offline",)));              },
                            child: Container(
                  margin: EdgeInsets.all(size.height/400),
                  height: size.height/9,
                   decoration: BoxDecoration(
                      color: ColorsPallete.colorc,
                       borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)
                        ),
                      
                   ),
                    child: Center(child: Row(
                 
                      children: [
                             AspectRatio(
                               aspectRatio: 1,
                                child: Container(
                                  margin: EdgeInsets.all(size.height/150),
                                 decoration: BoxDecoration(
                                   color: ColorsPallete.colore,
                                   borderRadius: BorderRadius.circular(size.height/10)
                                 ),
                                 child: Center(child: Text("${list[index].username[0]}",style: TextStyle(fontSize: size.height/35),),),
                               ),
                             ),
                        Container(
                          width: size.width/1.4,
                          
                          child: ListTile(
                            title: Text("${list[index].username}",style: TextStyle(fontSize: size.height/40,fontWeight: FontWeight.w500,color: Colors.black),),
                          
                          ),
                        ),
                      ],
                    )),
                ),
              )
              
              ),
            ),
          ),
        ),
    );
  }
}