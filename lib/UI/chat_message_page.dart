import 'package:chat_app/UI/messages.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/core/colors.dart';
import 'package:chat_app/core/enums.dart';
import 'package:chat_app/models/local_message.dart';
import 'package:chat_app/models/local_messages.dart';

import 'package:chat_app/models/message.dart';
import 'package:chat_app/viewModels/socketConnet.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'dart:convert';


import 'package:chat_app/UI/select_private.dart';

import 'package:chat_app/models/messages.dart';
import 'package:chat_app/models/online_users.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
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
List<LocalMessage> messages=List<LocalMessage>();
var box;
//ChatModelHive chatModelHive;
SocketConnect socketConnect=new SocketConnect();
@override
  void initState() {
   initbox();
    // TODO: implement initState
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  onprivateMessage();
  // _getMessages();
  }
void initbox()async{
       box = await Hive.box(messages_Box);
}


void sendMessage(String msg){
  ///on    msg
  print(msg);
  
 socketConnect.sendMessage(widget.id,msg,widget.selfid,widget.selfname);

}
void onprivateMessage(){
SocketConnect.socket.on(on_Private_Message, (data){
/*
 "msg":data.msg,
  "userid":data.userid,
  "username":data.username
*/
var parsed=json.decode(data);
var body=parsed['data'];
print("message recieved");
print(parsed['data']);
   setState(() {
      LocalMessage message=new LocalMessage();
    message.isOwn=false;
    message.messagebody="${body['msg']}";
    message.sender="${body['username']}";
    message.time= DateTime.now().toString();
    message.isPhoto=false;
   messages.add(message);
 //animatedListKey.currentState.insertItem(messages.length-1,duration: Duration(milliseconds: 180));
   });
 
   
});

}
void _savemessages(String username,String id,List<LocalMessage> messages)async{
  ///first addall then putvar box = await Hive.openBox('testBox');
      

   


 LocalMessages messagesmodel=new LocalMessages(messages: messages,id: id,userName: username);
 await box.put(id, messagesmodel).then((value){
   Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatMain()));
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
   _savemessages(widget.username, widget.id, messages);
      
       return;
     },
        child: Scaffold(
      
       backgroundColor: ColorsPallete.colorc,
       body: SingleChildScrollView(
                child: Center(

           child: Container(
             child: Stack(
               
               children: [
                     Container(
                   width: size.width,
                   height: size.height/4,
                   color: ColorsPallete.colora,
                   child:Row(

                   mainAxisAlignment: MainAxisAlignment.start,
                  
                     children: [
                      IconButton(icon: Icon(Icons.arrow_back,color: Colors.white,), onPressed: (){
                       _savemessages(widget.username, widget.id, messages);
                      }),
                     Container(
                       margin: EdgeInsets.only(left: size.width/3),
                       height: size.height/6,
                       child: Column(
                        
                         children: [
                           Container(
                             width: 55,
                             height: 55,
                             decoration: BoxDecoration(
                               color: Colors.white,
                               borderRadius: BorderRadius.circular(40)
                             ),
                             child: Center(child: Text("${widget.username[0]}",style:TextStyle(fontSize: size.height/30))),
                           ),
                         

                         ],
                       ),

                     ),  Text("${widget.username}",style:TextStyle(color: Colors.white,fontSize: size.height/45) ,)
                     ],
                   )
                 ),
                 Column(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                 
                       ClipRRect(
                        
                            child: Container(
                            decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(40)),
                                boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(0.0, 1.0), //(x,y)
                                blurRadius: 6.0,
                              ),
                            ],
                          ),
                             margin: EdgeInsets.only(top: size.height/7),
                             height: size.height*0.73,
                             
                             child:
                          
                             MessagesField(animatedListKey: animatedListKey,id: widget.id,username: widget.username,messages: messages,)
                            
                           ),
                       ),
                     Container(
                       color: ColorsPallete.colora,
                       width: size.width,
                       height: size.height/7.9,
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
                            
                               if(messageText.text!=""){
                                 setState(() {
                                   LocalMessage message=new LocalMessage();
                                  message.isOwn=true;
                                  message.messagebody=messageText.text.toString();
                                  message.sender="You";
                                  message.time= DateTime.now().toString();
                                  message.isPhoto=false;
                                  messages.add(message);
                                  //  animatedListKey.currentState.insertItem(messages.length-1,duration: Duration(milliseconds: 180));
                             
                                 });
                                  
                            
                             // sendMessage(widget.id, messageText.text.toString());
                                   messageText.clear();
                                   }}),)
                             //  controller.clear();
                            
                         ],
                       ),
                     )
                   ],
          
                 ),
               ],
             ),
           ),
         ),
       ),
     ),
   );
  }
}