
import 'dart:convert';

import 'package:chat_app/UI/contacts.dart';
import 'package:chat_app/constants.dart';
import 'package:chat_app/core/colors.dart';

import 'package:chat_app/models/chats.dart';
import 'package:chat_app/models/local_chat.dart';
import 'package:chat_app/models/local_message.dart';
import 'package:chat_app/models/local_messages.dart';
import 'package:chat_app/models/message.dart';
import 'package:chat_app/viewModels/socketConnet.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import 'chat_message_page.dart';
class ChatMain extends StatefulWidget{
  @override
  _ChatMainState createState() => _ChatMainState();
}

class _ChatMainState extends State<ChatMain> with SingleTickerProviderStateMixin {


 var box;
List<LocalMessage> messages=List<LocalMessage>();
 SocketConnect socketConnect=new SocketConnect();
void connectsocket(){
  SocketConnect.connect();
  onconnected();
}
void onconnected(){
  socketConnect.onConnected(userSelfId);
  
 
}
String userSelfId="";
String selfUsername="";

void getuserid()async{
  SharedPreferences prefs=await SharedPreferences.getInstance();
 userSelfId= prefs.getString("userid");
 selfUsername=prefs.getString("username");
connectsocket();
onPrivateMessage();
  //print(userid);
}

void onPrivateMessage()async{
SocketConnect.socket.on(on_Private_Message, (data)async{
/*
 "msg":data.msg,
  "userid":data.userid,
  "username":data.username
*/
var parsed=json.decode(data);
var body=parsed['data'];
print("message recieved");
print(parsed['data']);
var box =  Hive.box(chat_Box);
LocalChat chat=new LocalChat(id: "${body['userid']}",userName: "${body['username']}",);
bool isChat=box.containsKey("${body['userid']}");
   setState(() {
    LocalMessage message=new LocalMessage();
    message.isOwn=false;
    message.messagebody="${body['msg']}";
    message.sender="${body['username']}";
    message.time= DateTime.now().toString();
    message.isPhoto=false;
    messages.add(message);
    _savemessages( "${body['username']}",  "${body['userid']}", messages);
    messages.clear();
 //animatedListKey.currentState.insertItem(messages.length-1,duration: Duration(milliseconds: 180));*/
   });
 if(!isChat){
  await box.put("${body['userid']}", chat);
  print("chat created");
 
 }

 
 
 
});
}

void _savemessages(String username,String id,List<LocalMessage> messages)async{
 
 LocalMessages messagesmodel=new LocalMessages(messages: messages,id: id,userName: username);
 await box.put(id, messagesmodel);
}

/*void additem()async{
   number++;
   Message msg=new Message();
  msg.isOwn=true;
  msg.messagebody="Heyy how are you$number";
  msg.sender="you";
  msg.time="45:00";
  List<Message> msgg=new List<Message>();
  msgg.add(msg);
  msgg.add(msg);
  msgg.add(msg);

  var box = await Hive.openBox('testBox');
  ChatModelHive chat=new ChatModelHive(id: "dfdf0",username: "Sdfsdf0",messages: msgg);
 

 await box.put("key6", chat);
 

}*/
@override
void initState() { 
  
  super.initState();
  getuserid();

} 




  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: ()async{
       var    box =  Hive.box(chat_Box);
        await  box.clear();
        Navigator.push(context, MaterialPageRoute(builder: (context)=>MyApp()));
        return;

      },
          child: Scaffold(
        drawer: Drawer(

        ),
       
       body: Center(
          child: Container(
            width: size.width,
            height: size.height,
            child: Stack(
              children: [
                  Positioned(
                  top: 0,
                  right: 0,
                  child: Container(
                  height: size.height/5,
                  width: size.width,
                  child: Center(
                    child: Container(
                      margin: EdgeInsets.only(left: size.width/20),
                      child: Row(
                        
                        children: [
                          Text("Chats",style: TextStyle(fontSize: size.height/35,color: Colors.white)),
                        ],
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                  color: Colors.blue,
                  ///borderRadius: BorderRadius.only(bottomLeft: Radius.circular(300)),
                  ),
                ),
                ),
                Container(
                    height: size.height/1.15,
                    width: size.width,
                    margin: EdgeInsets.only(top: size.height/7),
                    decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(40)),
                  ),
                
                  child: ValueListenableBuilder(
                     valueListenable: Hive.box(chat_Box).listenable(),
                       builder: (context, box, widget) {
                       return 
                       Container(
                        height: size.height/1.5,
                        width: size.width,
                        margin: EdgeInsets.only(top: size.height/26),
                     child: box.keys.toList().length==0?
                    Center(child: Text("Press + button to start chatting",style: TextStyle(fontSize: size.height/45),),):
                      ListView.builder(
                        padding: EdgeInsets.zero,
                       itemCount:box.keys.toList().length,
                       itemBuilder: (context, index) {
                      final key=box.keys.toList()[index];
                       final value=box.get(key)  as LocalChat;
                          
                         return

                          Center(
                            child: Column(
                              children: [
                               index==0?SizedBox(): Divider(
                                  thickness: 1,
                                  color: Colors.black,
                                ),
                                Container(
                                  
                                  height: size.height/10,
                                  width: size.width/1.1,
                                  child: ListTile(
                                    leading: Icon(Icons.account_circle,size: size.height/15,),
                                    title: Text("${value.userName}",style: TextStyle(fontSize: size.height/45),),
                                    subtitle: Text("Last message"),
                                    trailing: Text("time"),
                                  ),
                                 /* child: Row(
                                    children: [
                                      Container(
                                        child: Icon(Icons.account_circle,size: size.height/15,),
                                      )
                                    ],
                                  ),*/
                                
                                 
                                ),
                              ],
                            ),
                          );
                         
                         
                          /*GestureDetector(
                           onTap: (){
                             
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)
                                    =>ChatMessagePage(
                                    username:value.userName,
                                    id: value.id,
                                    onlineStatus:"Online",
                                    selfid: userSelfId,
                                    selfname: selfUsername,
                                    ))); 
                                    //navigate to chatmessage page then in there save every single message inside message header and 
                                    //load messages when navigation happens to that page with hive open box and key is users id that 
                                    //that is unique 
                               
                                  
                           },
                          child: Container(
                            margin: EdgeInsets.all(size.height/80),
                             padding: EdgeInsets.all(size.height/20),
                             color: Colors.blueAccent,
                             child: Text("${value.userName}",style: TextStyle(color: Colors.white,fontSize: size.height/40),),
                           ),
                         );*/
                       },
                      ));
                            
                     


                       }),
                ),
              
               
              ],
            ),
          ),
       ),
  floatingActionButton: FloatingActionButton(
    child: Icon(Icons.add),
    onPressed: (){
  
      //TO contacts page 
   Navigator.push(context, MaterialPageRoute(builder: (context)=>Contacts()));
  }),
      ),
    );
  }


}