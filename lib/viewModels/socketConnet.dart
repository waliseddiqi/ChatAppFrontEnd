import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'dart:async';
import 'dart:convert';

class SocketConnect{
static IO.Socket socket;
static void connect(){
  
 socket = IO.io('http://192.168.137.1:3000',<String, dynamic>{
    'transports': ['websocket'],
    'autoConnect': false,
    });
    socket.connect();
print("connected");
}

void emitUserSignup(String name,String age,String gender){
     String id="";
      print("connectedsss");
     socket.emit('userSignup', {"name":name,"age":age,"gender":gender});
   
    print("User name created");
     socket.on("ID", (data)async{

      var body=json.decode(data);
      id=body['id'];
       SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
     sharedPreferences.setString("ID", id);
    });
    
}





}