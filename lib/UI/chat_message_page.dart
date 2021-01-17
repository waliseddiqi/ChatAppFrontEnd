import 'package:chat_app/UI/messages.dart';
import 'package:chat_app/core/colors.dart';
import 'package:chat_app/viewModels/socketConnet.dart';
import 'package:flutter/material.dart';

import 'dart:convert';


import 'package:chat_app/UI/select_private.dart';

import 'package:chat_app/models/messages.dart';
import 'package:chat_app/models/online_users.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'chat_main.dart';
class ChatMessagePage extends StatelessWidget {
  final String id;
  final String username;
  final String onlineStatus;
  final String selfid;
  final String selfname;
  const ChatMessagePage({Key key, this.id, this.username, this.onlineStatus, this.selfid, this.selfname}) : super(key: key);





  @override
Widget build(BuildContext context) {
  Size size=MediaQuery.of(context).size;
  OnlineUsers onlineuser;
  return ChangeNotifierProvider(
    create: (context) => Messages(),
      child: Scaffold(
        body: ChatMessagePagetab(username: username,
        onlineStatus: onlineStatus,
        selfid: selfid,
        selfname: selfname,
        id: id,
        
        
        ),
  ),
  );
}}
class ChatMessagePagetab extends StatefulWidget{
  @override
    final String id;
  final String username;
  final String onlineStatus;
  final String selfid;
  final String selfname;


  const ChatMessagePagetab({Key key, this.username, this.onlineStatus, this.id, this.selfid, this.selfname}) : super(key: key);
  _ChatMessagePageState createState() => _ChatMessagePageState();
}

class _ChatMessagePageState extends State<ChatMessagePagetab> with WidgetsBindingObserver{

  GlobalKey<AnimatedListState> animatedListKey=GlobalKey<AnimatedListState>();
//SendPrivateMessage



SocketConnect socketConnect=new SocketConnect();
@override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  onprivateMessage();
    //getuserid();
  }


void sendMessage(String msg){
  ///on    msg
  print(msg);
  
 socketConnect.sendMessage(widget.id,msg,widget.selfid,widget.selfname);

}
void onprivateMessage(){
SocketConnect.socket.on("pmsg", (data){
/*
 "msg":data.msg,
  "userid":data.userid,
  "username":data.username
*/
var parsed=json.decode(data);
var body=parsed['data'];
print("message recieved");
print(parsed['data']);
   Messages messages=   Provider.of<Messages>(context,listen: false);
 

    messages.setmessage("${body['msg']}", "${body['username']}" , false, DateTime.now().toString());
 animatedListKey.currentState.insertItem(messages.messages.length-1,duration: Duration(milliseconds: 180));
});

}
void onDisconnected(){
  socketConnect.onDisConnected(widget.selfid);
}

@override
void dispose() { 
  WidgetsBinding.instance.removeObserver(this);
  super.dispose();
}
/*@override
void didChangeAppLifecycleState(AppLifecycleState state){
  if(state==AppLifecycleState.paused){
    print("disconnected");
    onDisconnected();
  }
  if(state==AppLifecycleState.resumed){
    onconnected();
    print("connected");
  }
}*/

TextEditingController messageText=new TextEditingController();
  @override
  Widget build(BuildContext context) {

   Size size=MediaQuery.of(context).size;
   return WillPopScope(
     onWillPop: (){
       Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatMain()));
       return;
     },
        child: Scaffold(
      
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
                       margin: EdgeInsets.all(size.height/50),
                       color: Colors.greenAccent,
                      child: Center(child: Text("${widget.username[0]}",style: TextStyle(
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
                    color: Colors.white,
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
                             controller:messageText ,
                             style: TextStyle(fontSize: size.height/40,color: Colors.white),
                              decoration: InputDecoration(
                                border: InputBorder.none
                              ),
                           ),
                         ),
                       ),
                       Container(
                      
                       child: IconButton(icon: Icon(Icons.send),onPressed: (){
                        // onconnected();
                        sendMessage(messageText.text.toString());
                        Messages messages=   Provider.of<Messages>(context,listen: false);
                         if(messageText.text!=""){
                           DateTime now=DateTime.now();
                        messages.setmessage(messageText.text.toString(), "You", true, "${now.hour}:${now.minute}:${now.second}");
                        animatedListKey.currentState.insertItem(messages.messages.length-1,duration: Duration(milliseconds: 180));
                       // sendMessage(widget.id, messageText.text.toString());
                             messageText.clear();
                             }}),)
                       //  controller.clear();
                      
                   ],
                 ),
               )
             ],
        
           ),
         ),
       ),
     ),
   );
  }
}