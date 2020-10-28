import 'package:chat_app/UI/chat_page.dart';
import 'package:chat_app/UI/main_page.dart';
import 'package:chat_app/UI/select_private.dart';
import 'package:chat_app/viewModels/socketConnet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:chat_app/api.dart';
class Signin extends StatefulWidget {
  Signin({Key key}) : super(key: key);


  @override
  _MySigninState createState() => _MySigninState();
}


class _MySigninState extends State<Signin> {
SocketConnect socketConnect;
void connectSocket(){
  SocketConnect.connect();
}

@override
void initState() { 
  super.initState();
  connectSocket();
  
}
  


  TextEditingController textEditingController=new TextEditingController();
  GlobalKey<ScaffoldState>_globalKey=new GlobalKey<ScaffoldState>();
@override
Widget build(BuildContext context) {
  Size size=MediaQuery.of(context).size;
  return Scaffold(
    key: _globalKey,
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: size.width*0.7,
            height: size.height*0.1,
            child: TextField(
              controller: textEditingController,
              decoration: InputDecoration(hintText: "Enter your name"),
            ),
          ),
          Container(
            child: RaisedButton(
              child: Text("Enter"),
              onPressed: ()async{
                SharedPreferences preferences=await SharedPreferences.getInstance();
                preferences.setString("name", textEditingController.text.toString());
                 socketConnect=new SocketConnect();
                //socketConnect.emitUserSignup(textEditingController.text.toString());
             
               /* api.checkUser(textEditingController.text.toString()).then((value) => {
                  if(value.statusCode==409){
                    print("user already exits"),
                    _globalKey.currentState.showSnackBar(SnackBar(content: Text("Username already exits! try different username")))
                  }else{
                    Navigator.push(context, CupertinoPageRoute(builder: (context)=>Chat()))
                  }
                });*/
                //
                 Navigator.push(context, CupertinoPageRoute(builder: (context)=>MainPage()));
          }))
        ],
      ),
    ),
  );
}
}