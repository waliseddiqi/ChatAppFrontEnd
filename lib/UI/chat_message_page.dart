import 'package:chat_app/UI/messages.dart';
import 'package:chat_app/core/colors.dart';
import 'package:flutter/material.dart';

import 'dart:convert';


import 'package:chat_app/UI/select_private.dart';

import 'package:chat_app/models/messages.dart';
import 'package:chat_app/models/online_users.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;
class ChatMessagePage extends StatelessWidget {
  final String id;
  final String username;
  final String onlineStatus;
  const ChatMessagePage({Key key, this.id, this.username, this.onlineStatus}) : super(key: key);





  @override
Widget build(BuildContext context) {
  Size size=MediaQuery.of(context).size;
  OnlineUsers onlineuser;
  return ChangeNotifierProvider(
    create: (context) => Messages(),
      child: Scaffold(
        body: ChatMessagePagetab(),
  ),
  );
}}
class ChatMessagePagetab extends StatefulWidget{
  @override
  final String username;
  final String onlineStatus;

  const ChatMessagePagetab({Key key, this.username, this.onlineStatus}) : super(key: key);
  _ChatMessagePageState createState() => _ChatMessagePageState();
}

class _ChatMessagePageState extends State<ChatMessagePagetab> {

  GlobalKey<AnimatedListState> animatedListKey=GlobalKey<AnimatedListState>();
//SendPrivateMessage



@override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

void sendMessage(){
  
}
  @override
  Widget build(BuildContext context) {
   Size size=MediaQuery.of(context).size;
   return Scaffold(
    
     backgroundColor: ColorsPallete.colorc,
     body: Center(

       child: Container(
         child: Column(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
             Container(
               width: size.width,
               height: size.height/8,
               color: ColorsPallete.colora,
               child:Row(
                 crossAxisAlignment: CrossAxisAlignment.center,
                 children: [
                   Container(
                     width: 55,
                     height: 55,
                     color: Colors.yellow,
                    child: Center(child: Text("${widget.username}",style: TextStyle(
                      fontSize: size.height/35)),
                   )),
                   Container(
                     margin: EdgeInsets.only(top:size.height/24,left: size.width/15),
                     child: Column(
                       children: [
                         Text("${widget.username}",style: TextStyle(
                           fontSize: size.height/45,fontWeight: FontWeight.w500,color: Colors.white),),
                         Text("${widget.onlineStatus}",style: TextStyle(fontSize: size.height/55,color: Colors.white))
                       ],
                     ),
                   )
                 ],
               )
             ),
               Container(
                  color: Colors.yellow,
                   height: size.height*0.75,
                   
                   child:MessagesField(animatedListKey: animatedListKey,)
                 ),
             Container(
               color: ColorsPallete.colora,
               width: size.width,
               height: size.height/8,
               child: Row(
                 children: [
                   Container(
                     margin: EdgeInsets.all(size.height/50),
                     child: Icon(Icons.attach_file)),
                     Container(
                     margin: EdgeInsets.all(size.height/250),
                     child: Icon(Icons.tag_faces)),
                     Container(
                       decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)
                        ),
                       ),
                       width: size.width/1.7,
                       height: size.height/9,
                          margin: EdgeInsets.all(size.height/70),
                       child: Center(
                         child: TextFormField(
                           style: TextStyle(fontSize: size.height/40,color: Colors.white),
                            decoration: InputDecoration(
                              border: InputBorder.none
                            ),
                         ),
                       ),
                     ),
                     Container(
                    
                     child: IconButton(icon: Icon(Icons.send),onPressed: (){
                       print("Message send");
                     },)),
                 ],
               ),
             )
           ],
      
         ),
       ),
     ),
   );
  }
}