import 'dart:convert';

import 'package:chat_app/UI/chat_main.dart';
import 'package:chat_app/core/enums.dart';
import 'package:chat_app/models/current_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api.dart';

class SignInModel extends ChangeNotifier{

API api=new API();


CurrentState currentState=new CurrentState();
SignInState signInState=SignInState.Failed;


Future signIn(String _email,String _password,BuildContext context)async{
  await api.signIn(_email, _password).then((value)async{
        currentState.presentState=PresentState.Idle;
            
         
        
          //print(parsed["searchres"][0]["userid"]);
          if(value.statusCode==200){
         
          print("Login successfully");
          var parsed=json.decode(value.body);
          signInState = SignInState.Success;
      
          notifyListeners();
          SharedPreferences prefs=await SharedPreferences.getInstance();
          prefs.setString("token", parsed["token"]);
          prefs.setString("username",parsed["searchres"][0]["username"]);
          prefs.setString("userid", parsed["searchres"][0]["userid"]);
          print(parsed);
          //prefs.setString("notificationId",parsed["seachres"][0]["notificationId"]);
          ///notification id here

           /* ScaffoldMessenger.of(context).showSnackBar(
             SnackBar(
               elevation: 10,
               backgroundColor: Colors.green,
               duration: Duration(seconds: 1),
               content: Text("Login successfully"))
           ).closed.then((value) => {
             Navigator.push(context, MaterialPageRoute(builder: (context)=>ChatMain()))
           });*/
           
          }
          else if(value.statusCode==401){
          currentState.presentState=PresentState.Idle;
          signInState=SignInState.Failed;
        
           notifyListeners();
              
            print("Wrong password");
          /* ScaffoldMessenger.of(context).showSnackBar(
             SnackBar(
               elevation: 10,
               backgroundColor: Colors.redAccent,
              
               content: Text("Incorrect Password or Email"))
           );*/
          }
          else{
          currentState.presentState=PresentState.Idle;
          signInState = SignInState.UserNotExits;
          
           notifyListeners();
              
            
            print("user does not exits");
           /* ScaffoldMessenger.of(context).showSnackBar(
             SnackBar(
               elevation: 10,
               backgroundColor: Colors.yellow,
           
               content: Text("User does not exits",style: TextStyle(color: Colors.black),))
           );*/
          }
          //if empty then user doesnt exits
          //if false wrong password
          //if true then everything alright
          //else nothing there should an error from server or database
        });
}





}