import 'dart:async';
import 'dart:convert';
import 'package:chat_app/UI/signin.dart';
import 'package:chat_app/models/messages.dart';
import 'package:chat_app/models/onlineUsers.dart';
import 'package:chat_app/models/online_users.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../api.dart';
import 'chat_page.dart';

class SelectPrivate extends StatefulWidget {
  final OnlineUsers onlineUsers;
  SelectPrivate({Key key, this.onlineUsers}) : super(key: key);


  @override
  _SelectPrivateState createState() => _SelectPrivateState();
}

class _SelectPrivateState extends State<SelectPrivate> {
List<OnlineUser> list=new List<OnlineUser>();
API api=new API();
List<bool> _isfirst;
IO.Socket socket;
String id="";
String name="";
@override
  void initState() {
    print("inittt");
  //  connectIO();
    getUsers();
    super.initState();
    getName();
  }

   void getUsers()async{
     
   await api.getUsers().then((res) => {
  setState(() {
       list= (json.decode(res.body) as List).map((i) =>
              OnlineUser.fromJson(i)).toList();
      _isfirst=List.generate(list.length, (index) => true);
      
    }),
    });
   
  }

void  getName()async{
  SharedPreferences preferences=await SharedPreferences.getInstance();
  print("heyy"+preferences.getString("ID"));
 
}

/*void connectIO(){

setState(() {
   getName().then((value) => name=value);
});
 
 
  
 socket = IO.io('http://192.168.137.1:3000',<String, dynamic>{
    'transports': ['websocket'],
    'autoConnect': false,
    });
    socket.connect();

    socket.on('connect', (_) {
      print("connectedsss");
     socket.emit('userSignup', name);
    });
    socket.on("ID", (data){
     
      var body=json.decode(data);
      id=body['id'];
    
    });
    /*socket.on("userconnected", (data) {
     var body=json.decode(data);
     OnlineUsers onlineUsers=Provider.of<OnlineUsers>(context,listen: false);
      onlineUsers.setUsers(body['name'], body['id'], true);
      print("Helllooo");
     });*/
}*/
void disconnectUser(String username,String id)async{
 await api.disconnectUser(username, id).then((value) => {
   if(value.statusCode==200){
   Navigator.push(context, MaterialPageRoute(builder: (context)=>Signin())),
   }else{
     print(value.body)
   }
 });

}

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: (){
       
        disconnectUser(name, id);
      },
          child: Scaffold(

        body: Center(
            child:RefreshIndicator(
              onRefresh: ()async{
                
                getUsers();
              },
                        child: ListView.builder(
                physics: AlwaysScrollableScrollPhysics(),
                itemCount:list.length==0?1:list.length,
                itemBuilder: (_,index)=>
                list.length==0?Center(child: Text("NO users Online"),):GestureDetector(
                  onTap: (){
                   
                    setState(() {
                      _isfirst[index]=!_isfirst[index];
                    });
                    
                  },
                              child: AnimatedCrossFade(
                    
                    firstChild:Container(
                    margin: EdgeInsets.only(bottom: size.height/32),
                    width: size.width,
                    height: size.height/8,
                    color: Colors.blueAccent,
                  child: Center(child: Text("${list[index].username}",style: TextStyle(fontSize: size.height/45,color: Colors.white),)),
              ),
              secondChild: Container(
                 margin: EdgeInsets.only(bottom: size.height/32),
                    width: size.width,
                    height: size.height/8,
                    color: Colors.redAccent,
                    child: Center(child: IconButton(icon: Icon(Icons.send,size: size.height/38,color: Colors.white,),
                    onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Chat(id: list[index].id,)));
                    },
                    ),),
              ),
              duration: Duration(milliseconds: 400),
              
              crossFadeState:_isfirst[index]?CrossFadeState.showFirst:CrossFadeState.showSecond,
                              ),
                )),
            ),
        ),
      ),
    ) ;
  }
}