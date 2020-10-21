import 'dart:convert';

import 'package:chat_app/UI/Messages.dart';
import 'package:chat_app/UI/select_private.dart';
import 'package:chat_app/UI/signin.dart';
import 'package:chat_app/models/messages.dart';
import 'package:chat_app/models/online_users.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;
class Chat extends StatelessWidget {
  final String id;

  const Chat({Key key, this.id}) : super(key: key);
  @override
@override
Widget build(BuildContext context) {
  Size size=MediaQuery.of(context).size;
  OnlineUsers onlineuser;
  return ChangeNotifierProvider(

    create: (context) => Messages(),
      child: Scaffold(
        appBar: AppBar(
          
        ),
        drawer: Drawer(
          child: Container(
            child: Column(
              children: [
                RaisedButton(
                  child: Text("Private chat"),
                  onPressed: (){
                    Navigator.pop(context);
                   
                }),
                  RaisedButton(
                  child: Text("Log out"),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Signin()));
                }),
           
              ],
            ),
        ),),
        body: ChatPage(id: id,),
    ),
  );
}

}
class ChatPage extends StatefulWidget {
  final String id;
  ChatPage({Key key, this.id}) : super(key: key);


  @override
  _MyChatPageState createState() => _MyChatPageState();
}






class _MyChatPageState extends State<ChatPage> with TickerProviderStateMixin {
IO.Socket socket;
bool _isEmpty=true;
TextEditingController messageText=new TextEditingController();
GlobalKey<AnimatedListState> animatedListKey=GlobalKey<AnimatedListState>();

AnimationController _controller;
bool _isAnimated=false;
AnimationController _recontroller;
    Animation<double> _animation;
 Future<String>  getName()async{
  SharedPreferences preferences=await SharedPreferences.getInstance();
  return preferences.getString("name");
}

void connectIO(){
  String name="";
  getName().then((value) => name=value);
  
 socket = IO.io('http://192.168.137.1:3000',<String, dynamic>{
    'transports': ['websocket'],
    'autoConnect': false,
    });
    socket.connect();

    socket.on('connect', (_) {
    
    });


    socket.on('event', (data) => print(data));
    socket.on('disconnect', (_) => print('disconnect'));
    socket.on('fromServer', (_) => print(_));
    socket.on("recievePrivateMessage", (data) => {
      recieveMessage(data)
    });
}

void sendMessage(String id,String messege){
socket.emit("SendPrivateMessage",{"id":id,"messege":messege});
}
void recieveMessage(data){
var body=json.decode(data);
  Messages messages=   Provider.of<Messages>(context,listen: false);
    messages.setmessage(body['messege'],body['id'] , false, DateTime.now().toString());
 animatedListKey.currentState.insertItem(messages.messages.length-1,duration: Duration(milliseconds: 180));
 
}

@override
void initState() { 
  
   /*_recontroller = AnimationController(
        duration: const Duration(seconds: 3),
        vsync: this,
      )..reverse();*/
  messageText.addListener(textFieldListener);
  connectIO();
  super.initState();
  
}
void animate(){
  _controller = AnimationController(
        duration: const Duration(milliseconds: 300),
        vsync: this,
      )..forward();
  if(!_isAnimated){
  
  
    _animation = Tween<double>(
        begin:0,
        end:1
      ).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInCubic,
      ));
      _isAnimated=true;
  }

}
void textFieldListener(){
  
     
  setState(() {
    messageText.text==""?{
      _isEmpty=true,
      _isAnimated=false,
    
   
    }:{
     
      _isEmpty=false,
       animate(),
    };
  });
  
}


@override
Widget build(BuildContext context) {
  Size size=MediaQuery.of(context).size;
  return  Scaffold(
   
          resizeToAvoidBottomInset: true,
          body: SingleChildScrollView(
                      child: Center(
        child: Container(
             color: Colors.black,
            height: size.height,
         child: Column(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               Container(
                  color: Colors.yellow,
                   height: size.height*0.90,
                   
                   child:MessagesField(animatedListKey: animatedListKey,)
                 ),
               Container(
                height: size.height*0.1,
                       child: Row(
                                                   children: [
                                                     Container(
                  
                   height: size.height*0.1,
                   width: size.width*0.85,
                   decoration: BoxDecoration(
                      color: Colors.blueGrey,
                     borderRadius: BorderRadius.circular(size.height/45)
                   ),
                   child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                     crossAxisAlignment: CrossAxisAlignment.center,
                     children: [
                       Container(
                         height: size.height*0.09,
                         width: size.width*0.85,
                         child:Center(
                           child: TextField(
               controller:messageText ,
                             style: TextStyle(fontSize: size.height/38,color: Colors.white),
                             maxLines: 5,
                             decoration: InputDecoration(
                focusedBorder: InputBorder.none
                             ),
                       ),
                         ),),
                    
                     ],
                   ),
                 ),
                 
                    
                       Container( 
                        height: size.height*0.1,
                       width: size.width*0.15,
                       decoration: BoxDecoration(
                         color: Colors.blue,
                          borderRadius: BorderRadius.circular(size.height/45)
                      

                       ),
                       child: !_isEmpty?FadeTransition(
               opacity: _animation,
                             child: IconButton(
                             splashColor: Colors.orange,
                         color: Colors.red,
                             icon: 
                           Icon(Icons.send,color: Colors.white,size: size.height/20,), onPressed: (){
                             //Send messages here
                      
                      Messages messages=   Provider.of<Messages>(context,listen: false);
                            if(messageText.text!=""){
                         DateTime now=DateTime.now();
                      messages.setmessage(messageText.text.toString(), "You", true, "${now.hour}:${now.minute}:${now.second}");
                      animatedListKey.currentState.insertItem(messages.messages.length-1,duration: Duration(milliseconds: 180));
                      sendMessage(widget.id, messageText.text.toString());
                           messageText.clear();
                           }}),
                       ):GestureDetector(
                         onTap: (){
                            Messages messages=   Provider.of<Messages>(context,listen: false);
                          
                         DateTime now=DateTime.now();
                      messages.setmessage("👍🏻", "You", true, "${now.hour}:${now.minute}:${now.second}");
                      animatedListKey.currentState.insertItem(messages.messages.length-1,duration: Duration(milliseconds: 180));
                      sendMessage(widget.id, "👍🏻");
                           messageText.clear();
                         },
               child: Center(child: Text("👍🏻",style: TextStyle(fontSize: size.height/30),))
                       )
                           ),
                    
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