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
    
}

/*void emitUserSignup(String name,String age){
     String id="";
      print("connectedsss");
     socket.emit('userSignup', {"name":name,"age":age});
   
    print("User name created");
     socket.on("ID", (data)async{

      var body=json.decode(data);
      id=body['id'];
       SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
     sharedPreferences.setString("ID", id);
    });
    
}*/

void onConnected(String userid){
  socket.emit("connected",{"userid":userid});
 
}
void sendMessage(String touserid,String msg,String userid,String username){
socket.emit("msg",{"touserid":touserid,"msg":msg,"userid":userid,"username":username});
socket.id="dsfsdfsdf";
print(socket.id.toString()+"iddddd");
}
void onDisConnected(String userid){
  socket.emit("disconnected",{"userid":userid});
 
}

}